from django.contrib import admin
from django.contrib.auth.admin import UserAdmin, GroupAdmin
from django.contrib.auth.models import Group, Permission
from django.utils.translation import gettext_lazy as _
from django.urls import path
from django.template.response import TemplateResponse
from django.shortcuts import redirect
from django.contrib import messages
from django.contrib.contenttypes.models import ContentType
from django.apps import apps
from django.contrib.auth.hashers import make_password
from django.utils.html import format_html
from django.db.models import Q
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.urls import reverse

from .models import CustomUser, ActivityLog



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


admin.site.unregister(Group)
admin.site.register(Group, CustomGroupAdmin)


@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    list_display = ('username_display', 'email_display', 'full_name_display', 'user_type_display', 'phone_display', 'is_active_display', 'manage_permissions_button')
    list_filter = ('user_type', 'is_active', 'is_staff', 'created_at')
    search_fields = ('username', 'email', 'first_name', 'last_name', 'phone')
    ordering = ('-created_at',)
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'password1', 'password2', 'first_name', 'last_name', 'phone', 'image', 'user_type', 'is_staff', 'is_superuser'),
        }),
    )

    fieldsets = (
        (_('معلومات الحساب'), {
            'fields': ('username', 'password', 'email', 'phone')
        }),
        (_('المعلومات الشخصية'), {
            'fields': ('first_name', 'last_name', 'image')
        }),
        (_('الصلاحيات'), {
            'fields': ('user_type', 'is_active', 'is_staff', 'is_superuser', 'chield'),
        }),
    )

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        # إذا كان المستخدم مدير فندق، اعرض فقط الموظفين التابعين له
        if request.user.user_type == 'hotel_manager':
            return qs.filter(chield=request.user) 
        return qs.none()  # لا تعرض أي مستخدمين للمستخدمين العاديين

    def has_module_permission(self, request):
        # السماح للمشرف ومدراء الفنادق بالوصول إلى وحدة المستخدمين
        if not request.user.is_authenticated:
            return False
        return request.user.is_superuser or request.user.user_type == 'hotel_manager'

    def has_add_permission(self, request):
        # السماح للمشرف ومدراء الفنادق بإضافة مستخدمين
        if not request.user.is_authenticated:
            return False
        return request.user.is_superuser or request.user.user_type == 'hotel_manager'

    def has_change_permission(self, request, obj=None):
        # التحقق من تسجيل دخول المستخدم
        if not request.user.is_authenticated:
            return False
        # السماح للمشرف بتعديل أي مستخدم
        if request.user.is_superuser:
            return True
        # السماح لمدير الفندق بتعديل موظفيه فقط
        if request.user.user_type == 'hotel_manager':
            if obj is None:  # عند عرض القائمة
                return True
            return obj.chield == request.user
        return False

    def has_delete_permission(self, request, obj=None):
        # التحقق من تسجيل دخول المستخدم
        if not request.user.is_authenticated:
            return False
        # السماح للمشرف بحذف أي مستخدم
        if request.user.is_superuser:
            return True
        # السماح لمدير الفندق بحذف موظفيه فقط
        if request.user.user_type == 'hotel_manager':
            if obj is None:  # عند عرض القائمة
                return True
            return obj.chield == request.user
        return False

    def has_view_permission(self, request, obj=None):
        # التحقق من تسجيل دخول المستخدم
        if not request.user.is_authenticated:
            return False
        # السماح للمشرف بعرض أي مستخدم
        if request.user.is_superuser:
            return True
        # السماح لمدير الفندق بعرض موظفيه فقط
        if request.user.user_type == 'hotel_manager':
            if obj is None:  # عند عرض القائمة
                return True
            return obj.chield == request.user
        return False

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser:
            if request.user.user_type == 'hotel_manager':
                # إخفاء الحقول الحساسة من مدير الفندق
                sensitive_fields = ['is_superuser', 'user_permissions', 'groups']
                for field in sensitive_fields:
                    if field in form.base_fields:
                        del form.base_fields[field]

                # تعطيل تعديل بعض الحقول
                if obj:  # في حالة تعديل موظف موجود
                    if 'user_type' in form.base_fields:
                        form.base_fields['user_type'].disabled = True
                    if 'is_staff' in form.base_fields:
                        form.base_fields['is_staff'].disabled = True
                    if 'chield' in form.base_fields:
                        form.base_fields['chield'].disabled = True
            else:
                # إخفاء جميع الحقول الحساسة من الموظفين العاديين
                sensitive_fields = ['is_superuser', 'is_staff', 'user_permissions', 'groups', 'user_type', 'chield']
                for field in sensitive_fields:
                    if field in form.base_fields:
                        del form.base_fields[field]
        return form

    def save_model(self, request, obj, form, change):
        if not change:  # عند إنشاء مستخدم جديد
            if request.user.is_superuser:
                # لا تغير أي شيء، اترك الإعدادات كما هي
                pass
            elif request.user.user_type == 'hotel_manager':
                obj.user_type = 'hotel_staff'
                obj.chield = request.user
                obj.is_staff = True
        super().save_model(request, obj, form, change)

    def get_fieldsets(self, request, obj=None):
        if request.user.is_superuser:
            return (
                (_('معلومات الحساب'), {
                    'fields': ('username', 'password', 'email', 'phone')
                }),
                (_('المعلومات الشخصية'), {
                    'fields': ('first_name', 'last_name', 'image')
                }),
                (_('الصلاحيات'), {
                    'fields': ('user_type', 'is_active', 'is_staff', 'is_superuser', 'chield', 'groups', 'user_permissions'),
                }),
            )
        elif request.user.user_type == 'hotel_manager':
            if not obj:  # نموذج إضافة موظف جديد
                return (
                    (_('معلومات الحساب'), {
                        'fields': ('username', 'password1', 'password2', 'email', 'phone')
                    }),
                    (_('المعلومات الشخصية'), {
                        'fields': ('first_name', 'last_name', 'image')
                    }),
                )
            else:  # نموذج تعديل موظف
                return (
                    (_('معلومات الحساب'), {
                        'fields': ('username', 'password', 'email', 'phone')
                    }),
                    (_('المعلومات الشخصية'), {
                        'fields': ('first_name', 'last_name', 'image')
                    }),
                    (_('الحالة'), {
                        'fields': ('is_active',),
                    }),
                )
        return self.fieldsets

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                '<int:user_id>/manage-permissions/',
                self.admin_site.admin_view(self.manage_staff_permissions),
                name='customuser_manage_permissions'
            ),
        ]
        return custom_urls + urls

    def manage_staff_permissions(self, request, user_id):
        """إدارة صلاحيات الموظف من قبل مدير الفندق"""
        if not request.user.is_authenticated or request.user.user_type != 'hotel_manager':
            messages.error(request, 'ليس لديك الصلاحية للقيام بهذه العملية')
            return redirect('admin:users_customuser_changelist')

        staff_user = self.get_queryset(request).filter(id=user_id).first()
        if not staff_user or staff_user.chield != request.user:
            messages.error(request, 'لا يمكنك إدارة صلاحيات هذا المستخدم')
            return redirect('admin:users_customuser_changelist')

        if request.method == 'POST':
            # الحصول على الصلاحيات المحددة من النموذج
            selected_permissions = request.POST.getlist('permissions')
            
            # الحصول على جميع صلاحيات مدير الفندق من المجموعات
            manager_groups = request.user.groups.all()
            manager_permissions = Permission.objects.filter(group__in=manager_groups)
            
            # تحديث صلاحيات الموظف (فقط الصلاحيات التي يملكها المدير)
            valid_permissions = manager_permissions.filter(id__in=selected_permissions)
            staff_user.user_permissions.set(valid_permissions)
            
            messages.success(request, f'تم تحديث صلاحيات الموظف {staff_user.get_full_name()}')
            return redirect('admin:users_customuser_changelist')

        # الحصول على صلاحيات مدير الفندق من المجموعات
        manager_groups = request.user.groups.all()
        available_permissions = Permission.objects.filter(group__in=manager_groups)
        
        # تنظيم الصلاحيات حسب التطبيق
        organized_permissions = self.organize_permissions(available_permissions)
        current_permissions = staff_user.user_permissions.all()

        context = {
            'title': f'إدارة صلاحيات الموظف: {staff_user.get_full_name()}',
            'subtitle': 'اختر الصلاحيات التي تريد منحها للموظف',
            'user': staff_user,
            'organized_permissions': organized_permissions,
            'current_permissions': current_permissions,
            'is_nav_sidebar_enabled': True,
            'has_permission': True,
            'site_url': '/',
            'site_title': self.admin_site.site_title,
            'site_header': self.admin_site.site_header,
        }

        return TemplateResponse(
            request,
            'admin/users/customuser/manage_permissions.html',
            context
        )

    def get_available_permissions(self, manager):
        """الحصول على الصلاحيات المتاحة لمدير الفندق ليمنحها لموظفيه"""
        # الحصول على صلاحيات مدير الفندق من المجموعات فقط
        manager_permissions = set()
        
        # إضافة الصلاحيات من المجموعات
        for group in manager.groups.all():
            manager_permissions.update(group.permissions.all())
        
        return list(manager_permissions)

    def organize_permissions(self, permissions):
        """تنظيم الصلاحيات حسب التطبيق والنموذج"""
        organized = {}
        
        for perm in permissions:
            app_label = perm.content_type.app_label
            model_name = perm.content_type.model
            
            if app_label not in organized:
                organized[app_label] = {
                    'name': app_label,
                    'models': {}
                }
            
            if model_name not in organized[app_label]['models']:
                organized[app_label]['models'][model_name] = {
                    'name': model_name,
                    'permissions': []
                }
            
            organized[app_label]['models'][model_name]['permissions'].append(perm)
        
        return organized

    def change_view(self, request, object_id, form_url='', extra_context=None):
        extra_context = extra_context or {}
        if request.user.user_type == 'hotel_manager':
            obj = self.get_object(request, object_id)
            if obj and obj.chield == request.user:
                extra_context['show_permissions_link'] = True
        return super().change_view(
            request, object_id, form_url, extra_context=extra_context,
        )

    def manage_permissions_button(self, obj):
        if obj.user_type == 'hotel_staff':
            url = reverse('admin:customuser_manage_permissions', args=[obj.pk])
            return format_html(
                '<a class="button" href="{}">{}</a>',
                url,
                'إدارة الصلاحيات'
            )
        return ''
    manage_permissions_button.short_description = 'إدارة الصلاحيات'
    manage_permissions_button.allow_tags = True

    readonly_fields = ('created_at', 'updated_at', 'last_login', 'date_joined')

    def get_readonly_fields(self, request, obj=None):
        if obj: 
            return ['username', 'date_joined', 'last_login', 'created_at', 'updated_at']
        return ['created_at', 'updated_at']

    def username_display(self, obj):
        return obj.username
    username_display.short_description = _('اسم المستخدم')

    def email_display(self, obj):
        return obj.email
    email_display.short_description = _('البريد الإلكتروني')

    def full_name_display(self, obj):
        return obj.get_full_name()
    full_name_display.short_description = _('الاسم الكامل')

    def phone_display(self, obj):
        return obj.phone or '-'
    phone_display.short_description = _('رقم الهاتف')

    def user_type_display(self, obj):
        return obj.get_user_type_display()
    user_type_display.short_description = _('نوع المستخدم')

    def is_active_display(self, obj):
        return obj.is_active
    is_active_display.short_description = _('نشط')
    is_active_display.boolean = True

@admin.register(ActivityLog)
class ActivityLogAdmin(admin.ModelAdmin):
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