# users/admin.py
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    list_display = ['username', 'email', 'user_type', 'is_active']
    list_filter = ['user_type', 'is_active']
    search_fields = ['username', 'email']
    
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        # إذا كان المستخدم مدير نظام
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        # إذا كان المستخدم مدير فندق
        elif request.user.user_type == 'hotel_manager':
            # يمكنه رؤية نفسه فقط
            return queryset.filter(id=request.user.id)
        # إذا كان المستخدم عميل
        return queryset.filter(id=request.user.id)

    def has_add_permission(self, request):
        # فقط مدير النظام يمكنه إضافة مستخدمين
        return request.user.is_superuser or request.user.user_type == 'admin'

    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        # مدير النظام يمكنه تعديل أي مستخدم
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        # المستخدم يمكنه تعديل بياناته فقط
        return obj.id == request.user.id

    def has_delete_permission(self, request, obj=None):
        # فقط مدير النظام يمكنه حذف المستخدمين
        return request.user.is_superuser or request.user.user_type == 'admin'