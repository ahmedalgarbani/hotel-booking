from django.db import models
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import BaseModel
from users.models import CustomUser

class Notifications(BaseModel):
    sender = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        related_name='sent_notifications',
        verbose_name=_("المرسل")
    )
    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        related_name='received_notifications',
        verbose_name=_("المستلم"),
        null=True,
        blank=True
    )
    recipient_type = models.CharField(
        max_length=50,
        choices=[
            ('all_customers', _("كل العملاء")),
            ('all_hotel_managers', _("كل مديري الفنادق")),
            ('booked_customers', _("العملاء الحاليين")),
            ('single_user', _("مستخدم واحد")),
        ],
        default='single_user',
        verbose_name=_("نوع المستلم")
    )
    title = models.CharField(verbose_name=_("العنوان"),max_length=255)
    message = models.TextField(verbose_name=_("الرسالة"))
    send_time = models.DateTimeField(
        auto_now_add=True,
        verbose_name=_("وقت الإرسال")
    )
    status = models.CharField(
        max_length=50,
        choices=[
            ('0', _("غير مقروء")),
            ('1', _("مقروء")),
        ],
        default='0',
        verbose_name=_("الحالة")
    )
    notification_type = models.CharField(
        max_length=50,
        choices=[
            ('0', _("معلومة")),
            ('1', _("تحذير")),
            ('2', _("نجاح")),
            ('3', _("خطأ")),
        ],
        verbose_name=_("نوع الإشعار")
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_("نشط")
    )
    action_url = models.CharField(
        max_length=255,
        blank=True,
        null=True,
        verbose_name=_("رابط الإجراء")
    )

    class Meta:
        verbose_name = _("إشعار")
        verbose_name_plural = _("الإشعارات")
        ordering = ['-send_time']

    def __str__(self):
        if self.user:
            return f"إشعار من {self.sender} إلى {self.user} - {self.notification_type}"
        return f"إشعار من {self.sender} إلى {self.get_recipient_type_display()} - {self.notification_type}"

    def mark_as_read(self):
        """تحديث الإشعار إلى مقروء"""
        if self.status != '1':
            self.status = '1'
            self.save()

    def mark_as_unread(self):
        """تحديث الإشعار إلى غير مقروء"""
        if self.status != '0':
            self.status = '0'
            self.save()

    @property
    def get_notification_type_class(self):
        type_map = {
            '0': 'info',
            '1': 'warning',
            '2': 'success',
            '3': 'danger'
        }
        return type_map.get(self.notification_type, 'info')

    @property
    def get_icon_class(self):
        """الحصول على أيقونة الإشعار بناءً على نوعه"""
        icon_map = {
            '0': 'info-circle',  # معلومة
            '1': 'exclamation-triangle',  # تحذير
            '2': 'check-circle',  # نجاح
            '3': 'times-circle'   # خطأ
        }
        return icon_map.get(self.notification_type, 'bell')