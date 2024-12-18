from django.db import models
from django.conf import settings

class PermissionRequest(models.Model):
    STATUS_CHOICES = [
        ('pending', 'قيد الانتظار'),
        ('approved', 'تمت الموافقة'),
        ('rejected', 'مرفوض'),
    ]

    requester = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='permission_requests_sent',
        verbose_name='مقدم الطلب'
    )
    target_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='permission_requests_received',
        verbose_name='الموظف المستهدف'
    )
    permission_group = models.ForeignKey(
        'PermissionGroup',
        on_delete=models.CASCADE,
        verbose_name='مجموعة الصلاحيات'
    )
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name='الفندق'
    )
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='pending',
        verbose_name='حالة الطلب'
    )
    notes = models.TextField(
        blank=True,
        null=True,
        verbose_name='ملاحظات'
    )
    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name='تاريخ الإنشاء'
    )
    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name='تاريخ التحديث'
    )

    def clean(self):
        from django.core.exceptions import ValidationError
        # التحقق من أن مقدم الطلب لديه صلاحية إدارة الموظفين
        requester_permission = self.requester.get_active_permission_group()
        if not requester_permission or not requester_permission.can_manage_staff_for_hotel(self.hotel):
            raise ValidationError('ليس لديك صلاحية لإدارة موظفي هذا الفندق')
        
        # التحقق من أن الموظف المستهدف ينتمي لنفس الفندق
        target_permission = self.target_user.get_active_permission_group()
        if target_permission and target_permission.hotel != self.hotel:
            raise ValidationError('الموظف المستهدف لا ينتمي لهذا الفندق')

    def save(self, *args, **kwargs):
        self.clean()
        super().save(*args, **kwargs)

    class Meta:
        verbose_name = 'طلب صلاحيات'
        verbose_name_plural = 'طلبات الصلاحيات'
        ordering = ['-created_at']

    def __str__(self):
        return f"طلب صلاحيات من {self.requester.get_full_name()} لـ {self.target_user.get_full_name()}"
