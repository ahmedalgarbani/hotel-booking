from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _

# Import models and potentially shared components if needed
from bookings.models import ExtensionMovement
# from .mixins import HotelManagerAdminMixin # Add if direct filtering by hotel is needed

# Note: Filtering might be better handled via the related Booking's hotel
class ExtensionMovementAdmin(admin.ModelAdmin): # Removed HotelManagerAdminMixin for now
    list_display = (
        'movement_number', 'booking', 'original_departure', 'new_departure',
        'extension_date', 'duration', 'reason', 'payment_button'
    )
    list_filter = ('extension_date', 'reason', 'booking__hotel') # Filter by hotel via booking
    search_fields = ('booking__id', 'movement_number')
    # Make calculated/generated fields readonly
    readonly_fields = ('movement_number', 'extension_date', 'duration', 'extension_year')
    date_hierarchy = 'extension_date'

    # Optional: Add fieldsets if desired for better form organization
    fieldsets = (
        (_("معلومات التمديد"), {'fields': ('booking', 'original_departure', 'new_departure', 'reason')}),
        (_("تفاصيل الدفع"), {'fields': ('payment_receipt',)}),
        (_("معلومات النظام"), {'fields': ('movement_number', 'extension_date', 'duration', 'extension_year'), 'classes': ('collapse',)}),
    )

    def payment_button(self, obj):
        if obj.booking.actual_check_out_date is not None:
            return format_html('<span style="color:red; font-weight:bold;">✘ {}</span>', _("غير قابل للتعديل"))
        if obj.payment_receipt is not None:
             # Link to the payment if possible
             try:
                 payment_url = reverse('admin:payments_payment_change', args=[obj.payment_receipt.pk]) # Adjust if namespace/app name differs
                 return format_html('<a href="{}"><span style="color:green; font-weight:bold;">✔ {}</span></a>', payment_url, _("تم الدفع"))
             except:
                 return format_html('<span style="color:green; font-weight:bold;">✔ {}</span>', _("تم الدفع"))

        # Ensure URL name for payment popup exists and is correct
        try:
             # Adjust URL name and namespace as needed
             url = reverse('admin:booking_extend_payment', args=[obj.booking.id, obj.pk])
        except Exception as e:
             print(f"Error reversing URL 'admin:booking_extend_payment': {e}")
             return _("خطأ في رابط الدفع")
        # Ensure the popup function exists in your admin JS
        return format_html(
            '<a class="button btn btn-success" href="{}" onclick="return showExtensionPopup(this.href);">{}</a>',
            url, _("دفع فاتورة التمديد") # More specific text
        )
    payment_button.short_description = _('فاتورة التمديد')

    # Optional: Override get_queryset if direct filtering by hotel/manager is needed
    # def get_queryset(self, request):
    #     qs = super().get_queryset(request)
    #     # Apply HotelManagerAdminMixin logic here if necessary
    #     # Example: qs = qs.filter(booking__hotel=request.user.hotel_set.first())
    #     return qs
