from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import Hotel
from .models import RoomType, Category, Availability, RoomPrice, RoomImage, RoomStatus

class BaseModelAdmin(admin.ModelAdmin):
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        return queryset.none()

    def has_add_permission(self, request):
        return request.user.is_superuser or request.user.user_type in ['admin', 'hotel_manager']

    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def has_delete_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def has_view_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            hotel = Hotel.objects.get(manager=request.user)
            form.base_fields['hotel'].queryset = Hotel.objects.filter(id=hotel.id)
            form.base_fields['hotel'].initial = hotel
            form.base_fields['hotel'].widget.attrs['readonly'] = True
            
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user
                form.base_fields['updated_by'].widget.attrs['readonly'] = True
                form.base_fields['updated_by'].required = False
            
            if 'created_by' in form.base_fields:
                form.base_fields['created_by'].initial = request.user
                form.base_fields['created_by'].widget.attrs['readonly'] = True
                form.base_fields['created_by'].required = False
        return form

    def save_model(self, request, obj, form, change):
        if not change:
            if request.user.user_type == 'hotel_manager':
                obj.hotel = request.user.hotel
        super().save_model(request, obj, form, change)

@admin.register(RoomType)
class RoomTypeAdmin(BaseModelAdmin):
    list_display = ['name', 'hotel', 'category', 'default_capacity', 'max_capacity', 'rooms_count']
    search_fields = ['name', 'hotel__name']
    list_filter = ['hotel', 'category']

@admin.register(Category)
class CategoryAdmin(BaseModelAdmin):
    list_display = ['name', 'hotel']
    search_fields = ['name', 'hotel__name']
    list_filter = ['hotel']

@admin.register(RoomStatus)
class RoomStatusAdmin(BaseModelAdmin):
    list_display = ['name', 'code', 'hotel', 'is_available']
    search_fields = ['name', 'code', 'hotel__name']
    list_filter = ['hotel', 'is_available']

@admin.register(Availability)
class AvailabilityAdmin(BaseModelAdmin):
    list_display = ['room_type', 'hotel', 'availability_date', 'available_rooms']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'availability_date', 'room_type']

@admin.register(RoomPrice)
class RoomPriceAdmin(BaseModelAdmin):
    list_display = ['room_type', 'hotel', 'price', 'date_from', 'date_to', 'is_special_offer']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'room_type', 'is_special_offer']

@admin.register(RoomImage)
class RoomImageAdmin(BaseModelAdmin):
    list_display = ['room_type', 'hotel', 'image', 'is_main']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'room_type', 'is_main']
