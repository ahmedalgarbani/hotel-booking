from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from django.utils.html import format_html

from users.models import ActivityLog


class ActivityLogAdmin(admin.ModelAdmin):
    model = ActivityLog
    list_display = ['user_display', 'action_display', 'table_name_display', 'created_at_display']
    list_filter = ['action', 'created_at', 'user__user_type']
    search_fields = ['user__username', 'user__email', 'table_name', 'details']
    readonly_fields = ['user', 'action', 'table_name', 'record_id', 'details', 'ip_address', 'created_at']

    def has_add_permission(self, request):
        return False

    def has_change_permission(self, request, obj=None):
        return False

    def has_delete_permission(self, request, obj=None):
        return request.user.is_superuser

    def user_display(self, obj):
        return f"{obj.user.get_full_name()} ({obj.user.get_user_type_display()})"
    user_display.short_description = _('المستخدم')

    def action_display(self, obj):
        action_colors = {
            'create': 'green',
            'update': 'orange',
            'delete': 'red',
            'login': 'blue',
            'logout': 'gray'
        }
        return format_html(
            '<span style="color: {};">{}</span>',
            action_colors.get(obj.action, 'black'),
            obj.get_action_display()
        )
    action_display.short_description = _('الإجراء')

    def table_name_display(self, obj):
        return obj.table_name
    table_name_display.short_description = _('الجدول')

    def created_at_display(self, obj):
        return obj.created_at.strftime("%Y-%m-%d %H:%M")
    created_at_display.short_description = _('التاريخ')
