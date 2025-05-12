from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _
from django.db import transaction
from django.shortcuts import render

from bookings.admin_classes.mixins import HotelUserFilter
from payments.models import Payment
from django import forms

class PaymentAdmin(admin.ModelAdmin):
    list_display = [
        'id', 'booking_link', 'user_link', 'payment_method', 'payment_totalamount',
        'payment_currency', 'styled_payment_status', 'payment_date', 'payment_type',
        'view_payment_details_button',
    ]
    list_filter = ['payment_status', 'payment_type', HotelUserFilter, 'payment_date']
    search_fields = ['booking__id', 'user__username', 'user__first_name', 'user__last_name',
                     'payment_method__method_name', 'id']
    readonly_fields = ['payment_subtotal', 'payment_totalamount', 'payment_currency','created_at', 'updated_at', 'created_by', 'updated_by','deleted_at']
    actions = ['change_payment_status']
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.user_type == 'hotel_manager':
            return qs.filter(booking_id__hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return qs.filter(booking_id__hotel__manager=request.user.chield, hotel__manager=request.user.chield)
        return qs

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:
            return ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields

    def booking_link(self, obj):
        if obj.booking:
            url = reverse("admin:bookings_booking_change", args=[obj.booking.id])
            return format_html('<a href="{}">{} {}</a>', url, _("حجز رقم"), obj.booking.id)
        return "-"
    booking_link.short_description = _("الحجز")

    def user_link(self, obj):
        if obj.user:
            url = reverse("admin:users_customuser_change", args=[obj.user.id])
            return format_html('<a href="{}">{}</a>', url, obj.user.get_full_name() or obj.user.username)
        return "-"
    user_link.short_description = _("المستخدم")

    def styled_payment_status(self, obj):
        status_colors = {
            0: '#fff3cd',  # Pending
            1: '#d4edda',  # Paid
            2: '#f8d7da',  # Rejected
        }
        text_colors = {
            0: '#856404',
            1: '#155724',
            2: '#721c24',
        }
        return format_html(
            '<span style="background-color: {}; color: {}; padding: 3px 8px; border-radius: 12px; font-size: 0.85em; font-weight: 500;">{}</span>',
            status_colors.get(obj.payment_status, '#e2e3e5'),
            text_colors.get(obj.payment_status, '#383d41'),
            obj.get_payment_status_display()
        )
    styled_payment_status.short_description = _("حالة الدفع")
    styled_payment_status.admin_order_field = 'payment_status'

    def view_payment_details_button(self, obj):
        url = reverse('payments:external-payment-detail', args=[obj.pk])
        return format_html(
            '<a class="button btn btn-info" href="{}" target="_blank">{}</a>',
            url,
            _("عرض التفاصيل")
        )
    view_payment_details_button.short_description = _("تفاصيل الدفع")

    @admin.action(description=_("تغيير حالة الدفعات المحددة"))
    def change_payment_status(self, request, queryset):
        # إنشاء نموذج مخصص للإجراء
        class StatusChangeForm(forms.Form):
            new_status = forms.ChoiceField(
                choices=Payment.payment_choice,
                label=_("الحالة الجديدة"),
                required=True
            )

        # إذا كان هذا طلب POST وبيانات النموذج صالحة، قم بمعالجة الإجراء
        if 'apply' in request.POST:
            form = StatusChangeForm(request.POST)
            if form.is_valid():
                new_status = form.cleaned_data['new_status']
                updated_count = 0
                try:
                    with transaction.atomic():
                        for payment in queryset:
                            payment.payment_status = int(new_status)
                            payment.save()

                            # إذا تم تغيير حالة الدفع إلى "تم الدفع"، قم بتحديث حالة الحجز إلى "مؤكد"
                            if int(new_status) == 1 and payment.booking.status != '1':
                                payment.booking.status = '1'  # تأكيد الحجز
                                payment.booking.save()

                            # إذا تم تغيير حالة الدفع إلى "مرفوض"، قم بتحديث حالة الحجز إلى "ملغي"
                            elif int(new_status) == 2 and payment.booking.status != '2':
                                payment.booking.status = '2'  # إلغاء الحجز
                                payment.booking.save()

                            updated_count += 1

                    label = dict(Payment.payment_choice).get(int(new_status), new_status)
                    self.message_user(request, _(f"تم تغيير حالة {updated_count} دفعة(ات) إلى '{label}'"))
                except Exception as e:
                    self.message_user(request, _("حدث خطأ أثناء تحديث الحالة: {}").format(str(e)), level='error')
                return None

        # إذا كان هذا طلب GET أو النموذج غير صالح، اعرض النموذج
        form = StatusChangeForm()
        context = {
            'title': _('تغيير حالة الدفعات'),
            'queryset': queryset,
            'form': form,
            'action_checkbox_name': admin.helpers.ACTION_CHECKBOX_NAME,
        }
        return render(request, 'admin/payment_status_change_form.html', context)
