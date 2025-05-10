from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _


class ExtensionMovementAdmin(admin.ModelAdmin):
    list_display = (
        'movement_number', 'booking', 'original_departure', 'new_departure',
        'extension_date', 'duration', 'reason', 'payment_button'
    )
    list_filter = ('extension_date', 'reason', 'booking__hotel')
    search_fields = ('booking__id', 'movement_number')
    readonly_fields = ('movement_number', 'extension_date', 'duration', 'extension_year')
    date_hierarchy = 'extension_date'

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        user = request.user
        if user.is_superuser or user.user_type == 'admin':
            return qs
        elif user.user_type == 'hotel_manager':
            # Check if the user is linked to a hotel via the OneToOneField reverse relation ('hotel')
            if hasattr(user, 'hotel') and user.hotel:
                return qs.filter(booking__hotel=user.hotel)
            else:
                # If the manager is not linked to any hotel, show no extensions
                return qs.none()
        elif user.user_type == 'hotel_staff':
            # Adjust logic based on how staff are linked to hotels
            if hasattr(user, 'assigned_hotel'): # Example: Direct link
                return qs.filter(booking__hotel=user.assigned_hotel)
            # Add other potential linking logic here if needed
            else:
                return qs.none()
        return qs.none()

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        user = request.user
        if not user.is_superuser and user.user_type == 'hotel_manager':
            if db_field.name == "booking":
                if hasattr(user, 'hotel') and user.hotel:
                    kwargs["queryset"] = db_field.related_model.objects.filter(hotel=user.hotel)
            elif db_field.name == "payment_receipt":
                if hasattr(user, 'hotel') and user.hotel:
                    kwargs["queryset"] = db_field.related_model.objects.filter(booking__hotel=user.hotel)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

    fieldsets = (
        (_("معلومات التمديد"), {'fields': ('booking', 'original_departure', 'new_departure', 'reason')}),
        (_("تفاصيل الدفع"), {'fields': ('payment_receipt',)}),
        (_("معلومات النظام"), {'fields': ('movement_number', 'extension_date', 'duration', 'extension_year'), 'classes': ('collapse',)}),
    )

    def payment_button(self, obj):
        if obj.booking.actual_check_out_date is not None:
            return format_html('<span style="color:red; font-weight:bold;">✘ {}</span>', _("غير قابل للتعديل"))

        if obj.payment_receipt is not None:
            try:
                payment_url = reverse('admin:payments_payment_change', args=[obj.payment_receipt.pk])
                return format_html(
                    '<a href="{}"><span style="color:green; font-weight:bold;">✔ {}</span></a>',
                    payment_url, _("تم الدفع")
                )
            except Exception as e:
                print(f"Error reversing payment receipt URL: {e}")
                return format_html('<span style="color:green; font-weight:bold;">✔ {}</span>', _("تم الدفع"))

        try:
            url = reverse('bookings:booking_extend_payment', args=[obj.booking.id, obj.pk])
            return format_html(
                '<a class="button" style="background-color: #28a745; color: white; padding: 5px 10px; border-radius: 4px; text-decoration: none;" '
                'href="{}" onclick="return showExtensionPopup(this.href);">{}</a>',
                url, _("دفع فاتورة التمديد")
            )
        except Exception as e:
            print(f"Error reversing URL 'bookings:booking_extend_payment': {e}")
            return format_html('<span style="color:red;">{}</span>', _("خطأ في رابط الدفع"))
