from django.shortcuts import render
from django.http import JsonResponse
from .models import Notifications
from django.views.decorators.csrf import csrf_exempt

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