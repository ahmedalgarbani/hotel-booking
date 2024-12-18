from django.contrib import admin
from users.models import CustomUser
from .models import Hotel, Location, Phone, Image, City
from django.contrib.auth import get_user_model
from django import forms
from django.utils.translation import gettext_lazy as _
from users.models.permissions import UserPermission

User = get_user_model()

class HotelManagerAdminMixin:
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        if hasattr(request.user, 'user_type') and request.user.user_type == 'hotel_manager':
            return qs.filter(hotel__manager=request.user)
        return qs.none()

    def has_module_permission(self, request):
        # التحقق من صلاحيات الوصول للوحدة
        if request.user.is_superuser:
            return True
        if not request.user.is_authenticated:
            return False
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'admin':
                return True
            if request.user.user_type == 'hotel_manager':
                user_permissions = UserPermission.objects.filter(
                    user=request.user,
                    is_active=True
                )
                return user_permissions.exists()
        return False

    def has_permission(self, request, permission_name, obj=None):
        if request.user.is_superuser:
            return True
        if not request.user.is_authenticated:
            return False
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'admin':
                return True
            if request.user.user_type == 'hotel_manager':
                user_permissions = UserPermission.objects.filter(
                    user=request.user,
                    is_active=True
                )
                has_perm = any(
                    getattr(perm.permission_group, permission_name, False)
                    for perm in user_permissions
                )
                if obj is None:
                    return has_perm
                return has_perm and obj.hotel.manager == request.user
        return False

    def has_view_permission(self, request, obj=None):
        return self.has_permission(request, 'can_view_hotel', obj)

    def has_change_permission(self, request, obj=None):
        return self.has_permission(request, 'can_edit_hotel', obj)

    def has_delete_permission(self, request, obj=None):
        return self.has_permission(request, 'can_delete_rooms', obj)  # نستخدم صلاحية حذف الغرف كمثال

    def has_add_permission(self, request):
        return self.has_permission(request, 'can_add_rooms')  # نستخدم صلاحية إضافة الغرف كمثال

@admin.register(Hotel)
class HotelAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['name', 'manager', 'location', 'created_at']
    search_fields = ['name', 'manager__username', 'manager__email']
    list_filter = ['location', 'created_at']
    raw_id_fields = ['manager']

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        if hasattr(request.user, 'user_type') and request.user.user_type == 'hotel_manager':
            return qs.filter(manager=request.user)
        return qs.none()

@admin.register(Location)
class LocationAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ('name', 'address', 'city', 'slug', 'created_at')
    readonly_fields = ('slug',)
    search_fields = ('name', 'city__name', 'address')
    list_filter = ('city',)

@admin.register(Phone)
class PhoneAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ('phone_number', 'country_code', 'hotel', 'created_at')
    search_fields = ('phone_number', 'hotel__name')
    list_filter = ('hotel',)

@admin.register(Image)
class ImageAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ('image_path', 'image_url', 'hotel_id', 'created_at')
    search_fields = ('image_path',)

class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'state', 'country', 'slug', 'created_at')
    readonly_fields = ('slug',)
    search_fields = ('name', 'state', 'country')
    list_filter = ('state', 'country')

    def has_module_permission(self, request):
        if not request.user.is_authenticated:
            return False
        return request.user.is_superuser or (hasattr(request.user, 'user_type') and request.user.user_type == 'admin')

    def has_view_permission(self, request, obj=None):
        if not request.user.is_authenticated:
            return False
        return request.user.is_superuser or (hasattr(request.user, 'user_type') and request.user.user_type == 'admin')

    def has_change_permission(self, request, obj=None):
        if not request.user.is_authenticated:
            return False
        return request.user.is_superuser or (hasattr(request.user, 'user_type') and request.user.user_type == 'admin')

    def has_delete_permission(self, request, obj=None):
        if not request.user.is_authenticated:
            return False
        return request.user.is_superuser or (hasattr(request.user, 'user_type') and request.user.user_type == 'admin')

    def has_add_permission(self, request):
        if not request.user.is_authenticated:
            return False
        return request.user.is_superuser or (hasattr(request.user, 'user_type') and request.user.user_type == 'admin')

admin.site.register(City, CityAdmin)
