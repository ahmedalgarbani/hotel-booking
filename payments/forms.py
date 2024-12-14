from django import forms
from .models import Payment, PaymentMethod, PaymentStatus, Currency


class PaymentForm(forms.ModelForm):
    class Meta:
        model = Payment
        fields = ['payment_method', 'payment_status', 'payment_date', 'payment_subtotal', 'payment_discount', 'payment_total']



class PaymentMethodForm(forms.ModelForm):
    class Meta:
        model = PaymentMethod
        fields = ['method_name', 'activate_state']


class PaymentStatusForm(forms.ModelForm):
    class Meta:
        model = PaymentStatus
        fields = ['payment_status_name', 'activate_state']


class CurrencyForm(forms.ModelForm):
    class Meta:
        model = Currency
        fields = ['currency_name', 'activate_state']