from django.contrib import admin
from .models import Currency, HotelPaymentMethod, PaymentOption, Payment



@admin.register(HotelPaymentMethod)
class HotelPaymentMethodAdmin(admin.ModelAdmin):
    list_display = ('hotel', 'payment_option', 'account_name', 'is_active')
    search_fields = ('hotel__name', 'payment_option__method_name', 'account_name')
    list_filter = ('is_active', 'hotel', 'payment_option')
    list_editable = ('is_active',)

@admin.register(Currency)
class CurrencyAdmin(admin.ModelAdmin):
    list_display = ('currency_name', 'currency_symbol', 'hotel')
    search_fields = ('currency_name', 'currency_symbol')
    list_filter = ('hotel',)




@admin.register(PaymentOption)
class PaymentOptionAdmin(admin.ModelAdmin):
    list_display = ('method_name', 'currency', 'is_active')
    search_fields = ('method_name', 'currency__currency_name')
    list_filter = ('is_active', 'currency')
    list_editable = ('is_active',)


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
        'payment_method__payment_option__method_name', 
        'payment_status__payment_status_name', 
        'payment_currency', 
        'booking__id'
    )
    list_filter = ('payment_status', 'payment_method', 'payment_currency', 'payment_date', 'payment_type')
    readonly_fields = ('payment_date', 'payment_totalamount')  # جعل الحقول الحسابية للقراءة فقط
    autocomplete_fields = ('payment_method', 'booking')  # تحسين البحث في العلاقات الأجنبية

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        return queryset.select_related('payment_method',  'booking')
