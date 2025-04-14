from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _

# Import models
from payments.models import Payment

# Use your custom admin site if defined, otherwise use default admin.site
try:
    from api.admin import admin_site
except ImportError:
    print("Warning: Custom admin_site from api.admin not found. Using default admin.site.")
    admin_site = admin.site


class PaymentAdmin(admin.ModelAdmin): # Consider inheriting from HotelManagerAdminMixin if applicable
    list_display = [
        'id', 'booking_link', 'user_link', 'payment_method', 'payment_totalamount',
        'payment_currency', 'payment_status_display', 'payment_date', 'payment_type'
    ]
    list_filter = ['payment_status', 'payment_type', 'payment_method__hotel', 'payment_date']
    search_fields = [
        'booking__id', 'user__username', 'user__first_name', 'user__last_name',
        'payment_method__method_name', 'id'
    ]
    readonly_fields = ['payment_subtotal', 'payment_totalamount', 'payment_currency'] # Make calculated fields read-only
    # Add actions if needed, e.g., export selected payments
    # actions = ['export_payments_report']

    # Link to related booking
    def booking_link(self, obj):
        if obj.booking:
            link = reverse("admin:bookings_booking_change", args=[obj.booking.id])
            return format_html('<a href="{}">{} {}</a>', link, _("حجز رقم"), obj.booking.id)
        return "-"
    booking_link.short_description = _("الحجز")
    booking_link.admin_order_field = 'booking'

    # Link to related user
    def user_link(self, obj):
        if obj.user:
            link = reverse("admin:users_customuser_change", args=[obj.user.id]) # Adjust app_label if needed
            return format_html('<a href="{}">{}</a>', link, obj.user.get_full_name() or obj.user.username)
        return "-"
    user_link.short_description = _("المستخدم")
    user_link.admin_order_field = 'user'

    # Display payment status with color
    def payment_status_display(self, obj):
        return format_html(
            '<span style="color: {};">{}</span>',
            obj.get_status_class, # Use property from model
            obj.get_payment_status_display()
        )
    payment_status_display.short_description = _("حالة الدفع")
    payment_status_display.admin_order_field = 'payment_status'

    # Override changelist_view to add context for the report link
    def changelist_view(self, request, extra_context=None):
        extra_context = extra_context or {}
        # Add the URL for the revenue summary report to the context
        extra_context['revenue_summary_url'] = reverse('payments:revenue-summary')
        return super().changelist_view(request, extra_context=extra_context)

    # --- Custom Report Views & URLs ---
    def get_urls(self):
        urls = super().get_urls()
        # No need to add custom report URLs here as they are now defined in payments/urls.py
        return urls

# Note: Registration happens in payments/admin.py
# admin_site.register(Payment, PaymentAdmin)
