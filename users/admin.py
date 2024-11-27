from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser,  HotelAccountRequest
from .models import HotelAccountRequest
class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email', 'user_type',  'is_staff')
    list_filter = ('user_type', 'is_staff', 'is_superuser', )
    fieldsets = UserAdmin.fieldsets + (
        ('Additional Info', {'fields': ('user_type', 'phone')}),
    )
    add_fieldsets = UserAdmin.add_fieldsets + (
        ('Additional Info', {'fields': ('user_type', 'phone')}),
    )

admin.site.register(CustomUser, CustomUserAdmin)

admin.site.register(HotelAccountRequest)