# users/admin.py
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.hashers import make_password
from django.contrib import messages
from .models import CustomUser, HotelAccountRequest

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    list_display = ['username', 'email', 'user_type', 'is_active']
    list_filter = ['user_type', 'is_active']
    search_fields = ['username', 'email']

@admin.register(HotelAccountRequest)
class HotelAccountRequestAdmin(admin.ModelAdmin):
    list_display = ['hotel_name', 'owner_name', 'email', 'status']
    list_filter = ['status']
    actions = ['approve_hotel_request']

    def approve_hotel_request(self, request, queryset):
        for hotel_request in queryset:
            try:
                # إنشاء حساب مستخدم جديد
                user = CustomUser.objects.create(
                    username=hotel_request.hotel_name,
                    email=hotel_request.email,
                    first_name=hotel_request.owner_name,
                    user_type='hotel_manager',
                    phone=hotel_request.phone,
                    password=make_password(hotel_request.password),
                    is_active=True
                )
                
                # تحديث حالة الطلب إلى مقبول
                hotel_request.status = 'approved'
                hotel_request.save()
                
                self.message_user(
                    request,
                    f"تم إنشاء حساب المستخدم بنجاح للفندق: {hotel_request.hotel_name}",
                    level=messages.SUCCESS
                )
            except Exception as e:
                self.message_user(
                    request,
                    f"خطأ في إنشاء حساب المستخدم للفندق {hotel_request.hotel_name}: {str(e)}",
                    level=messages.ERROR
                )
    approve_hotel_request.short_description = "الموافقة على طلبات الفنادق المحددة"