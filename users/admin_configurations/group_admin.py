from django.contrib import admin
from django.contrib.auth.admin import GroupAdmin
from django.contrib.auth.models import Group, Permission
from django.urls import path, reverse
from django.utils.html import format_html
from django.shortcuts import redirect
from django.contrib import messages
from django.template.response import TemplateResponse
from django.contrib.contenttypes.models import ContentType


class CustomGroupAdmin(GroupAdmin):
    list_display = ['name', 'permissions_count', 'manage_permissions_button']

    def permissions_count(self, obj):
        return obj.permissions.count()
    permissions_count.short_description = 'عدد الصلاحيات'

    def manage_permissions_button(self, obj):
        url = reverse('admin:manage-group-permissions', args=[obj.id])
        return format_html('<a class="button" href="{}">{}</a>', url, 'إدارة الصلاحيات')
    manage_permissions_button.short_description = 'إدارة الصلاحيات'
    manage_permissions_button.allow_tags = True

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                '<int:group_id>/manage-permissions/',
                self.admin_site.admin_view(self.manage_permissions_view),
                name='manage-group-permissions',
            ),
        ]
        return custom_urls + urls

    def manage_permissions_view(self, request, group_id):
        group = Group.objects.get(id=group_id)

        if request.method == 'POST':
            # حذف كل الصلاحيات الحالية
            group.permissions.clear()

            # إضافة الصلاحيات المحددة
            selected_permissions = request.POST.getlist('permissions')
            permissions = Permission.objects.filter(id__in=selected_permissions)
            group.permissions.add(*permissions)

            messages.success(request, f'تم تحديث صلاحيات مجموعة {group.name} بنجاح')
            return redirect('admin:auth_group_changelist')

        # تنظيم الصلاحيات حسب نوع المحتوى
        content_types = ContentType.objects.all().order_by('app_label', 'model')

        organized_permissions = {}
        for ct in content_types:
            permissions = Permission.objects.filter(content_type=ct)
            if permissions.exists():
                app_label = ct.app_label.replace('_', ' ').title()
                model_name = ct.model.replace('_', ' ').title()

                if app_label not in organized_permissions:
                    organized_permissions[app_label] = {}

                organized_permissions[app_label][model_name] = {
                    'permissions': permissions,
                    'selected': group.permissions.all()
                }

        context = {
            'title': f'إدارة صلاحيات مجموعة: {group.name}',
            'group': group,
            'organized_permissions': organized_permissions,
            'is_nav_sidebar_enabled': True,
            'has_permission': True,
            'site_url': '/',
            'site_title': self.admin_site.site_title,
            'site_header': self.admin_site.site_header,
        }

        return TemplateResponse(request, 'admin/users/group/manage_permissions.html', context)

    def change_view(self, request, object_id, form_url='', extra_context=None):
        extra_context = extra_context or {}
        group = Group.objects.get(pk=object_id)
        extra_context['show_permissions_link'] = True
        return super().change_view(
            request, object_id, form_url, extra_context=extra_context,
        )
