from django.contrib import admin
from django.contrib.admin.helpers import ActionForm
from HotelManagement.models import Hotel
from .models import Currency, HotelPaymentMethod, PaymentHistory, PaymentOption, Payment
from django.db.models import Q
from bookings.models import Booking
from api.admin import admin_site
from django import forms

# Import the new PaymentAdmin class
from .admin_classes.payment_admin import PaymentAdmin
from django.db import transaction
from django.utils.html import format_html


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



class ChangePaymentStatusForm(ActionForm):  
    new_status = forms.ChoiceField(
        choices=[('', '-- اختر الحالة --')] + list(Payment.payment_choice),
        required=False,
        label="الحالة الجديدة"
    ) # Added closing parenthesis

# The original PaymentAdmin class definition is removed.
# The registration at the end of the file will now use the imported PaymentAdmin.


class HotelPaymentMethodAdmin(PaymentManagerAdminMixin, admin.ModelAdmin): # Added newline before class
    list_display = ('hotel', 'payment_option', 'account_name', 'is_active')
    list_filter = ('is_active', 'hotel', 'payment_option')
    search_fields = ('hotel__name', 'account_name')
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
        return self.readonly_fields

class PaymentOptionAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('method_name', 'currency', 'is_active')
    list_filter = ('is_active', 'currency')
    search_fields = ('method_name',)

    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.user_type == 'hotel_manager':
            return qs.filter(currency__hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return qs.filter(currency__hotel__manager=request.user.chield)
        return qs

class CurrencyAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('currency_name', 'currency_symbol', 'hotel')
    list_filter = ('hotel',)
    search_fields = ('currency_name', 'currency_symbol')

    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.user_type == 'hotel_manager':
            return qs.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return qs.filter(hotel__manager=request.user.chield)
        return qs


# Payments -------------



class AutoUserTrackMixin:
    
    def save_model(self, request, obj, form, change):
        if not obj.pk: 
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)



class PaymentHistoryAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = (
        'payment',
        'history_date',
        'changed_by',
        'previous_payment_status',
        'new_payment_status'
    )
    list_filter = ('new_payment_status', 'history_date')
    search_fields = (
        'payment__id',
        'changed_by__username'
    )
    ordering = ('-history_date',)
    readonly_fields = (
        'payment',
        'history_date',
        'changed_by',
        'previous_payment_status',
        'new_payment_status',
        'previous_payment_totalamount',
        'new_payment_totalamount',
        'previous_payment_discount',
        'new_payment_discount',
        'previous_payment_discount_code',
        'new_payment_discount_code',
        'note',
    )
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')





admin_site.register(Currency,CurrencyAdmin)
admin_site.register(PaymentHistory,PaymentHistoryAdmin)
admin_site.register(PaymentOption,PaymentOptionAdmin)
admin_site.register(HotelPaymentMethod,HotelPaymentMethodAdmin)
admin_site.register(Payment,PaymentAdmin)
