from django.db import models
from HotelManagement.models import BaseModel
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _

class CustomUser(AbstractUser):
    USER_TYPE_CHOICES = [
        ('admin', _('مدير النظام')),
        ('hotel_manager', _('مدير فندق')),
        ('customer', _('عميل')),
    ]
    
    user_type = models.CharField(
        max_length=20,
        choices=USER_TYPE_CHOICES,
        verbose_name=_('نوع المستخدم')
    )
    phone = models.CharField(
        max_length=20,
        blank=True,
        verbose_name=_('رقم الهاتف')
    )
    image = models.ImageField(
        upload_to='user/%y/%m/%d',
        verbose_name=_('الصورة الشخصية')
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_('نشط')
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

    def __str__(self):
        return f"{self.username} ({self.get_user_type_display()})"

class HotelAccountRequest(BaseModel):
    STATUS_CHOICES = [
        ('pending', _('قيد الانتظار')),
        ('approved', _('تمت الموافقة')),
        ('rejected', _('مرفوض')),
        ('cancelled', _('ملغي')),
    ]

    hotel_name = models.CharField(max_length=255, verbose_name=_("اسم الفندق"))
    owner_name = models.CharField(max_length=255, verbose_name=_("اسم المالك"))
    email = models.EmailField(verbose_name=_("البريد الإلكتروني"))
    phone = models.CharField(max_length=20, verbose_name=_("رقم الهاتف"))
    hotel_description = models.TextField(verbose_name=_("وصف الفندق"))
    business_license_number = models.CharField(max_length=100, verbose_name=_("رقم الرخصة التجارية"))
    document_path = models.FileField(upload_to='hotel_documents/', verbose_name=_("مسار مستند الفندق"))
    verify_number = models.CharField(max_length=50, verbose_name=_("رقم التحقق"))
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='pending',
        verbose_name=_("حالة الطلب")
    )
    admin_notes = models.TextField(
        blank=True,
        default=None,
        verbose_name=_("ملاحظات المسؤول")
    )
    password = models.CharField(max_length=255, verbose_name=_("كلمة السر"))

    class Meta:
        verbose_name = _('طلب حساب فندق')
        verbose_name_plural = _('طلبات حسابات الفنادق')

    def __str__(self):
        return f"{self.hotel_name} - {self.get_status_display()}"

from django.db import models

class ActivityLog(models.Model):
    log_id = models.AutoField(primary_key=True)
    custom_user_id = models.ForeignKey('CustomUser', on_delete=models.CASCADE)
    table_name = models.CharField(max_length=100)
    record_id = models.IntegerField()
    action = models.CharField(max_length=50)
    changed_at = models.DateTimeField(auto_now_add=True)
