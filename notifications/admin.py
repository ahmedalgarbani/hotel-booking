from django.contrib import admin
from .models import Notifications

class AutoUserTrackMixin:
    
    def save_model(self, request, obj, form, change):
        if not obj.pk: 
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)



class NotificationsAdmin(AutoUserTrackMixin ,admin.ModelAdmin):
    list_display = ('sender', 'user', 'message', 'send_time', 'status', 'notification_type', 'is_active')
    list_filter = ('status', 'notification_type', 'is_active', 'send_time')
    search_fields = ('sender__username', 'user__username', 'message')
    ordering = ('-send_time',)
    actions = ['mark_as_read', 'mark_as_unread']

    def mark_as_read(self, request, queryset):
        queryset.update(status='1')
    mark_as_read.short_description = "تحديد كمقروء"

    def mark_as_unread(self, request, queryset):
        queryset.update(status='0')
    mark_as_unread.short_description = "تحديد كغير مقروء"
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','sender', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(user=request.user)
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(user=request.user.chield)
        return queryset.none()


from api.admin import admin_site

# Notification ------------

admin_site.register(Notifications,NotificationsAdmin)

