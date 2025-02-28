from django.contrib import admin
from .admin_configurations.user_admin import CustomUserAdmin
from .admin_configurations.group_admin import CustomGroupAdmin
from .admin_configurations.activity_log_admin import ActivityLogAdmin
from django.contrib.auth.models import Group

admin.site.unregister(Group)
admin.site.register(Group, CustomGroupAdmin)
admin.site.register(CustomUserAdmin.model, CustomUserAdmin)
admin.site.register(ActivityLogAdmin.model, ActivityLogAdmin)