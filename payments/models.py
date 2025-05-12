from pyexpat import model
from django.db import models
from django.conf import settings
from django.forms import ValidationError
from django.utils import timezone
from HotelManagement.models import BaseModel, Hotel
from django.utils.translation import gettext_lazy as _
from django.contrib.auth import get_user_model

from users.models import CustomUser


# ------------Currency-------------
class Currency(BaseModel):
    currency_name = models.CharField(max_length=50, verbose_name=_("اسم العملة"))
    currency_symbol = models.CharField(max_length=10, verbose_name=_("رمز العملة"))
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='currencies'
    )

    class Meta:
        verbose_name = _("عملة")
        verbose_name_plural = _("العملات")
        ordering = ['currency_name']

    def __str__(self):
        return f"{self.currency_name} ({self.currency_symbol})"




# ------------PaymentOption-------------
class PaymentOption(BaseModel):
    method_name = models.CharField(max_length=100, verbose_name=_("اسم طريقة الدفع"))
    logo = models.ImageField(upload_to='payment_logos/', null=True, blank=True, verbose_name=_("شعار"))
    currency = models.ForeignKey(
        Currency,
        on_delete=models.CASCADE,
        verbose_name=_("العملة"),
        related_name='payment_options'
    )
    is_active = models.BooleanField(default=True, verbose_name=_("نشط"))

    def __str__(self):
        status = _("مفعّل") if self.is_active else _("معطّل")
        return f"{self.method_name} - {self.currency.currency_name} ({status})"

    class Meta:
        verbose_name = _("طريقة دفع")
        verbose_name_plural = _("طرق الدفع")

# ------------HotelPaymentMethod-------------


class HotelPaymentMethod(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        related_name='payment_methods',
        verbose_name=_("الفندق")
    )
    payment_option = models.ForeignKey(
        PaymentOption,
        on_delete=models.CASCADE,
        verbose_name=_("طريقة الدفع")
    )
    account_name = models.CharField(max_length=100, verbose_name=_("اسم الحساب"),null=True, blank=True)
    account_number = models.CharField(max_length=50, verbose_name=_("رقم الحساب"),null=True, blank=True)
    iban = models.CharField(max_length=50, verbose_name=_("رقم الآيبان"),null=True, blank=True)
    description = models.TextField(verbose_name=_("تعليمات الدفع"), blank=True, null=True)
    is_active = models.BooleanField(default=True, verbose_name=_("نشط"))

    

    def __str__(self):
        return f"{self.hotel.name} - {self.payment_option.method_name}"

    class Meta:
        verbose_name = 'طريقة دفع الفندق'
        verbose_name_plural = 'طرق دفع الفندق'
        unique_together = ['hotel', 'payment_option']


# ------------Payment-------------
class Payment(BaseModel):
    payment_choice = [(0, "قيد الانتظار"), (1, "تم الدفع"), (2, "مرفوض")]
    payment_types_choice = [('e_pay', "إلكتروني"), ('cash', "نقدي")]
    booking = models.ForeignKey(
        'bookings.Booking',  
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='payments'
    )
    payment_method = models.ForeignKey(
        HotelPaymentMethod,
        on_delete=models.CASCADE,
        verbose_name=_("طريقة الدفع")
    )
    user = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        verbose_name=_("المستخدم"),
        related_name='payments',
        null=True,
        blank=True
    )
    transfer_image = models.ImageField(
        verbose_name=_("صورة السند الدفع"),
        upload_to='payments/transfer/transfer_image/',
        null=True,
        blank=True
    )
    payment_status = models.IntegerField(
        choices=payment_choice,
        verbose_name=_("حالة الدفع"),
        default=0
    )
    payment_date = models.DateTimeField(
        verbose_name=_("تاريخ الدفع"),
        default=timezone.now
    )
    payment_subtotal = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("المبلغ الفرعي")
    )
    payment_totalamount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("المبلغ الإجمالي")
    )
    payment_currency = models.CharField(
        max_length=10,
        verbose_name=_("العملة")
    )
    payment_type = models.CharField(
        max_length=10,
        choices=payment_types_choice,
        verbose_name=_("نوع الدفع")
    )
    payment_note = models.TextField(
        verbose_name=_("ملاحظات الدفع"),
        blank=True,
        null=True
    )
    payment_discount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name=_("قيمة الخصم"), default=0)
    payment_discount_code = models.CharField(
       max_length=100,
        verbose_name=_("كود الخصم"),
        null=True,
        blank=True
       )
    
    class Meta:
        verbose_name = _("دفعة")
        verbose_name_plural = _("الدفعات")
        ordering = ['-payment_date']

    def __str__(self):
        return f"دفعة #{self.id} لحجز {self.id}"
    def clean(self):
        super().clean()
        if self.booking.hotel != self.payment_method.hotel:
            raise ValidationError({
                        'payment_method': _("يجب ان تكون طريقه الدفع مرتبطه بنفس الفندق ")
                    })
    @property
    def get_status_class(self):
        status_map = {
            0: 'warning',
            1: 'success',
            2: 'danger'
        }
        return status_map.get(self.payment_status, 'info')
    
    @property
    def get_status_icon(self):
        icon_map = {
            0: 'clock',
            1: 'check',
            2: 'times'
        }
        return icon_map.get(self.payment_status, 'clock')


  
# ------ history payment --------------



class PaymentHistory(BaseModel):
    payment_choice = [(0, "قيد الانتظار"), (1, "تم الدفع"), (2, "مرفوض")]
    payment = models.ForeignKey(
        Payment,
        on_delete=models.CASCADE,
        verbose_name=_("الدفعة"),
        related_name='history_entries'
    )

    history_date = models.DateTimeField(
        auto_now_add=True,
        verbose_name=_("تاريخ التعديل")
    )
    changed_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_("المستخدم الذي قام بالتغيير")
    )
    previous_payment_status = models.IntegerField(
        choices=Payment.payment_choice,
        verbose_name=_("حالة الدفع السابقة"),
        null=True,
        blank=True
    )
    new_payment_status = models.IntegerField(
        choices=Payment.payment_choice,
        verbose_name=_("حالة الدفع الجديدة")
    )
    previous_payment_totalamount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("المبلغ الإجمالي السابق"),
        null=True,
        blank=True
    )
    new_payment_totalamount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("المبلغ الإجمالي الجديد")
    )
    previous_payment_discount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("قيمة الخصم السابقة"),
        default=0,
        null=True,
        blank=True
    )
    new_payment_discount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("قيمة الخصم الجديدة"),
        default=0
    )
    previous_payment_discount_code = models.CharField(
       max_length=100,
        verbose_name=_("كود الخصم السابق"),
        null=True,
        blank=True
    )
    new_payment_discount_code = models.CharField(
       max_length=100,
        verbose_name=_("كود الخصم الجديد"),
        null=True,
        blank=True
    )
    note = models.TextField(
        verbose_name=_("ملاحظات"),
        blank=True,
        null=True
    )

    class Meta:
        verbose_name = _("سجل الدفعة")
        verbose_name_plural = _("سجلات الدفعات")
        ordering = ['-history_date']

    def __str__(self):
        return f"History for Payment #{self.payment.id} at {self.history_date}"

