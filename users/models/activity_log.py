from django.db import models
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import BaseModel
from django.conf import settings

class ActivityLog(BaseModel):
    ACTION_CHOICES = [
        ('create', _('إنشاء')),
        ('update', _('تحديث')),
        ('delete', _('حذف')),
        ('login', _('تسجيل دخول')),
        ('logout', _('تسجيل خروج')),
    ]
    
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        verbose_name=_('المستخدم'),
        related_name='activity_logs',
        help_text=_('المستخدم الذي قام بالإجراء')
    )
    table_name = models.CharField(
        max_length=100,
        verbose_name=_('اسم الجدول'),
        help_text=_('اسم الجدول الذي تم تنفيذ الإجراء عليه')
    )
    record_id = models.IntegerField(
        verbose_name=_('معرف السجل'),
        help_text=_('معرف السجل الذي تم تنفيذ الإجراء عليه')
    )
    action = models.CharField(
        max_length=50,
        choices=ACTION_CHOICES,
        verbose_name=_('الإجراء'),
        help_text=_('نوع الإجراء الذي تم تنفيذه')
    )
    details = models.JSONField(
        null=True,
        blank=True,
        verbose_name=_('تفاصيل'),
        help_text=_('تفاصيل إضافية عن الإجراء')
    )
    ip_address = models.GenericIPAddressField(
        null=True,
        blank=True,
        verbose_name=_('عنوان IP'),
        help_text=_('عنوان IP للمستخدم')
    )

    class Meta:
        verbose_name = _('سجل النشاط')
        verbose_name_plural = _('سجلات النشاط')
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['user', '-created_at']),
            models.Index(fields=['table_name', 'record_id']),
        ]

    def __str__(self):
        return f"{self.user.username} - {self.get_action_display()} - {self.created_at}"
