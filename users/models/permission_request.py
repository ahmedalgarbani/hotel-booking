from django.db import models
from django.conf import settings
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import Hotel

class PermissionRequest(models.Model):
    STATUS_CHOICES = (
        ('pending', _('معلق')),
        ('approved', _('مقبول')),
        ('rejected', _('مرفوض')),
    )

    requester = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='permission_requests_sent',
        verbose_name=_('مقدم الطلب')
    )
    target_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='permission_requests_received',
        verbose_name=_('المستخدم المستهدف')
    )
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        related_name='permission_requests',
        verbose_name=_('الفندق')
    )
    requested_permissions = models.TextField(
        verbose_name=_('الصلاحيات المطلوبة'),
        help_text=_('وصف للصلاحيات المطلوبة')
    )
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='pending',
        verbose_name=_('الحالة')
    )
    admin_notes = models.TextField(
        blank=True,
        null=True,
        verbose_name=_('ملاحظات الإدارة')
    )
    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name=_('تاريخ الإنشاء')
    )
    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name=_('تاريخ التحديث')
    )

    class Meta:
        verbose_name = _('طلب صلاحية')
        verbose_name_plural = _('طلبات الصلاحيات')
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.requester} -> {self.target_user} ({self.get_status_display()})"