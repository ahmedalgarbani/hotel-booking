from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import Hotel
from .models import RoomType, Category, Availability, RoomPrice, RoomImage, RoomStatus

@admin.register(RoomType)
class RoomTypeAdmin(admin.ModelAdmin):
    list_display = ['name', 'hotel', 'category', 'default_capacity', 'max_capacity', 'rooms_count']
    search_fields = ['name', 'hotel__name']
    list_filter = ['hotel', 'category']

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ['name', 'hotel']
    search_fields = ['name', 'hotel__name']
    list_filter = ['hotel']

@admin.register(RoomStatus)
class RoomStatusAdmin(admin.ModelAdmin):
    list_display = ['name', 'code', 'hotel', 'is_available']
    search_fields = ['name', 'code', 'hotel__name']
    list_filter = ['hotel', 'is_available']

@admin.register(Availability)
class AvailabilityAdmin(admin.ModelAdmin):
    list_display = ['room_type', 'hotel', 'date', 'available_rooms', 'price']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'date', 'room_type']

@admin.register(RoomPrice)
class RoomPriceAdmin(admin.ModelAdmin):
    list_display = ['room_type', 'hotel', 'price', 'date_from', 'date_to', 'is_special_offer']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'room_type', 'is_special_offer']

@admin.register(RoomImage)
class RoomImageAdmin(admin.ModelAdmin):
    list_display = ['room_type', 'hotel', 'image', 'is_main']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'room_type', 'is_main']
