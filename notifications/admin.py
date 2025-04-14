# notifications/admin.py
from django.contrib import admin
from django import forms
from django.shortcuts import redirect, render
from django.urls import path, reverse  # <-- استيراد reverse
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseBadRequest  # <-- استيرادات ضرورية
from django.contrib import messages
from django.db.models import Q
import csv
import datetime
from django.utils.html import format_html  # <--- استيراد format_html
from django.utils.translation import gettext_lazy as _  # <--- استيراد للترجمة

# Assuming 'api.admin.admin_site' is your custom admin site instance
from api.admin import admin_site
from .models import Notifications

# --- Mixin لتتبع إجراءات المستخدم (احتفظ به إذا كنت تستخدمه في مكان آخر) ---
class AutoUserTrackMixin:
    def save_model(self, request, obj, form, change):
        if not change and hasattr(request, 'user') and request.user.is_authenticated:
            obj.created_by = request.user
        if hasattr(request, 'user') and request.user.is_authenticated:
            obj.updated_by = request.user
        super().save_model(request, obj, form, change)

# --- نموذج لإدارة الإشعارات (احتفظ به كما هو) ---
class NotificationForm(forms.ModelForm):
    class Meta:
        model = Notifications
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # اجعل حقل 'user' غير مطلوب إذا سمح نوع المستلم بذلك (مثل all_customers)
        if 'user' in self.fields and self.instance and self.instance.recipient_type != 'single_user':
            self.fields['user'].required = False
        elif 'user' in self.fields:
            pass  # قد يكون مطلوبًا لـ 'single_user' عند الإنشاء إذا لم يتم التعامل معه في مكان آخر

# --- إجراء المسؤول للمعاينة والتصدير ---
def preview_and_export_notifications(modeladmin, request, queryset):
    """إجراء المسؤول لإعادة توجيه الإشعارات المحددة إلى صفحة المعاينة."""
    if not queryset:
        messages.warning(request, _("لم يتم تحديد أي إشعارات للتصدير."))
        return

    selected_ids = ','.join(str(pk) for pk in queryset.values_list('pk', flat=True))
    # إعادة التوجيه إلى عرض المسؤول المخصص مع المعرفات المحددة
    preview_url = reverse('admin:notifications_notification_preview')  # استخدم الاسم الصحيح المحدد في get_urls
    return redirect(f'{preview_url}?ids={selected_ids}')

# --- وصف مختصر للإجراء في واجهة المسؤول ---
preview_and_export_notifications.short_description = _("معاينة وتصدير الإشعارات المحددة")

# --- تكوين إدارة الإشعارات ---
class NotificationsAdmin(AutoUserTrackMixin, admin.ModelAdmin):
    form = NotificationForm
    list_display = ('sender_display', 'recipient_info', 'message_snippet', 'send_time_formatted', 'status_display', 'notification_type_display', 'is_active')
    list_filter = ('status', 'notification_type', 'is_active', 'send_time', 'recipient_type', 'sender')
    search_fields = ('sender__username', 'user__username', 'message', 'title')  # إضافة العنوان للبحث
    ordering = ('-send_time',)
    # إضافة الإجراء الجديد، احتفظ بالإجراءات الحالية إذا لزم الأمر
    actions = ['mark_as_read', 'mark_as_unread', preview_and_export_notifications]
    # احتفظ بالحقول المخصصة للقراءة فقط، تأكد من أن 'sender' قابلة للتحرير عند الإنشاء إذا لزم الأمر
    readonly_fields = ('created_at', 'updated_at', 'send_time', 'created_by', 'updated_by', 'deleted_at')

    # ---- طرق عرض مخصصة لـ list_display ----
    def sender_display(self, obj):
        return obj.sender.username if obj.sender else 'N/A'
    sender_display.short_description = _("المرسل")
    sender_display.admin_order_field = 'sender__username'

    def recipient_info(self, obj):
        if obj.user:
            return obj.user.username
        return obj.get_recipient_type_display()
    recipient_info.short_description = _("المستلم/النوع")

    def message_snippet(self, obj):
        return format_html('<span title="{}">{}...</span>', obj.message, obj.message[:50])
    message_snippet.short_description = _("الرسالة (مقتطف)")

    def send_time_formatted(self, obj):
        return obj.send_time.strftime('%Y-%m-%d %H:%M') if obj.send_time else '-'
    send_time_formatted.short_description = _("وقت الإرسال")
    send_time_formatted.admin_order_field = 'send_time'

    def status_display(self, obj):
        # إضافة الألوان للحالة
        status_colors = {
            '0': 'orange',  # غير مقروء
            '1': 'green',   # مقروء
        }
        color = status_colors.get(obj.status, 'black')
        return format_html('<span style="color: {}; font-weight: bold;">{}</span>', color, obj.get_status_display())
    status_display.short_description = _("الحالة")
    status_display.admin_order_field = 'status'

    def notification_type_display(self, obj):
        # إضافة الألوان للنوع
        type_colors = {
            '0': 'blue',    # معلومة
            '1': 'darkorange', # تحذير
            '2': 'green',   # نجاح
            '3': 'red',     # خطأ
        }
        color = type_colors.get(obj.notification_type, 'black')
        return format_html('<span style="color: {};">{}</span>', color, obj.get_notification_type_display())
    notification_type_display.short_description = _("نوع الإشعار")
    notification_type_display.admin_order_field = 'notification_type'

    # ---- طرق إدارة مخصصة ----
    def get_fields(self, request, obj=None):
        """تخصيص الحقول المعروضة في النموذج"""
        fields = list(super().get_fields(request, obj))
        if obj is None:  # في نموذج الإنشاء
            if 'sender' in fields and 'sender' not in self.readonly_fields:
                pass  # السماح بتحديد المرسل إذا كان مشرفًا وليس للقراءة فقط
            elif 'sender' in fields:
                fields.remove('sender')

        if not request.user.is_superuser and not request.user.user_type == 'admin':
            if 'recipient_type' in fields:
                fields.remove('recipient_type')  # غير المشرفين لا يجب أن يختاروا نوع المستلم بشكل عام
        return fields

    def get_form(self, request, obj=None, **kwargs):
        """تخصيص النموذج بناءً على المستخدم"""
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and not request.user.user_type == 'admin':
            if 'user' in form.base_fields:
                pass
            if 'recipient_type' in form.base_fields:
                form.base_fields['recipient_type'].disabled = True
                form.base_fields['recipient_type'].initial = 'single_user'
        return form

    def save_model(self, request, obj, form, change):
        """تعيين المرسل تلقائيًا، التعامل مع أنواع المستلمين العامة"""
        is_new = not change
        user = request.user

        if is_new:
            obj.sender = user
            recipient_type = form.cleaned_data.get('recipient_type', 'single_user')
            user_recipient = form.cleaned_data.get('user')
            title = form.cleaned_data.get('title', 'Notification')
            message = form.cleaned_data.get('message', '')
            notification_type = form.cleaned_data.get('notification_type', '0')
            action_url = form.cleaned_data.get('action_url')

            if user.is_superuser or user.user_type == 'admin':
                users_to_notify = []
                success_msg = None

                if recipient_type == 'all_customers':
                    users_to_notify = CustomUser.objects.filter(user_type='customer', is_active=True)
                    success_msg = _("تم إرسال الإشعار إلى جميع العملاء ({} مستخدم)")
                elif recipient_type == 'all_hotel_managers':
                    users_to_notify = CustomUser.objects.filter(user_type='hotel_manager', is_active=True)
                    success_msg = _("تم إرسال الإشعار إلى جميع مديري الفنادق ({} مستخدم)")

                if users_to_notify:
                    created_count = 0
                    for target_user in users_to_notify:
                        Notifications.objects.create(
                            sender=user,
                            user=target_user,
                            recipient_type=recipient_type,
                            title=title,
                            message=message,
                            notification_type=notification_type,
                            action_url=action_url,
                            created_by=user,
                            updated_by=user
                        )
                        created_count += 1
                    if success_msg:
                        messages.success(request, success_msg.format(created_count))
                    return
            elif user.user_type == 'hotel_manager':
                if recipient_type == 'booked_customers':
                    messages.warning(request, _("إرسال لإشعارات للحاجزين غير مفعل حالياً."))
                    return

            if recipient_type == 'single_user' and not user_recipient:
                messages.error(request, _("يجب تحديد مستلم عند اختيار 'مستخدم واحد'"))
                return

            obj.recipient_type = recipient_type
            super().save_model(request, obj, form, change)

        else:
            super().save_model(request, obj, form, change)

    # ---- الإجراءات ----
    def mark_as_read(self, request, queryset):
        updated_count = queryset.update(status='1')
        self.message_user(request, _("{} إشعارات تم تحديدها كمقروءة.").format(updated_count))
    mark_as_read.short_description = _("تحديد كمقروء")

    def mark_as_unread(self, request, queryset):
        updated_count = queryset.update(status='0')
        self.message_user(request, _("{} إشعارات تم تحديدها كغير مقروءة.").format(updated_count))
    mark_as_unread.short_description = _("تحديد كغير مقروء")

    # ---- تجاوز الأذونات و QuerySet (احتفظ بها كما هي) ----
    def get_readonly_fields(self, request, obj=None):
        base_readonly = list(self.readonly_fields)
        if obj:
            if 'sender' not in base_readonly:
                base_readonly.append('sender')
        else:
            if not request.user.is_superuser and 'sender' in base_readonly:
                pass
            elif not request.user.is_superuser and 'sender' not in base_readonly:
                base_readonly.append('sender')

        if not request.user.is_superuser:
            pass

        return tuple(base_readonly)

    def get_queryset(self, request):
        """تصفية الإشعارات بناءً على نوع المستخدم"""
        queryset = super().get_queryset(request)
        user = request.user
        if user.is_superuser or user.user_type == 'admin':
            return queryset
        elif user.user_type == 'hotel_manager':
            return queryset.filter(Q(sender=user) | Q(user=user))
        elif user.user_type == 'hotel_staff':
            q_filter = Q(user=user)
            if hasattr(user, 'chield') and user.chield:
                q_filter |= Q(sender=user.chield)
            return queryset.filter(q_filter)
        return queryset.none()

    # ---- عنوان URL مخصص لعرض المسؤول و طريقة ----
    def get_urls(self):
        """إضافة نمط URL لعرض المعاينة"""
        urls = super().get_urls()
        custom_urls = [
            path(
                'preview/',
                self.admin_site.admin_view(self.notification_preview_view),
                name='notifications_notification_preview'
            ),
        ]
        return custom_urls + urls

    def notification_preview_view(self, request):
        """طريقة داخل فئة المسؤول التي تستدعي وظيفة العرض الفعلية."""
        from .views import notification_preview_export_view
        return notification_preview_export_view(request)

# --- تسجيل فئة الإدارة مع موقع المسؤول المخصص ---
admin_site.register(Notifications, NotificationsAdmin)

