from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _

# Import models and shared components
from bookings.models import Guest
from .mixins import HotelManagerAdminMixin

class GuestAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['name', 'phone_number', 'hotel', 'booking', 'set_checkout_today_toggle']
    list_filter = ['hotel']
    search_fields = ['name', 'phone_number', 'booking__id']
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    # readonly_fields handled by mixin

    def set_checkout_today_toggle(self, obj):
        # Assuming a similar checkout logic/URL exists for guests, otherwise remove/adapt
        try:
            # Check if a specific URL exists for guest checkout, adjust if needed
            url = reverse('admin:set_guests_check_out_date', args=[obj.pk]) # Adjust URL name if needed
        except Exception as e:
            print(f"Error reversing URL 'admin:set_guests_check_out_date': {e}")
            return _("خطأ في الرابط")
        # Add logic here to check if guest is already checked out based on obj.check_out_date
        if obj.check_out_date:
             return format_html('<span style="color:green; font-weight:bold;">✔ {}</span>', _("تم تسجيل الخروج"))

        return format_html(
            '<a class="button btn btn-warning" href="{}">{}</a>',
            url, _("تسجيل الخروج")
        )
    set_checkout_today_toggle.short_description = _('تسجيل خروج الضيف')
