from django.contrib import admin
from django.utils.html import format_html
from .models import HotelService, RoomTypeService, Offer


@admin.register(HotelService)
class HotelServiceAdmin(admin.ModelAdmin):
    list_display = ("name", "hotel", "is_active", "icon_display")
    list_filter = ("is_active", "hotel")
    search_fields = ("name", "description")
    readonly_fields = ("icon_display",)

    def icon_display(self, obj):
        if obj.icon:
            return format_html('<img src="{}" style="width: 30px; height: 30px;" />', obj.icon.url)
        return "-"
    icon_display.short_description = "Icon"


@admin.register(RoomTypeService)
class RoomTypeServiceAdmin(admin.ModelAdmin):
    list_display = ("name", "room_type", "hotel", "is_active", "additional_fee", "icon_display")
    list_filter = ("is_active", "room_type", "hotel")
    search_fields = ("name", "description")
    readonly_fields = ("icon_display",)

    def icon_display(self, obj):
        if obj.icon:
            return format_html('<img src="{}" style="width: 30px; height: 30px;" />', obj.icon.url)
        return "-"
    icon_display.short_description = "Icon"


@admin.register(Offer)
class OfferAdmin(admin.ModelAdmin):
    list_display = ("offer_name", "hotel_name", "offer_start_date", "offer_end_date",)
    list_filter = ("offer_start_date", "offer_end_date", "hotel")
    search_fields = ("offer_name", "offer_description")
    date_hierarchy = "offer_start_date"

    def hotel_name(self, obj):
        return obj.hotel.name 
    hotel_name.short_description = "Hotel Name"

    def save_model(self, request, obj, form, change):
        if not obj.pk:  
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)
