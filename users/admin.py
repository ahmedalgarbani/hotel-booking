from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.utils.translation import gettext_lazy as _
from django.utils.html import format_html
from django.urls import reverse
from django.utils.safestring import mark_safe
from django.contrib.auth.hashers import make_password
from django.contrib import messages

from .models.user import CustomUser
from .models.hotel_request import HotelAccountRequest
from .models.activity_log import ActivityLog
from .models.permissions import PermissionGroup, UserPermission
from HotelManagement.models import Hotel
from .models.permission_request import PermissionRequest

class UserPermissionInline(admin.TabularInline):
    model = UserPermission
    fk_name = 'user'
    extra = 1
    verbose_name = 'صلاحية'
    verbose_name_plural = 'الصلاحيات'
    fields = ('permission_group', 'is_active')
    autocomplete_fields = ['permission_group']
class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email', 'first_name', 'last_name', 'user_type', 'hotel', 'is_active')
    list_filter = ('user_type', 'hotel', 'is_active', 'date_joined')
    search_fields = ('username', 'first_name', 'last_name', 'email')
    ordering = ('-date_joined',)
    inlines = [UserPermissionInline]
    
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        (_('معلومات شخصية'), {'fields': ('first_name', 'last_name', 'email', 'phone', 'image')}),
        (_('معلومات الوظيفة'), {'fields': ('user_type', 'hotel')}),
        (_('الحالة والصلاحيات الأساسية'), {'fields': ('is_active', 'is_staff', 'is_superuser')}),
    )
    
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'password1', 'password2', 'email', 'first_name', 'last_name', 
                      'phone', 'user_type', 'hotel', 'is_active', 'is_staff'),
        }),
    )
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if not request.user.is_superuser:
            # مدير الفندق يرى فقط موظفي فندقه
            if request.user.user_type == 'hotel_manager':
                return qs.filter(hotel=request.user.hotel)
        return qs
    
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "hotel" and not request.user.is_superuser:
            # مدير الفندق يمكنه اختيار فندقه فقط
            if request.user.user_type == 'hotel_manager':
                kwargs["queryset"] = Hotel.objects.filter(id=request.user.hotel.id)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)
    
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            # مدير الفندق لا يمكنه تغيير بعض الحقول
            return ('is_superuser', 'is_staff', 'user_permissions', 'groups')
        return super().get_readonly_fields(request, obj)

class PermissionGroupAdmin(admin.ModelAdmin):
    list_display = ('name', 'hotel', 'get_permissions_summary', 'created_at')
    list_filter = ('hotel', 'is_superuser', 'can_view_admin', 'created_at')
    search_fields = ('name', 'hotel__name', 'description')
    ordering = ('hotel', 'name')
    autocomplete_fields = ['hotel']
    
    fieldsets = (
        (None, {
            'fields': ('name', 'hotel', 'staff_type', 'description', 'is_system_group')
        }),
        ('الصلاحيات العامة', {
            'fields': ('is_superuser', 'can_view_admin')
        }),
        ('عرض الجداول في لوحة التحكم', {
            'fields': (
                'can_view_hotel_model', 'can_view_image_model', 'can_view_location_model',
                'can_view_city_model', 'can_view_room_model', 'can_view_booking_model',
                'can_view_review_model', 'can_view_service_model', 'can_view_payment_model',
                'can_view_offer_model'
            ),
            'classes': ('collapse',),
            'description': 'التحكم في ظهور وإخفاء الجداول في لوحة التحكم'
        }),
        ('صلاحيات المستخدمين', {
            'fields': (
                'can_view_users', 'can_add_users', 'can_edit_users', 'can_delete_users'
            )
        }),
        ('صلاحيات مجموعات الصلاحيات', {
            'fields': ('can_view_permissions', 'can_manage_permissions')
        }),
        ('صلاحيات الفندق', {
            'fields': ('can_view_hotel', 'can_edit_hotel', 'can_manage_hotel_settings')
        }),
        ('صلاحيات الغرف', {
            'fields': (
                'can_view_rooms', 'can_add_rooms', 'can_edit_rooms', 'can_delete_rooms',
                'can_manage_room_prices', 'can_manage_room_availability'
            )
        }),
        ('صلاحيات الحجوزات', {
            'fields': (
                'can_view_bookings', 'can_add_bookings', 'can_edit_bookings', 'can_delete_bookings',
                'can_confirm_bookings', 'can_cancel_bookings', 'can_modify_booking_prices'
            )
        }),
        ('صلاحيات التقييمات', {
            'fields': (
                'can_view_reviews', 'can_add_reviews', 'can_edit_reviews', 'can_delete_reviews',
                'can_respond_to_reviews'
            )
        }),
        ('صلاحيات العروض والخصومات', {
            'fields': (
                'can_view_offers', 'can_add_offers', 'can_edit_offers', 'can_delete_offers',
                'can_manage_offers', 'can_create_discounts', 'can_modify_discounts', 'can_delete_discounts'
            )
        }),
        ('صلاحيات الخدمات', {
            'fields': (
                'can_view_services', 'can_add_services', 'can_edit_services', 'can_delete_services',
                'can_manage_service_prices'
            )
        }),
        ('صلاحيات المدفوعات', {
            'fields': (
                'can_view_payments', 'can_process_payments', 'can_refund_payments',
                'can_view_payment_reports'
            )
        }),
        ('صلاحيات التقارير والإحصائيات', {
            'fields': (
                'can_view_reports', 'can_export_reports', 'can_view_statistics',
                'can_view_financial_reports'
            )
        }),
        ('صلاحيات إدارة الموظفين', {
            'fields': (
                'can_view_staff', 'can_add_staff', 'can_edit_staff', 'can_delete_staff',
                'can_manage_staff_permissions'
            )
        }),
        ('صلاحيات المواقع والمدن', {
            'fields': (
                'can_view_locations', 'can_add_locations', 'can_edit_locations', 'can_delete_locations',
                'can_manage_cities'
            )
        }),
    )

    def get_permissions_summary(self, obj):
        permissions = []
        if obj.can_view_hotel: permissions.append('عرض الفندق')
        if obj.can_edit_hotel: permissions.append('تعديل الفندق')
        if obj.can_view_rooms: permissions.append('عرض الغرف')
        if obj.can_add_rooms: permissions.append('إضافة غرف')
        return ', '.join(permissions[:3]) + ('...' if len(permissions) > 3 else '')
    get_permissions_summary.short_description = 'الصلاحيات'

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if not request.user.is_superuser:
            # عرض المجموعات المتعلقة بفندق المستخدم فقط
            user_permission = request.user.get_active_permission_group()
            if user_permission and user_permission.hotel:
                qs = qs.filter(hotel=user_permission.hotel)
        return qs

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "hotel" and not request.user.is_superuser:
            # تقييد اختيار الفندق للفندق الخاص بالمستخدم فقط
            user_permission = request.user.get_active_permission_group()
            if user_permission and user_permission.hotel:
                kwargs["queryset"] = Hotel.objects.filter(id=user_permission.hotel.id)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

class UserPermissionAdmin(admin.ModelAdmin):
    list_display = ('user', 'permission_group', 'get_permissions_summary', 'is_active', 'created_at')
    list_filter = ('is_active', 'created_at', 'permission_group__can_view_hotel', 'permission_group__can_edit_hotel')
    search_fields = ('user__username', 'user__email', 'user__first_name', 'user__last_name', 'permission_group__name')
    ordering = ('-created_at',)
    autocomplete_fields = ['user', 'permission_group']
    
    def get_permissions_summary(self, obj):
        return obj.permission_group.get_permissions_summary()
    get_permissions_summary.short_description = 'الصلاحيات'

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if not request.user.is_superuser:
            if request.user.user_type == 'hotel_manager':
                return qs.filter(permission_group__hotel__manager=request.user)
        return qs

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if not request.user.is_superuser:
            if request.user.user_type == 'hotel_manager':
                if db_field.name == "permission_group":
                    kwargs["queryset"] = PermissionGroup.objects.filter(hotel__manager=request.user)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

class HotelAccountRequestAdmin(admin.ModelAdmin):
    list_display = ('hotel_name', 'owner_name', 'email', 'status', 'created_at')
    list_filter = ('status', 'created_at')
    search_fields = ('hotel_name', 'owner_name', 'email', 'phone')
    ordering = ('-created_at',)
    readonly_fields = ('created_at', 'updated_at')
    actions = ['activate_hotel_request', 'reject_hotel_request']
    
    fieldsets = (
        ('معلومات الفندق', {
            'fields': ('hotel_name', 'owner_name', 'email', 'phone', 'hotel_description')
        }),
        ('معلومات العمل', {
            'fields': ('business_license_number', 'document_path')
        }),
        ('حالة الطلب', {
            'fields': ('status', 'admin_notes')
        }),
        ('معلومات الحساب', {
            'fields': ('password', 'verify_number')
        }),
        ('التواريخ', {
            'fields': ('created_at', 'updated_at')
        }),
    )

    def activate_hotel_request(self, request, queryset):
        for hotel_request in queryset.filter(status='pending'):
            try:
                # إنشاء حساب مدير الفندق
                user = CustomUser.objects.create(
                    username=hotel_request.email,
                    email=hotel_request.email,
                    first_name=hotel_request.owner_name,
                    user_type='hotel_manager',
                    is_staff=True,
                    password=make_password(hotel_request.password)
                )
                
                # إنشاء الفندق
                hotel = Hotel.objects.create(
                    name=hotel_request.hotel_name,
                    manager=user,
                    description=hotel_request.hotel_description
                )
                
                # إنشاء مجموعة الصلاحيات الافتراضية
                permission_group = PermissionGroup.objects.create(
                    name=f"مدير {hotel.name}",
                    hotel=hotel,
                    description="مجموعة الصلاحيات الافتراضية لمدير الفندق",
                    is_system_group=True,
                    can_view_hotel=True,
                    can_edit_hotel=True,
                    can_view_rooms=True,
                    can_add_rooms=True,
                    can_edit_rooms=True,
                    can_delete_rooms=True,
                    can_view_bookings=True,
                    can_manage_bookings=True,
                    can_view_reviews=True,
                    can_manage_reviews=True,
                    can_view_offers=True,
                    can_manage_offers=True
                )
                
                # ربط المستخدم بمجموعة الصلاحيات
                UserPermission.objects.create(
                    user=user,
                    permission_group=permission_group,
                    is_active=True
                )
                
                hotel_request.status = 'approved'
                hotel_request.save()
                
                messages.success(request, f'تم تفعيل حساب {hotel_request.hotel_name} بنجاح')
            except Exception as e:
                messages.error(request, f'حدث خطأ أثناء تفعيل حساب {hotel_request.hotel_name}: {str(e)}')
    
    activate_hotel_request.short_description = "تفعيل الحسابات المحددة"
    
    def reject_hotel_request(self, request, queryset):
        queryset.filter(status='pending').update(status='rejected')
        messages.success(request, f'تم رفض {queryset.count()} طلب/طلبات بنجاح')
    
    reject_hotel_request.short_description = "رفض الطلبات المحددة"

class ActivityLogAdmin(admin.ModelAdmin):
    list_display = ('user', 'action', 'table_name', 'record_id', 'created_at')
    list_filter = ('action', 'created_at', 'user')
    search_fields = ('user__username', 'table_name', 'details')
    readonly_fields = ('created_at', 'updated_at')
    ordering = ('-created_at',)

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if not request.user.is_superuser:
            if request.user.user_type == 'hotel_manager':
                return qs.filter(user=request.user)
        return qs

class PermissionRequestAdmin(admin.ModelAdmin):
    list_display = ('requester', 'target_user', 'hotel', 'status', 'created_at')
    list_filter = ('status', 'hotel', 'created_at')
    search_fields = ('requester__username', 'target_user__username', 'hotel__name')
    readonly_fields = ('created_at', 'updated_at')
    
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if not request.user.is_superuser:
            # عرض الطلبات المتعلقة بفنادق المستخدم فقط
            user_permission = request.user.get_active_permission_group()
            if user_permission:
                qs = qs.filter(hotel=user_permission.hotel)
        return qs
    
    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser:
            return True
        # السماح لمدير الفندق بتعديل الطلبات المتعلقة بفندقه فقط
        user_permission = request.user.get_active_permission_group()
        return user_permission and user_permission.can_manage_staff_for_hotel(obj.hotel)
    
    def has_delete_permission(self, request, obj=None):
        return self.has_change_permission(request, obj)

admin.site.register(CustomUser, CustomUserAdmin)
admin.site.register(PermissionGroup, PermissionGroupAdmin)
admin.site.register(UserPermission, UserPermissionAdmin)
admin.site.register(HotelAccountRequest, HotelAccountRequestAdmin)
admin.site.register(ActivityLog, ActivityLogAdmin)
admin.site.register(PermissionRequest, PermissionRequestAdmin)