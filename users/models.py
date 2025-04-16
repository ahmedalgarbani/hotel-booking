import random
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
from django.core.validators import RegexValidator


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
        verbose_name=_('رقم الهاتف'),
        help_text=_('رقم الهاتف مع رمز الدولة')
    )
    
    image = models.ImageField(
        upload_to='users/%Y/%m/%d/',
        verbose_name=_('الصورة الشخصية'),
        blank=True,
        help_text=_('الصورة الشخصية للمستخدم')
    )
    gender = models.CharField(
        max_length=10,
        choices=[('Male', _('Male')), ('Female', _('Female'))],
        verbose_name=_("الجنس"),
        null=True
    )
    birth_date = models.DateField(verbose_name=_("تاريخ الميلاد"),        null=True
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
    chart = models.ForeignKey(
        'accounts.ChartOfAccounts',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_('الحساب المرتبط'),
        related_name='charts',
        help_text=_('الحساب المرتبط')
    )
    otp_code = models.CharField(max_length=6, blank=True, null=True)
    otp_created_at = models.DateTimeField(blank=True, null=True)

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
    
    # def save(self, *args, **kwargs):
    #     if self._state.adding: 
    #         from social_django.models import UserSocialAuth
    #         from accounts.models import ChartOfAccounts
    #         from accounts.services import create_chart_of_account 
    #         from django.db import transaction
    #         social_account = UserSocialAuth.objects.filter(id=19)

    #         if social_account:
    #             extra_data = social_account.extra_data
    #             gender = extra_data.get('gender', 'Not specified')
    #             birthday = extra_data.get('birthday', 'Not specified')
    #             picture = extra_data.get('picture', 'Default image URL')
    #             print(f"Gender: {gender}, Birthday: {birthday}, Picture: {picture}")
    #         else:
    #             print("No Google account linked with this user.")

    #         print("First Name:", self.first_name)

    #         random_number = random.randint(1000, 9999)
    #         chart = create_chart_of_account(
    #             account_number=f"110{random_number}",
    #             account_name=f"عملاء دائمون - {self.first_name} {self.last_name}",
    #             account_type="Assets",
    #             account_balance=0,
    #             account_parent=ChartOfAccounts.objects.get(account_number="1100"),
    #             account_description="الحسابات المدينة / العملاء",
    #             account_status=True,
    #         )

    #         self.chart = chart
        
    #     super().save(*args, **kwargs)
    
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