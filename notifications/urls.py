from django.urls import path # type: ignore #
from .views import notifications_view, mark_notifications_read,handle_notification,all_notifications

app_name = 'notifications'

urlpatterns = [
    path('notifications/', notifications_view, name='notifications'),
    path('all_notifications/<int:user_id>', all_notifications, name='all_notifications'),
    path('notifications/read/', mark_notifications_read, name='mark_notifications_read'),
    path('notifications/<int:notification_id>/', handle_notification, name='handle_notification'),
]