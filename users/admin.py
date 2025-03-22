from django.contrib import admin

from users.models import ActivityLog, CustomUser
from .admin_configurations.user_admin import CustomUserAdmin
from .admin_configurations.group_admin import CustomGroupAdmin
from .admin_configurations.activity_log_admin import ActivityLogAdmin
from django.contrib.auth.models import Group
from api.admin import admin_site









# User -----------



admin_site.register(Group,CustomGroupAdmin)
admin_site.register(CustomUser,CustomUserAdmin)
admin_site.register(ActivityLog,ActivityLogAdmin)