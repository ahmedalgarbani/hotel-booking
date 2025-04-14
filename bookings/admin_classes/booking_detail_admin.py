from django.contrib import admin
from django.utils.translation import gettext_lazy as _

# Import models and shared components
from bookings.models import BookingDetail
from .mixins import AutoUserTrackMixin # Assuming details are tracked by user

# Note: HotelManagerAdminMixin might not be directly needed if filtering happens via Booking
class BookingDetailAdmin(AutoUserTrackMixin, admin.ModelAdmin):
    list_display = ['booking', 'service', 'quantity', 'price', 'total']
    list_filter = ['booking__status', 'service', 'booking__hotel'] # Filter by hotel via booking
    search_fields = ['booking__id', 'service__name']
    # Make total calculated field readonly
    readonly_fields = ('total',) # Add others from mixin via get_readonly_fields if needed

    # Inherit get_readonly_fields from AutoUserTrackMixin if it defines tracking fields
    # If HotelManagerAdminMixin is needed for direct filtering (unlikely), add it and its methods

    # Optional: Override get_queryset if direct filtering by hotel/manager is needed
    # def get_queryset(self, request):
    #     qs = super().get_queryset(request)
    #     # Apply HotelManagerAdminMixin logic here if necessary
    #     # Example: qs = qs.filter(booking__hotel=request.user.hotel_set.first())
    #     return qs
