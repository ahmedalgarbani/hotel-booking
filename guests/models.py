from django.conf import settings
from django.db import models
from HotelManagement.models import BaseModel,Hotel
from django.utils.translation import gettext_lazy as _
class Guest(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        related_name='guests',
        verbose_name=_("الفندق")
    )
    account = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='guest_profile',
        verbose_name=_("الحساب")
    )
    guest_name = models.CharField(
        max_length=255,
        verbose_name=_("اسم النزيل")
    )
    guest_phone = models.CharField(
        max_length=20,
        verbose_name=_("رقم الهاتف")
    )
    guest_email = models.EmailField(
        verbose_name=_("البريد الإلكتروني")
    )
    guest_address = models.TextField(
        null=True,
        blank=True,
        verbose_name=_("العنوان")
    )
    guest_nationality = models.CharField(
        max_length=100,
        null=True,
        blank=True,
        verbose_name=_("الجنسية")
    )
    guest_dob = models.DateField(
        null=True,
        blank=True,
        verbose_name=_("تاريخ الميلاد")
    )
    guest_id_type = models.CharField(
        max_length=50,
        null=True,
        blank=True,
        verbose_name=_("نوع الهوية")
    )
    guest_id_number = models.CharField(
        max_length=100,
        null=True,
        blank=True,
        verbose_name=_("رقم الهوية")
    )
   
    
    special_requests = models.TextField(
        null=True,
        blank=True,
        verbose_name=_("طلبات خاصة")
    )
    notes = models.TextField(
        null=True,
        blank=True,
        verbose_name=_("ملاحظات")
    )
   

    class Meta:
        verbose_name = _("نزيل")
        verbose_name_plural = _("النزلاء")
        db_table = 'guests'

    def __str__(self):
        return self.guest_name

    def clean(self):
        if not self.guest_phone and not self.guest_email:
            raise ValidationError(_("يجب توفير رقم الهاتف أو البريد الإلكتروني على الأقل"))
# Create your models here.
