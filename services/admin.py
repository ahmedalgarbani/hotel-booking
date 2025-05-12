from django.contrib import admin
from django.utils.html import format_html

from bookings.admin_classes.mixins import HotelUserFilter, RoomTypeFilter
from bookings.models import Booking
from .models import HotelService, RoomTypeService, Offer
from api.admin import admin_site

from .models import Coupon

from django.utils.timezone import now



from django import forms
from ckeditor.widgets import CKEditorWidget
from .models import Coupon

class CouponAdminForm(forms.ModelForm):
    description = forms.CharField(widget=CKEditorWidget())

    class Meta:
        model = Coupon
        fields = '__all__'

class AutoUserTrackMixin:

    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)

class CouponAdmin(AutoUserTrackMixin, admin.ModelAdmin):
    form = CouponAdminForm
    list_display = ('name', 'code', 'hotel', 'quantity', 'min_purchase_amount', 'expired_date', 'formatted_description',
                    'discount_type', 'discount', 'status', 'created_at', 'updated_at')
    search_fields = ('name', 'code', 'hotel__name')
    list_filter = ('status', 'discount_type', HotelUserFilter)
    ordering = ('-created_at',)
    # exclude = ('created_by', 'updated_by','deleted_at')
    readonly_fields = ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')

    def formatted_description(self, obj):
        return format_html(obj.description)

    formatted_description.allow_tags = True
    formatted_description.short_description = "الوصف"
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser or request.user.is_hotel_manager :
            return ('created_at', 'updated_at', 'created_by', 'hotel','updated_by','deleted_at')
        return self.readonly_fields
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(hotel__manager=request.user.chield)
        return queryset.none()


class HotelServiceAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ("name", "hotel", "is_active", "icon_display")
    list_filter = ("is_active", HotelUserFilter)
    search_fields = ("name", "description")
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at','icon_display')

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:
            if request.user.user_type == 'hotel_manager':
                return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at', 'hotel')
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
        return self.readonly_fields

    def icon_display(self, obj):
        if obj.icon:
            return format_html('<img src="{}" style="width: 30px; height: 30px;" />', obj.icon.url)
        return "-"
    icon_display.short_description = "Icon"

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(hotel__manager=request.user.chield)
        return queryset.none()

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            if hasattr(request.user, 'hotel') and request.user.hotel and 'hotel' in form.base_fields:
                # Establecer el hotel del gerente como valor predeterminado y único
                form.base_fields['hotel'].queryset = form.base_fields['hotel'].queryset.filter(id=request.user.hotel.id)
                form.base_fields['hotel'].initial = request.user.hotel
                form.base_fields['hotel'].widget.attrs['readonly'] = True
        return form

    def save_model(self, request, obj, form, change):
        if not change and request.user.user_type == 'hotel_manager':  # Si es una nueva entrada y el usuario es gerente de hotel
            if hasattr(request.user, 'hotel') and request.user.hotel:
                obj.hotel = request.user.hotel
        super().save_model(request, obj, form, change)


class RoomTypeServiceAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ("name", "room_type", "hotel", "is_active", "additional_fee", "icon_display")
    list_filter = ("is_active", RoomTypeFilter, HotelUserFilter)
    search_fields = ("name", "description")
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:
            if request.user.user_type == 'hotel_manager':
                return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at', 'hotel')
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
        return self.readonly_fields

    def icon_display(self, obj):
        if obj.icon:
            return format_html('<img src="{}" style="width: 30px; height: 30px;" />', obj.icon.url)
        return "-"
    icon_display.short_description = "Icon"

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(hotel__manager=request.user.chield)
        return queryset.none()

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            if hasattr(request.user, 'hotel') and request.user.hotel:
                # Establecer el hotel del gerente como valor predeterminado y único
                if 'hotel' in form.base_fields:
                    form.base_fields['hotel'].queryset = form.base_fields['hotel'].queryset.filter(id=request.user.hotel.id)
                    form.base_fields['hotel'].initial = request.user.hotel
                    form.base_fields['hotel'].widget.attrs['readonly'] = True

                # Filtrar room_type para mostrar solo los tipos de habitación del hotel del gerente
                if 'room_type' in form.base_fields:
                    form.base_fields['room_type'].queryset = form.base_fields['room_type'].queryset.filter(hotel=request.user.hotel)
        return form

    def save_model(self, request, obj, form, change):
        if not change and request.user.user_type == 'hotel_manager':  # Si es una nueva entrada y el usuario es gerente de hotel
            if hasattr(request.user, 'hotel') and request.user.hotel:
                obj.hotel = request.user.hotel
        super().save_model(request, obj, form, change)


class OfferAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ("offer_name", "hotel_name", "offer_start_date", "offer_end_date",)
    list_filter = ("offer_start_date", "offer_end_date", HotelUserFilter)
    search_fields = ("offer_name", "offer_description")
    date_hierarchy = "offer_start_date"
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:
            if request.user.user_type == 'hotel_manager':
                return ('created_at', 'updated_at', 'created_by', 'updated_by','hotel','deleted_at')
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
        return self.readonly_fields

    def hotel_name(self, obj):
        return obj.hotel.name
    hotel_name.short_description = "Hotel Name"

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(hotel__manager=request.user.chield)
        return queryset.none()

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            if hasattr(request.user, 'hotel') and request.user.hotel:
                # Establecer el hotel del gerente como valor predeterminado y único
                if 'hotel' in form.base_fields:
                    form.base_fields['hotel'].queryset = form.base_fields['hotel'].queryset.filter(id=request.user.hotel.id)
                    form.base_fields['hotel'].initial = request.user.hotel
                    form.base_fields['hotel'].widget.attrs['readonly'] = True
        return form

    def save_model(self, request, obj, form, change):
        if not change and request.user.user_type == 'hotel_manager':  # Si es una nueva entrada y el usuario es gerente de hotel
            if hasattr(request.user, 'hotel') and request.user.hotel:
                obj.hotel = request.user.hotel
        super().save_model(request, obj, form, change)





# Service -----------

admin_site.register(Offer,OfferAdmin)
admin_site.register(RoomTypeService,RoomTypeServiceAdmin)
admin_site.register(HotelService,HotelServiceAdmin)
admin_site.register(Coupon,CouponAdmin)

