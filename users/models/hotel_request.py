from django.db import models
from django.utils.translation import gettext_lazy as _
from django.core.validators import RegexValidator
from HotelManagement.models import BaseModel

class HotelAccountRequest(BaseModel):
    STATUS_CHOICES = [
        ('pending', _('قيد الانتظار')),
        ('approved', _('تمت الموافقة')),
        ('rejected', _('مرفوض')),
        ('cancelled', _('ملغي')),
    ]
    
    hotel_name = models.CharField(
        max_length=100,
        verbose_name=_('اسم الفندق'),
        help_text=_('اسم الفندق كما سيظهر في النظام')
    )
    owner_name = models.CharField(
        max_length=100,
        verbose_name=_('اسم المالك'),
        help_text=_('الاسم الكامل لمالك الفندق')
    )
    email = models.EmailField(
        verbose_name=_('البريد الإلكتروني'),
        unique=True,
        help_text=_('البريد الإلكتروني الرسمي للفندق')
    )
    phone_regex = RegexValidator(
        regex=r'^\+?1?\d{9,15}$',
        message=_("رقم الهاتف يجب أن يكون بالصيغة: '+999999999'. يسمح بإدخال من 9 إلى 15 رقم.")
    )
    phone = models.CharField(
        max_length=20,
        validators=[phone_regex],
        verbose_name=_('رقم الهاتف'),
        help_text=_('رقم الهاتف الرسمي للفندق')
    )
    hotel_description = models.TextField(
        verbose_name=_('وصف الفندق'),
        help_text=_('وصف تفصيلي للفندق ومرافقه وخدماته')
    )
    business_license_number = models.CharField(
        max_length=50,
        verbose_name=_('رقم الرخصة التجارية'),
        null=True,
        blank=True,
        help_text=_('رقم الرخصة التجارية للفندق')
    )
    document_path = models.FileField(
        upload_to='hotel_documents/%Y/%m/%d/',
        verbose_name=_('مستندات الفندق'),
        help_text=_('المستندات الرسمية للفندق (رخصة العمل، السجل التجاري، إلخ)')
    )
    verify_number = models.CharField(
        max_length=50,
        verbose_name=_('رقم التحقق'),
        unique=True,
        help_text=_('رقم التحقق الخاص بطلب التسجيل')
    )
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='pending',
        verbose_name=_("حالة الطلب"),
        help_text=_('الحالة الحالية لطلب التسجيل')
    )
    admin_notes = models.TextField(
        blank=True,
        null=True,
        verbose_name=_("ملاحظات المسؤول"),
        help_text=_('ملاحظات المسؤول حول الطلب')
    )
    password = models.CharField(
        max_length=255,
        verbose_name=_("كلمة السر"),
        help_text=_('كلمة السر المؤقتة للحساب')
    )

    class Meta:
        verbose_name = _('طلب حساب فندق')
        verbose_name_plural = _('طلبات حسابات الفنادق')
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.hotel_name} - {self.owner_name}"
