from django.urls import path # type: ignore #
from .views import notifications_view, mark_notifications_read

urlpatterns = [
    path('notifications/', notifications_view, name='notifications'),
    path('notifications/read/', mark_notifications_read, name='mark_notifications_read'),
]