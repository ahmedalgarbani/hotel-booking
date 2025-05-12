from django.contrib import admin

# Import models to register
from .models import Booking, Guest, BookingDetail, ExtensionMovement, BookingHistory

# Import the admin classes from their new modules
from .admin_classes.booking_admin import BookingAdmin
from .admin_classes.guest_admin import GuestAdmin
from .admin_classes.booking_detail_admin import BookingDetailAdmin
from .admin_classes.extension_movement_admin import ExtensionMovementAdmin
from .admin_classes.booking_history_admin import BookingHistoryAdmin

# Use your custom admin site if defined, otherwise use default admin.site
# Ensure this import path is correct for your project structure
try:
    from api.admin import admin_site
except ImportError:
    print("Warning: Custom admin_site from api.admin not found. Using default admin.site.")
    admin_site = admin.site

# Register models with the admin site using the imported classes
admin_site.register(Booking, BookingAdmin)
admin_site.register(Guest, GuestAdmin)
admin_site.register(BookingDetail, BookingDetailAdmin)
admin_site.register(ExtensionMovement, ExtensionMovementAdmin)
admin_site.register(BookingHistory, BookingHistoryAdmin)

# Any other admin configurations or registrations specific to the 'bookings' app
# that were not part of the moved classes can remain here.
