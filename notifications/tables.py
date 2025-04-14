import django_tables2 as tables
from .models import Notifications

class NotificationTable(tables.Table):
    # تحديد الأعمدة وترتيبها واسمائها بالعربية
    sender_username = tables.Column(accessor='sender.username', verbose_name='المرسل')
    recipient_display = tables.Column(empty_values=(), verbose_name='المستلم/النوع', orderable=False)
    send_time_formatted = tables.DateTimeColumn(accessor='send_time', format='Y-m-d H:i', verbose_name='وقت الإرسال')
    status_display = tables.Column(accessor='get_status_display', verbose_name='الحالة')
    notification_type_display = tables.Column(accessor='get_notification_type_display', verbose_name='نوع الإشعار')

    class Meta:
        model = Notifications
        template_name = "django_tables2/bootstrap5.html" # أو ثيم آخر يناسب تصميم الادمن
        fields = ('id', 'sender_username', 'recipient_display', 'message', 'send_time_formatted', 'status_display', 'notification_type_display', 'action_url')
        sequence = ('id', 'sender_username', 'recipient_display', 'message', 'send_time_formatted', 'status_display', 'notification_type_display', 'action_url') # ترتيب الأعمدة

    def render_recipient_display(self, record):
        return record.user.username if record.user else record.get_recipient_type_display()