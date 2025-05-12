from django.contrib import admin

from users.models import ActivityLog, CustomUser
from .admin_configurations.user_admin import CustomUserAdmin
from .admin_configurations.group_admin import CustomGroupAdmin
from .admin_configurations.activity_log_admin import ActivityLogAdmin
from django.contrib.auth.models import Group
from api.admin import admin_site



# import random
# from django.contrib import admin
# from django.utils import timezone
# from .models import CustomUser, ActivityLog
# from accounts.services import create_chart_of_account 

# class CustomUserAdmin(admin.ModelAdmin):
#     list_display = ('username', 'email', 'user_type', 'created_at', 'updated_at')
#     search_fields = ('username', 'email', 'phone')
#     list_filter = ('user_type', 'is_active')

#     def save_model(self, request, obj, form, change):
#         is_create = not change
#         super().save_model(request, obj, form, change)

#         ActivityLog.objects.create(
#             user=request.user,
#             table_name=obj._meta.db_table,
#             record_id=obj.pk,
#             action='create' if is_create else 'update',
#             details={
#                 'username': obj.username,
#                 'email': obj.email,
#                 'user_type': obj.user_type
#             },
#             ip_address=self.get_client_ip(request)
#         )

#         if is_create and obj.user_type == 'customer':
#             first = obj.first_name or ""
#             last = obj.last_name or ""
#             random_number = random.randint(1000, 9999)

#             create_chart_of_account(
#                 account_number=f"110{random_number}",
#                 account_name=f"عملاء دائمون - {first}{last}",
#                 account_type="Asset",
#                 account_balance=0,
#                 account_parent=7,
#                 account_description="الحسابات المدينة / العملاء",
#                 account_status=True,
#             )

#     def get_client_ip(self, request):
#         x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
#         if x_forwarded_for:
#             return x_forwarded_for.split(',')[0]
#         return request.META.get('REMOTE_ADDR')



# User -----------



admin_site.register(Group,CustomGroupAdmin)
admin_site.register(CustomUser,CustomUserAdmin)
admin_site.register(ActivityLog,ActivityLogAdmin)