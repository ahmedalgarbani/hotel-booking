from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.hashers import make_password
from django.contrib import messages
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import Group
from .models import CustomUser, HotelAccountRequest

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email', 'first_name', 'last_name', 'user_type', 'is_active')
    list_filter = ('user_type', 'is_active', 'is_staff')
    search_fields = ('username', 'email', 'first_name', 'last_name')
    ordering = ('username',)
    
    fieldsets = (
        (_('معلومات الحساب'), {'fields': ('username', 'password')}),
        (_('المعلومات الشخصية'), {'fields': ('first_name', 'last_name', 'email')}),
        (_('نوع المستخدم'), {'fields': ('user_type',)}),
        (_('الصلاحيات'), {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
        }),
        (_('تواريخ مهمة'), {'fields': ('last_login', 'date_joined')}),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'password1', 'password2', 'user_type'),
        }),
    )
    def has_add_permission(self, request):
        return request.user.is_superuser

    def has_change_permission(self, request, obj=None):
        return request.user.is_superuser

    def has_view_permission(self, request, obj=None):
        return request.user.is_superuser
    def get_readonly_fields(self, request, obj=None):
        if obj: 
            return ['username', 'date_joined', 'last_login']
        return []

    def save_model(self, request, obj, form, change):
        if not change and obj.user_type == 'hotel_manager':
            obj.is_staff = True
            obj.save()
            hotel_group = Group.objects.get_or_create(name='Hotel Managers')[0]
            obj.groups.add(hotel_group)
        super().save_model(request, obj, form, change)

    def username_display(self, obj):
        return obj.username
    username_display.short_description = _('اسم المستخدم')

    def email_display(self, obj):
        return obj.email
    email_display.short_description = _('البريد الإلكتروني')

    def user_type_display(self, obj):
        return obj.get_user_type_display()
    user_type_display.short_description = _('نوع المستخدم')

    def is_active_display(self, obj):
        return obj.is_active
    is_active_display.short_description = _('نشط')
    is_active_display.boolean = True

    list_display = ['username_display', 'email_display', 'user_type_display', 'is_active_display']

@admin.register(HotelAccountRequest)
class HotelAccountRequestAdmin(admin.ModelAdmin):
    list_filter = ['status']
    list_display_links = ['hotel_name_display']
    search_fields = ['hotel_name', 'owner_name', 'email']
    actions = ['approve_hotel_request', 'deactivate_hotel_request']

    def hotel_name_display(self, obj):
        return obj.hotel_name
    hotel_name_display.short_description = _('اسم الفندق')

    def owner_name_display(self, obj):
        return obj.owner_name
    owner_name_display.short_description = _('اسم المالك')

    def email_display(self, obj):
        return obj.email
    email_display.short_description = _('البريد الإلكتروني')

    def status_display(self, obj):
        return obj.get_status_display()
    status_display.short_description = _('الحالة')

    list_display = ['hotel_name_display', 'owner_name_display', 'email_display', 'status_display']

    def approve_hotel_request(self, request, queryset):
        for hotel_request in queryset:
            try:
                # Create user account
                user = CustomUser.objects.create(
                    username=hotel_request.email,  # Using email as username for uniqueness
                    email=hotel_request.email,
                    first_name=hotel_request.owner_name,
                    user_type='hotel_manager',
                    is_staff=True,  # Give them access to admin panel
                )
                user.set_password(hotel_request.password)
                user.save()

                # Add user to hotel managers group
                hotel_group = Group.objects.get_or_create(name='Hotel Managers')[0]
                user.groups.add(hotel_group)

                # Update request status
                hotel_request.status = 'approved'
                hotel_request.save()

                messages.success(
                    request,
                    _(f'تم إنشاء حساب مدير الفندق بنجاح: {hotel_request.hotel_name}')
                )
            except Exception as e:
                messages.error(
                    request,
                    _(f'حدث خطأ أثناء إنشاء حساب مدير الفندق {hotel_request.hotel_name}: {str(e)}')
                )

    approve_hotel_request.short_description = _("الموافقة على طلبات الفنادق المحددة")


    def deactivate_hotel_request(self, request, queryset):
        for hotel_request in queryset:
            try:
                
                user = CustomUser.objects.filter(
                    username=hotel_request.hotel_name,
                    email=hotel_request.email,
                    user_type='hotel_manager'
                ).first()
                
                if user:
                    user.is_active = False
                    user.save()
                    
               

                hotel_request.status = 'cancelled'
                hotel_request.save()
                
                self.message_user(
                    request,
                    f"تم إلغاء تفعيل حساب المستخدم للفندق: {hotel_request.hotel_name}",
                    level=messages.SUCCESS
                )
            except Exception as e:
                self.message_user(
                    request,
                    f"خطأ في إلغاء تفعيل حساب المستخدم للفندق {hotel_request.hotel_name}: {str(e)}",
                    level=messages.ERROR
                )
    deactivate_hotel_request.short_description = _("إلغاء تفعيل الفنادق المحددة")