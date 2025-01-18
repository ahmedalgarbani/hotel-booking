from django.db import models
from HotelManagement.models import BaseModel, Hotel
from django.utils.translation import gettext_lazy as _


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


# ------------PaymentStatus-------------
class PaymentStatus(BaseModel):
    payment_status_name = models.CharField(max_length=50, verbose_name=_("اسم حالة الدفع"))
    status_code = models.IntegerField(verbose_name=_("رمز الحالة"))

    class Meta:
        verbose_name = _("حالة الدفع")
        verbose_name_plural = _("حالات الدفع")
        ordering = ['status_code']

    def __str__(self):
        return f"{self.payment_status_name} ({self.status_code})"


# ------------PaymentOption-------------
class PaymentOption(models.Model):
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
class HotelPaymentMethod(models.Model):
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
    account_name = models.CharField(max_length=100, verbose_name=_("اسم الحساب"))
    account_number = models.CharField(max_length=50, verbose_name=_("رقم الحساب"))
    iban = models.CharField(max_length=50, verbose_name=_("رقم الآيبان"))
    description = models.TextField(verbose_name=_("تعليمات الدفع"), blank=True, null=True)
    is_active = models.BooleanField(default=True, verbose_name=_("نشط"))

    def __str__(self):
        return f"{self.hotel.name} - {self.payment_option.method_name}"

    class Meta:
        verbose_name = _("طريقة دفع الفندق")
        verbose_name_plural = _("طرق دفع الفندق")
        unique_together = ['hotel', 'payment_option']


# ------------Payment-------------
class Payment(models.Model):
    TYPE_CHOICES = [
        ('cash', _('نقدي')),
        ('e_pay', _('دفع إلكتروني')),
    ]

    payment_method = models.ForeignKey(
        HotelPaymentMethod,
        on_delete=models.CASCADE,
        verbose_name=_("طريقة الدفع"),
        related_name='payments'
    )
    payment_status = models.ForeignKey(
        PaymentStatus,
        on_delete=models.CASCADE,
        verbose_name=_("حالة الدفع"),
        related_name='payments'
    )
    payment_date = models.DateTimeField(auto_now_add=True, verbose_name=_("تاريخ الدفع"))
    payment_subtotal = models.DecimalField(max_digits=10, decimal_places=2, verbose_name=_("المبلغ الفرعي"))
    payment_discount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name=_("قيمة الخصم"), default=0)
    payment_totalamount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name=_("المبلغ الإجمالي"))
    payment_currency = models.CharField(max_length=25, default='USD', verbose_name=_("العملة"))
    payment_note = models.TextField(max_length=300, verbose_name=_("ملاحظات"), blank=True, null=True)
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='payments'
    )
    payment_type = models.CharField(max_length=20, choices=TYPE_CHOICES, verbose_name=_("نوع الدفع"), default='cash')

    class Meta:
        verbose_name = _("فاتورة دفع")
        verbose_name_plural = _("فواتير الدفع")
        ordering = ['-payment_date']

    def __str__(self):
        return f"فاتورة رقم {self.id} - {self.booking.guest.full_name} - {self.payment_totalamount} {self.payment_currency}"

    def save(self, *args, **kwargs):
        if self.payment_subtotal and self.payment_discount:
            self.payment_totalamount = self.payment_subtotal - self.payment_discount
        super().save(*args, **kwargs)
