from django.contrib import admin
from .models import Guest, BookingStatus, Booking, BookingDetail

@admin.register(Guest)
class GuestAdmin(admin.ModelAdmin):
    list_display = ('name', 'phone_number', 'id_card_number', 'hotel', 'booking', 'account')
    search_fields = ('name', 'phone_number', 'id_card_number', 'hotel__name')
    list_filter = ('hotel',)
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
       
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        
        return queryset.none()


@admin.register(BookingStatus)
class BookingStatusAdmin(admin.ModelAdmin):
    list_display = ('booking_status_name', 'status_code')
    search_fields = ('booking_status_name',)
    list_filter = ('status_code',)

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ('hotel', 'room', 'check_in_date', 'check_out_date', 'amount')
    search_fields = ('hotel__name', 'room__name')
    list_filter = ('hotel', 'room', 'check_in_date', 'check_out_date')

@admin.register(BookingDetail)
class BookingDetailAdmin(admin.ModelAdmin):
    list_display = ('booking', 'service', 'hotel')
    search_fields = ('booking__id', 'service__name', 'hotel__name')
    list_filter = ('hotel', 'service')
