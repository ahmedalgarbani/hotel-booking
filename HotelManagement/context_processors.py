from notifications.models import Notifications

def notifications_context(request):
    if request.user.is_authenticated:
        notifications = Notifications.objects.filter(user=request.user, is_active=True).order_by('-send_time')
        unread_notifications_count = notifications.filter(status='0').count()
    else:
        notifications = []
        unread_notifications_count = 0

    return {
        'notifications': notifications,
        'unread_notifications_count': unread_notifications_count,
    }
