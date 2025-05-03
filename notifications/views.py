from django.shortcuts import get_object_or_404, redirect, render
from django.http import JsonResponse

from notifications.forms import AdminNotificationForm
from users.models import CustomUser
from .models import Notifications
from django.views.decorators.csrf import csrf_exempt



def all_notifications(request,user_id):
    user = get_object_or_404(CustomUser,id=user_id)
    notifications = Notifications.objects.filter(user=user).order_by('-id')

    ctx ={
        'notifications':notifications
    }
    return render(request, 'admin/user_dashboard/pages/all_notifications.html',ctx)


def notifications_view(request):
    """عرض الإشعارات غير المقروءة فقط"""
    notifications = Notifications.objects.filter(user=request.user, status='0').order_by('-send_time')  # جلب غير المقروءة فقط
    return render(request, 'frontend/layout/menu.html', {'notifications': notifications})

@csrf_exempt
def mark_notifications_read(request):
    """تحديث جميع الإشعارات إلى مقروءة عند النقر"""
    if request.method == "POST":
        Notifications.objects.filter(user=request.user, status='0').update(status='1')
        return JsonResponse({"success": True})
    return JsonResponse({"success": False}, status=400)

@csrf_exempt
def mark_notification_read(request, notification_id):
    """تحديث إشعار واحد إلى مقروء"""
    if request.method == "POST":
        notification = get_object_or_404(Notifications, id=notification_id, user=request.user)
        notification.mark_as_read()
        return JsonResponse({"success": True})
    return JsonResponse({"success": False}, status=400)


def handle_notification(request, notification_id):
    notification = get_object_or_404(Notifications, id=notification_id, user=request.user)
    notification.mark_as_read()
    if not notification.action_url:
        return redirect('customer:user_dashboard_index')
    else:
        return redirect(notification.action_url)


