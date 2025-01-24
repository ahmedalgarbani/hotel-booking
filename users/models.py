from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
from django.core.validators import RegexValidator
from django.core.exceptions import ValidationError
from django.utils import timezone

class CustomUser(AbstractUser):
    created_at = models.DateTimeField(auto_now_add=True, verbose_name=_('تاريخ الإنشاء'), help_text=_('تاريخ إنشاء الحساب'))
    updated_at = models.DateTimeField(auto_now=True, verbose_name=_('تاريخ التحديث'), help_text=_('تاريخ آخر تحديث للحساب'))

    USER_TYPE_CHOICES = [
        ('admin', _('مدير النظام')),
        ('hotel_manager', _('مدير فندق')),
        ('customer', _('عميل')),
        ('hotel_staff',_('موظف')),
        
    ]
    
    user_type = models.CharField(
        max_length=20,
        choices=USER_TYPE_CHOICES,
        verbose_name=_('نوع المستخدم'),
        help_text=_('نوع حساب المستخدم في النظام')
    )
    
    phone_regex = RegexValidator(
        regex=r'^\+?1?\d{9,15}$',
        message=_("رقم الهاتف يجب أن يكون بالصيغة: '+999999999'. يسمح بإدخال من 9 إلى 15 رقم.")
    )
    phone = models.CharField(
        max_length=20,
        validators=[phone_regex],
        blank=True,
        verbose_name=_('رقم الهاتف'),
        help_text=_('رقم الهاتف مع رمز الدولة')
    )
    
    image = models.ImageField(
        upload_to='users/%Y/%m/%d/',
        verbose_name=_('الصورة الشخصية'),
        blank=True,
        help_text=_('الصورة الشخصية للمستخدم')
    )
    
    is_active = models.BooleanField(
        default=True,
        verbose_name=_('نشط'),
        help_text=_('يشير إلى ما إذا كان هذا المستخدم نشطًا أم لا')
    )
    
    chield = models.ForeignKey(
        'self',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_('الموظف المعين'),
        related_name='employees',
        help_text=_('الموظف المعين من قبل مدير الفندق')
    )

    class Meta:
        verbose_name = _('مستخدم')
        verbose_name_plural = _('المستخدمين')
        ordering = ['-created_at']

    def __str__(self):
        full_name = self.get_full_name()
        return f"{full_name or self.username}"

    
    @property
    def is_hotel_manager(self):
        return self.user_type == 'hotel_manager'

    @property
    def is_customer(self):
        return self.user_type == 'customer'

class ActivityLog(models.Model):
    created_at = models.DateTimeField(auto_now_add=True, verbose_name=_('تاريخ الإنشاء'), help_text=_('تاريخ إنشاء السجل'))
    updated_at = models.DateTimeField(auto_now=True, verbose_name=_('تاريخ التحديث'), help_text=_('تاريخ آخر تحديث للسجل'))

    ACTION_CHOICES = [
        ('create', _('إنشاء')),
        ('update', _('تحديث')),
        ('delete', _('حذف')),
        ('login', _('تسجيل دخول')),
        ('logout', _('تسجيل خروج')),
    ]

    user = models.ForeignKey(
        CustomUser,
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
        return f"{self.user.get_full_name()} - {self.get_action_display()} - {self.created_at}"