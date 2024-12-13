from django.contrib import admin
from .models import Currency, PaymentStatus, PaymentMethod, Payment

@admin.register(Currency)
class CurrencyAdmin(admin.ModelAdmin):
    list_display = ('currency_name', 'currency_symbol', 'hotel')
    search_fields = ('currency_name', 'currency_symbol')
    list_filter = ('hotel',)

@admin.register(PaymentStatus)
class PaymentStatusAdmin(admin.ModelAdmin):
    list_display = ('payment_status_name', 'status_code')
    search_fields = ('payment_status_name',)
    list_filter = ('status_code',)

@admin.register(PaymentMethod)
class PaymentMethodAdmin(admin.ModelAdmin):
    list_display = ('method_name', 'country', 'currency', 'activate_state')
    search_fields = ('method_name', 'country')
    list_filter = ('activate_state', 'currency')

@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = (
        'payment_method', 
        'payment_status', 
        'payment_date', 
        'payment_subtotal', 
        'payment_discount', 
        'payment_totalamount', 
        'payment_currency', 
        'booking', 
        'payment_type'
    )
    search_fields = (
        'payment_method__method_name', 
        'payment_status__payment_status_name', 
        'payment_currency__currency_name', 
        'booking__id'
    )
    list_filter = ('payment_status', 'payment_method', 'payment_currency', 'payment_date', 'payment_type')
    readonly_fields = ('payment_date',)  

