from django.contrib import admin
from django.contrib.admin.helpers import ActionForm
from HotelManagement.models import Hotel
from .models import Currency, HotelPaymentMethod, PaymentHistory, PaymentOption, Payment
from django.db.models import Q
from bookings.models import Booking
from api.admin import admin_site
from django import forms
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
    )


class PaymentAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    action_form = ChangePaymentStatusForm  
    list_display = (
          'formatted_booking',
        'get_payment_method_name',
        'colored_payment_status',
        'formatted_payment_date',
        'formatted_total_amount',
        
        )
    list_filter = ('payment_status', 'payment_date', 'booking__hotel')
    search_fields = ('booking__id', 'payment_method__account_name')
    readonly_fields = ('payment_date',)
    actions = ['change_payment_status'] 
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','booking', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields


    
    def booking_id_link(self, obj):
        return format_html(
            '<strong><a href="{}">{}</a></strong>',
            f'/admin/payments/payment/{obj.id}/change/',
            obj.booking_id
        )
    booking_id_link.short_description = 'Booking ID'

    @admin.display(description='الحجز', ordering='booking__id')
    def formatted_booking(self, obj):
        return format_html(
            '<b>#{} {}</b>',
            obj.booking.id,
            obj.booking.hotel.name if obj.booking.hotel else ''
        )

    @admin.display(description='طريقة الدفع', ordering='payment_method__account_name')
    def get_payment_method_name(self, obj):
        if not obj.payment_method:
            return 'N/A'
        
        icons = {
            'e_pay': '💳',
            'cash': '💰',
            # 'transfer': '🏦'
        }
        
        icon = icons.get(obj.payment_type, '')
        display_name = obj.payment_type 
        
        return f'{icon} {display_name}'


    @admin.display(description='تاريخ الدفع', ordering='payment_date')
    def formatted_payment_date(self, obj):
        return obj.payment_date.strftime('%d %b %Y - %H:%M') if obj.payment_date else 'N/A'

    @admin.display(description='المبلغ الإجمالي', ordering='payment_totalamount')
    def formatted_total_amount(self, obj):
        return format_html(
            '<div style="direction: ltr; text-align: right; font-family: monospace; '
            'font-weight: 500; color: #1976d2;">{amount} {currency}</div>',
            amount=f"{obj.payment_totalamount:,.2f}",
            currency=obj.payment_currency
        )



    @admin.display(description='حالة الدفع', ordering='payment_status')
    def colored_payment_status(self, obj):
        status_colors = {
            0: '#FFA500',  
            1: '#008000', 
            2: '#FF0000',   
        }
        
        status_label = obj.get_payment_status_display()  
        color = status_colors.get(obj.payment_status, '#808080')  
        
        return format_html(
            '<span style="color: {color}; font-weight: 500; padding: 2px 5px; border-radius: 3px; background-color: {bg_color}">{label}</span>',
            color=color,
            bg_color=f'{color}25',  
            label=status_label
        )
    @admin.action(description='تغيير حالة الدفعات المحددة')
    def change_payment_status(self, request, queryset):
        new_status = request.POST.get('new_status')
        if new_status == '':
            self.message_user(request, "لم يتم اختيار حالة جديدة.", level='warning')
            return
        
        if new_status:
            try:
                with transaction.atomic():
                    for payment in queryset:
                        previous_status = payment.payment_status
                        payment.payment_status = int(new_status)
                        payment.save()

                    status_label = dict(Payment.payment_choice).get(int(new_status))
                    success_message = f"تم تغيير حالة {queryset.count()} دفعة(ات) إلى '{status_label}'"
                    self.message_user(request, success_message)

            except Exception as e:
                self.message_user(request, f"حدث خطأ أثناء تحديث الدفعات: {str(e)}", level='error')


class HotelPaymentMethodAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('hotel', 'payment_option', 'account_name', 'is_active')
    list_filter = ('is_active', 'hotel', 'payment_option')
    search_fields = ('hotel__name', 'account_name')

class PaymentOptionAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('method_name', 'currency', 'is_active')
    list_filter = ('is_active', 'currency')
    search_fields = ('method_name',)

class CurrencyAdmin(PaymentManagerAdminMixin, admin.ModelAdmin):
    list_display = ('currency_name', 'currency_symbol', 'hotel')
    list_filter = ('hotel',)
    search_fields = ('currency_name', 'currency_symbol')


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