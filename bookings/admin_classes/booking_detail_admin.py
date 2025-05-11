from django.contrib import admin
from django.utils.translation import gettext_lazy as _

# Import models and shared components
from bookings.models import BookingDetail
from .mixins import AutoUserTrackMixin, HotelUserFilter # Assuming details are tracked by user

# Note: HotelManagerAdminMixin might not be directly needed if filtering happens via Booking
class BookingDetailAdmin(AutoUserTrackMixin, admin.ModelAdmin):
    list_display = ['booking', 'service', 'quantity', 'price', 'total']
    list_filter = ['booking__status', 'service', HotelUserFilter] # Filter by hotel via booking
    search_fields = ['booking__id', 'service__name']
    # Make total calculated field readonly
    readonly_fields =('created_at', 'updated_at','total','created_by', 'updated_by','deleted_at')

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','total', 'created_by', 'updated_by','deleted_at','hotel')
        return self.readonly_fields


    # Inherit get_readonly_fields from AutoUserTrackMixin if it defines tracking fields
    # If HotelManagerAdminMixin is needed for direct filtering (unlikely), add it and its methods

    # Optional: Override get_queryset if direct filtering by hotel/manager is needed
    # def get_queryset(self, request):
    #     qs = super().get_queryset(request)
    #     # Apply HotelManagerAdminMixin logic here if necessary
    #     # Example: qs = qs.filter(booking__hotel=request.user.hotel_set.first())
    #     return qs
