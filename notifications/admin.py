from django.contrib import admin
from .models import Notifications

class NotificationsAdmin(admin.ModelAdmin):
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


from api.admin import admin_site

# Notification ------------

admin_site.register(Notifications,NotificationsAdmin)

