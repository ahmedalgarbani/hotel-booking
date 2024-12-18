from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
from django.core.validators import RegexValidator
from django.core.exceptions import ValidationError
from django.utils import timezone
from HotelManagement.models import BaseModel

class CustomUser(AbstractUser):
    USER_TYPE_CHOICES = [
        ('admin', _('مدير النظام')),
        ('hotel_manager', _('مدير فندق')),
        ('receptionist', _('موظف استقبال')),
        ('booking_agent', _('مسؤول حجوزات')),
        ('housekeeping', _('مشرف نظافة')),
        ('maintenance', _('مسؤول صيانة')),
        ('accountant', _('محاسب')),
        ('customer', _('عميل')),
    ]
    
    user_type = models.CharField(
        max_length=20,
        choices=USER_TYPE_CHOICES,
        default='customer',
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
        null=True,
        verbose_name=_('رقم الهاتف'),
        help_text=_('رقم الهاتف مع رمز الدولة')
    )
    
    image = models.ImageField(
        upload_to='users/%Y/%m/%d/',
        blank=True,
        null=True,
        verbose_name=_('الصورة الشخصية'),
        help_text=_('الصورة الشخصية للمستخدم')
    )
    
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_('الفندق'),
        help_text=_('الفندق الذي يعمل به الموظف')
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
        verbose_name = _('مستخدم')
        verbose_name_plural = _('المستخدمين')
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['username']),
            models.Index(fields=['email']),
            models.Index(fields=['first_name', 'last_name']),
            models.Index(fields=['user_type']),
        ]

    def __str__(self):
        full_name = self.get_full_name()
        if full_name:
            return f"{full_name} ({self.username})"
        return self.username

    def get_full_name(self):
        if self.first_name or self.last_name:
            return f"{self.first_name} {self.last_name}".strip()
        return ""

    def clean(self):
        super().clean()
        if self.user_type not in [choice[0] for choice in self.USER_TYPE_CHOICES]:
            raise ValidationError(_('نوع المستخدم غير صالح'))

    @property
    def is_admin(self):
        return self.user_type == 'admin'

    @property
    def is_hotel_manager(self):
        return self.user_type == 'hotel_manager'

    @property
    def is_customer(self):
        return self.user_type == 'customer'
