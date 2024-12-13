from django.db import models
from HotelManagement.models import BaseModel
from django.utils.translation import gettext_lazy as _

# Create your models here.

# ------------currency-------------
class Currency(BaseModel):
    currency_name = models.CharField(max_length=50)
    currency_symbol = models.CharField(max_length=10)
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='currency'
    )
    class Meta:
        verbose_name = _("العمله  ")
        verbose_name_plural = _("العملات ")
    def __str__(self):
        return f"{self.currency_symbol}" 

# ------------PaymentStatus-------------

class PaymentStatus(BaseModel):
    payment_status_name = models.CharField(max_length=50)
    status_code = models.IntegerField()
    class Meta:
        verbose_name = _("حاله الدفع  ")
        verbose_name_plural = _("حالات الدفع ")
    def __str__(self):
        return f"{self.payment_status_name}" 
    
# ------------PaymentMethod-------------

class PaymentMethod(BaseModel):
    method_name = models.CharField(max_length=50)
    logo = models.CharField(max_length=255)
    activate_state = models.BooleanField(default=True)
    country = models.CharField(max_length=50)
    currency = models.ForeignKey(
        'payments.Currency',
        on_delete=models.CASCADE,
        verbose_name=_("العمله"),
        related_name='payment_method'
        )
    transfer_number = models.CharField(max_length=66)
    decription = models.TextField(max_length=300)
    class Meta:
        verbose_name = _("طريقة الدفع  ")
        verbose_name_plural = _("طرق الدفع ")
    def __str__(self):
        return f"{self.method_name}"

    
# ------------Payment-------------

class Payment(models.Model):
    Type_choices = [
        ('0', 'CASH'),
        ('1', 'E-PAY'),
    ]
    payment_method = models.ForeignKey(
        'payments.PaymentMethod',
        on_delete=models.CASCADE,
        verbose_name=_("طريقة الدفع"),
        related_name='payment'
        )
    payment_status = models.ForeignKey(
        'payments.PaymentStatus',
        on_delete=models.CASCADE,
        verbose_name=_("حاله الدفع"),
        related_name='payment'
        )
    payment_date = models.DateTimeField(auto_now_add=True)
    payment_subtotal = models.DecimalField(max_digits=10, decimal_places=2)
    payment_discount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_totalamount = models.DecimalField(max_digits=10, decimal_places=2)
    
    payment_currency = models.ForeignKey(
        'payments.Currency',
        on_delete=models.CASCADE,
        verbose_name=_("العمله"),
        related_name='payment'
        )
    payment_note = models.TextField(max_length=300)
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("حجز"),
        related_name='payment'
        )
    payment_type = models.CharField(
           max_length=20,
             choices=Type_choices,
               verbose_name="حالة الدفع"
    )
    

    class Meta:
        verbose_name = _("فاتوره دفع  ")
        verbose_name_plural = _(" فواتير دفع")
    def __str__(self):
        return f"{self.payment_amount}"
        


    
    