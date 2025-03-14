from django.contrib import admin

from HotelManagement.models import Hotel
from .models import Currency, HotelPaymentMethod, PaymentOption, Payment
from django.db.models import Q
from bookings.models import Booking


class PaymentManagerAdminMixin:
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.user_type == 'hotel_manager':
            return qs.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return qs.filter(hotel__manager=request.user.chield)
        return qs

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if not request.user.is_superuser:
            if db_field.name == "booking":
                kwargs["queryset"] = Booking.objects.filter(
                    Q(hotel__manager=request.user) | 
                    Q(hotel__manager=request.user.chield)
                )
            elif db_field.name == "payment_method":
                kwargs["queryset"] = HotelPaymentMethod.objects.filter(
                    Q(hotel__manager=request.user) | 
                    Q(hotel__manager=request.user.chield)
                )
            elif db_field.name == "currency":
                kwargs["queryset"] = Currency.objects.filter(
                    Q(hotel__manager=request.user) | 
                    Q(hotel__manager=request.user.chield)
                )
        return super().formfield_for_foreignkey(db_field, request, **kwargs)
    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            
            form.base_fields['hotel'].queryset = Hotel.objects.filter(manager=request.user)
            form.base_fields['hotel'].initial = Hotel.objects.filter(manager=request.user).first()
            form.base_fields['hotel'].widget.attrs['readonly'] = True
            form.base_fields['hotel'].required = False
            
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user
                form.base_fields['updated_by'].widget.attrs['disabled'] = True
                form.base_fields['updated_by'].required = False
            
            if 'created_by' in form.base_fields:
                
                form.base_fields['created_by'].widget.attrs['disabled'] = True
                form.base_fields['created_by'].initial = request.user
                form.base_fields['created_by'].required = False
        return form

    def get_readonly_fields(self, request, obj=None):
        if obj:  # If the object exists (i.e., we are editing it)
            return self.readonly_fields + ('created_by', 'updated_by')
        return self.readonly_fields

    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)
    
@admin.register(Payment)
class PaymentAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('booking', 'payment_method', 'payment_status', 'payment_date', 'payment_totalamount')
    list_filter = ('payment_status', 'payment_date', 'booking__hotel')
    search_fields = ('booking__id', 'payment_method__account_name')
    readonly_fields = ('payment_date',)

@admin.register(HotelPaymentMethod)
class HotelPaymentMethodAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('hotel', 'payment_option', 'account_name', 'is_active')
    list_filter = ('is_active', 'hotel', 'payment_option')
    search_fields = ('hotel__name', 'account_name')

@admin.register(PaymentOption)
class PaymentOptionAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('method_name', 'currency', 'is_active')
    list_filter = ('is_active', 'currency')
    search_fields = ('method_name',)

@admin.register(Currency)
class CurrencyAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('currency_name', 'currency_symbol', 'hotel')
    list_filter = ('hotel',)
    search_fields = ('currency_name', 'currency_symbol')
