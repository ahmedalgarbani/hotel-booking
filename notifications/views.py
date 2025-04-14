# notifications/views.py

from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponseBadRequest, HttpResponse, JsonResponse
from django.contrib.admin.views.decorators import staff_member_required
from django.views.decorators.csrf import csrf_exempt
from django_tables2 import RequestConfig
from django.db.models import Count, Q
from django.utils.translation import gettext_lazy as _
import csv
import datetime

from .models import Notifications
from .tables import NotificationTable
from users.models import CustomUser
from api.admin import admin_site

# --- دالة العرض للمعالجة والتصدير مع الإحصائيات ---
@staff_member_required
def notification_preview_export_view(request):
    notification_ids_str = request.GET.get('ids')
    export_format = request.GET.get('format')

    if not notification_ids_str:
        return HttpResponseBadRequest(_("لم يتم تحديد إشعارات."))

    try:
        notification_ids = [int(id) for id in notification_ids_str.split(',')]
        queryset = Notifications.objects.filter(
            pk__in=notification_ids
        ).select_related('sender', 'user').order_by('-send_time')
        if not queryset.exists():
             raise Notifications.DoesNotExist
    except ValueError:
        return HttpResponseBadRequest(_("معرفات إشعارات غير صالحة."))
    except Notifications.DoesNotExist:
         return HttpResponseBadRequest(_("لم يتم العثور على الإشعارات المحددة."))

    # --- إذا كان الطلب للتصدير ---
    if export_format:
        if export_format == 'csv':
            response = HttpResponse(content_type='text/csv; charset=utf-8-sig')
            response['Content-Disposition'] = 'attachment; filename=notifications_report_{}.csv'.format(
                datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
            )
            writer = csv.writer(response)
            headers = [
                'ID', _('المرسل'), _('المستلم/النوع'), _('العنوان'), _('الرسالة'),
                _('وقت الإرسال'), _('الحالة'), _('نوع الإشعار'), _('رابط الإجراء')
            ]
            writer.writerow(headers)
            for notification in queryset:
                recipient_display = notification.user.username if notification.user else notification.get_recipient_type_display()
                row = [
                    notification.id,
                    notification.sender.username if notification.sender else 'N/A',
                    recipient_display,
                    notification.title,
                    notification.message,
                    notification.send_time.strftime('%Y-%m-%d %H:%M') if notification.send_time else '',
                    notification.get_status_display(),
                    notification.get_notification_type_display(),
                    notification.action_url if notification.action_url else '',
                ]
                writer.writerow(row)
            return response
        # --- يمكنك إضافة منطق Excel أو PDF هنا ---
        else:
            return HttpResponseBadRequest(_("صيغة تصدير غير مدعومة."))

    # --- إذا كان الطلب للمعاينة (GET بدون format) ---
    else:
        # ---- حساب الإحصائيات ----
        total_count = queryset.count()
        read_count = queryset.filter(status='1').count()
        unread_count = total_count - read_count

        # عدد الإشعارات حسب النوع
        type_counts_query = queryset.values('notification_type').annotate(count=Count('id')).order_by('notification_type')
        type_counts = {item['notification_type']: item['count'] for item in type_counts_query}

        # ***** التعديل هنا *****
        # الحصول على choices من الحقل مباشرة
        notification_type_choices_dict = dict(Notifications._meta.get_field('notification_type').choices)
        type_display_counts = {
            notification_type_choices_dict.get(code, code): count # استخدام القاموس الجديد
            for code, count in type_counts.items()
        }
        # ***** نهاية التعديل *****

        # عدد الرسائل لكل مستلم (مع تجاهل الإشعارات بدون مستلم محدد)
        user_counts_query = queryset.filter(user__isnull=False).values('user__username').annotate(count=Count('id')).order_by('-count')
        user_counts = list(user_counts_query)
        # -------------------------

        table = NotificationTable(queryset)
        RequestConfig(request, paginate={"per_page": 25}).configure(table)

        context = {
            'title': _('معاينة الإشعارات للتصدير'),
            'table': table,
            'selected_ids': notification_ids_str,
            'opts': Notifications._meta,
            'site_header': admin_site.site_header,
            'site_title': admin_site.site_title,
            'has_permission': True,
            'is_popup': False,
            'is_nav_sidebar_enabled': True,
            'available_apps': admin_site.get_app_list(request),

            # --- تمرير الإحصائيات إلى القالب ---
            'total_count': total_count,
            'read_count': read_count,
            'unread_count': unread_count,
            'type_counts': type_display_counts,
            'user_counts': user_counts,
            # ------------------------------------
        }
        return render(request, 'admin/notifications/notification_preview.html', context)

# --- باقي دوال العرض (all_notifications, notifications_view, etc.) ---
def all_notifications(request, user_id):
    user = get_object_or_404(CustomUser, id=user_id)
    notifications = Notifications.objects.filter(user=user).order_by('-send_time')
    ctx = {
        'notifications': notifications,
        'viewed_user': user
    }
    return render(request, 'admin/user_dashboard/pages/all_notifications.html', ctx)

def notifications_view(request):
    if request.user.is_authenticated:
        notifications = Notifications.objects.filter(user=request.user, status='0').order_by('-send_time')
    else:
        notifications = Notifications.objects.none()
    return render(request, 'frontend/layout/menu.html', {'notifications': notifications})

@csrf_exempt
@staff_member_required # أو login_required
def mark_notifications_read(request):
    if request.method == "POST" and request.user.is_authenticated:
        updated_count = Notifications.objects.filter(user=request.user, status='0').update(status='1')
        return JsonResponse({"success": True, "updated_count": updated_count})
    return JsonResponse({"success": False, "error": "Invalid request"}, status=400)

@staff_member_required # أو login_required
def handle_notification(request, notification_id):
    notification = get_object_or_404(Notifications, id=notification_id, user=request.user)
    notification.mark_as_read()
    if notification.action_url:
        return redirect(notification.action_url)
    else:
        return redirect(reverse('admin:notifications_notification_changelist'))