from django.contrib import admin
from django.contrib.auth.admin import UserAdmin, GroupAdmin
from django.contrib.auth.hashers import make_password
from django.contrib import messages
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import Group, Permission
from django.utils.html import format_html
from .models import CustomUser, HotelAccountRequest, ActivityLog
from django.urls import path
from django.shortcuts import render, redirect
from django.template.response import TemplateResponse
from django.db.models import Q
from django.contrib.contenttypes.models import ContentType

from django.contrib.auth.models import Permission
from django.db.models.signals import post_save
from django.dispatch import receiver


@receiver(post_save, sender=CustomUser)
def assign_permissions(sender, instance, created, **kwargs):
    if created:
        if instance.user_type == 'admin':
            instance.user_permissions.add(
                Permission.objects.get(codename='can_approve_request'),
                Permission.objects.get(codename='can_reject_request')
            )
        elif instance.user_type == 'hotel_manager':
            instance.user_permissions.add(
                Permission.objects.get(codename='can_approve_request')
            )


class CustomGroupAdmin(GroupAdmin):
    list_display = ['name', 'permissions_count']

    def permissions_count(self, obj):
        return obj.permissions.count()
    permissions_count.short_description = 'عدد الصلاحيات'

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
    list_display = ('username_display', 'email_display', 'full_name_display', 'user_type_display', 'phone_display', 'is_active_display')
    list_filter = ('user_type', 'is_active', 'is_staff', 'created_at')
    search_fields = ('username', 'email', 'first_name', 'last_name', 'phone')
    ordering = ('-created_at',)

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        # إذا كان المستخدم مدير فندق، اعرض فقط الموظفين التابعين له
        if request.user.user_type == 'hotel_manager':
            return qs.filter(chield=request.user)
        return qs.none()  # لا تعرض أي مستخدمين للمستخدمين العاديين

    def has_add_permission(self, request):
        # السماح لمدير الفندق بإضافة موظفين فقط
        if request.user.is_superuser:
            return True
        return request.user.user_type == 'hotel_manager'

    def has_change_permission(self, request, obj=None):
        if request.user.is_superuser:
            return True
        # السماح لمدير الفندق بتعديل موظفيه فقط
        if obj and request.user.user_type == 'hotel_manager':
            return obj.chield == request.user
        return False

    def has_delete_permission(self, request, obj=None):
        if request.user.is_superuser:
            return True
        # السماح لمدير الفندق بحذف موظفيه فقط
        if obj and request.user.user_type == 'hotel_manager':
            return obj.chield == request.user
        return False

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            # تعيين المدير الحالي كمدير للموظف الجديد تلقائياً
            form.base_fields['chield'].initial = request.user
            form.base_fields['chield'].disabled = True
            # تقييد نوع المستخدم للموظفين فقط
            form.base_fields['user_type'].choices = [('customer', 'عميل')]
            # إخفاء بعض الحقول غير الضرورية
            if 'is_superuser' in form.base_fields:
                del form.base_fields['is_superuser']
            if 'is_staff' in form.base_fields:
                del form.base_fields['is_staff']
            if 'user_permissions' in form.base_fields:
                del form.base_fields['user_permissions']
            if 'groups' in form.base_fields:
                del form.base_fields['groups']
        return form

    fieldsets = (
        (_('معلومات الحساب'), {
            'fields': ('username', 'password', 'email', 'phone')
        }),
        (_('المعلومات الشخصية'), {
            'fields': ('first_name', 'last_name', 'image')
        }),
        (_('نوع المستخدم'), {
            'fields': ('user_type', 'chield')
        }),
        (_('الصلاحيات'), {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
            'classes': ('collapse',)
        }),
        (_('تواريخ مهمة'), {
            'fields': ('last_login', 'date_joined', 'created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'phone', 'password1', 'password2', 'user_type', 'first_name', 'last_name', 'chield'),
        }),
    )

    readonly_fields = ('created_at', 'updated_at', 'last_login', 'date_joined')

    def get_readonly_fields(self, request, obj=None):
        if obj: 
            return ['username', 'date_joined', 'last_login', 'created_at', 'updated_at']
        return ['created_at', 'updated_at']

    def save_model(self, request, obj, form, change):
        if not change and obj.user_type == 'hotel_manager':
            obj.is_staff = True
            obj.save()
            hotel_group = Group.objects.get_or_create(name='Hotel Managers')[0]
            obj.groups.add(hotel_group)
        super().save_model(request, obj, form, change)

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

@admin.register(HotelAccountRequest)
class HotelAccountRequestAdmin(admin.ModelAdmin):
    list_display = [
        'hotel_name_display', 
        'owner_name_display', 
        'email_display', 
        'phone_display',
        'status_display', 
        'created_at_display'
    ]
    list_filter = ['status', 'created_at']
    list_display_links = ['hotel_name_display']
    search_fields = ['hotel_name', 'owner_name', 'email', 'phone']
    readonly_fields = ['created_at', 'updated_at']
    actions = ['approve_hotel_request', 'reject_hotel_request', 'deactivate_hotel_request']

    fieldsets = (
        (_('معلومات الفندق'), {
            'fields': ('hotel_name', 'hotel_description', 'business_license_number')
        }),
        (_('معلومات المالك'), {
            'fields': ('owner_name', 'email', 'phone')
        }),
        (_('المستندات'), {
            'fields': ('document_path', 'verify_number')
        }),
        (_('حالة الطلب'), {
            'fields': ('status', 'admin_notes')
        }),
        (_('معلومات النظام'), {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )

    def hotel_name_display(self, obj):
        return obj.hotel_name
    hotel_name_display.short_description = _('اسم الفندق')

    def owner_name_display(self, obj):
        return obj.owner_name
    owner_name_display.short_description = _('اسم المالك')

    def email_display(self, obj):
        return obj.email
    email_display.short_description = _('البريد الإلكتروني')

    def phone_display(self, obj):
        return obj.phone
    phone_display.short_description = _('رقم الهاتف')

    def status_display(self, obj):
        status_colors = {
            'pending': 'orange',
            'approved': 'green',
            'rejected': 'red',
            'cancelled': 'gray'
        }
        return format_html(
            '<span style="color: {};">{}</span>',
            status_colors.get(obj.status, 'black'),
            obj.get_status_display()
        )
    status_display.short_description = _('الحالة')

    def created_at_display(self, obj):
        return obj.created_at.strftime("%Y-%m-%d %H:%M")
    created_at_display.short_description = _('تاريخ الطلب')

    def approve_hotel_request(self, request, queryset):
        for hotel_request in queryset:
            if hotel_request.status != 'pending':
                messages.warning(
                    request,
                    _(f'لا يمكن الموافقة على الطلب {hotel_request.hotel_name} لأن حالته {hotel_request.get_status_display()}')
                )
                continue

            try:
                # التحقق من وجود المستخدم
                user = CustomUser.objects.filter(email=hotel_request.email).first()
                
                if user:
                    if not user.is_active:
                        user.is_active = True
                        user.save()
                        messages.success(request, _(f'تم إعادة تفعيل حساب الفندق: {hotel_request.hotel_name}'))
                    else:
                        messages.warning(request, _(f'حساب الفندق {hotel_request.hotel_name} نشط بالفعل'))
                else:
                    # إنشاء حساب جديد
                    user = CustomUser.objects.create(
                        username=hotel_request.email,
                        email=hotel_request.email,
                        first_name=hotel_request.owner_name,
                        phone=hotel_request.phone,
                        user_type='hotel_manager',
                        is_staff=True
                    )
                    user.set_password(hotel_request.password)
                    user.save()

                    # إضافة المستخدم إلى مجموعة مدراء الفنادق
                    hotel_group = Group.objects.get_or_create(name='Hotel Managers')[0]
                    user.groups.add(hotel_group)

                    messages.success(request, _(f'تم إنشاء حساب مدير الفندق بنجاح: {hotel_request.hotel_name}'))

                # تحديث حالة الطلب
                hotel_request.status = 'approved'
                hotel_request.save()

            except Exception as e:
                messages.error(
                    request,
                    _(f'حدث خطأ أثناء معالجة طلب الفندق {hotel_request.hotel_name}: {str(e)}')
                )

    approve_hotel_request.short_description = _("الموافقة على الطلبات المحددة")

    def reject_hotel_request(self, request, queryset):
        for hotel_request in queryset:
            if hotel_request.status != 'pending':
                messages.warning(
                    request,
                    _(f'لا يمكن رفض الطلب {hotel_request.hotel_name} لأن حالته {hotel_request.get_status_display()}')
                )
                continue

            try:
                hotel_request.status = 'rejected'
                hotel_request.save()
                messages.success(request, _(f'تم رفض طلب الفندق: {hotel_request.hotel_name}'))
            except Exception as e:
                messages.error(
                    request,
                    _(f'حدث خطأ أثناء رفض طلب الفندق {hotel_request.hotel_name}: {str(e)}')
                )

    reject_hotel_request.short_description = _("رفض الطلبات المحددة")

    def deactivate_hotel_request(self, request, queryset):
        for hotel_request in queryset:
            if hotel_request.status != 'approved':
                messages.warning(
                    request,
                    _(f'لا يمكن إلغاء تفعيل الطلب {hotel_request.hotel_name} لأن حالته {hotel_request.get_status_display()}')
                )
                continue

            try:
                user = CustomUser.objects.filter(email=hotel_request.email).first()
                
                if user:
                    user.is_active = False
                    user.save()
                    hotel_request.status = 'cancelled'
                    hotel_request.save()
                    messages.success(request, _(f'تم إلغاء تفعيل حساب الفندق: {hotel_request.hotel_name}'))
                else:
                    messages.warning(request, _(f'لم يتم العثور على حساب للفندق: {hotel_request.hotel_name}'))

            except Exception as e:
                messages.error(
                    request,
                    _(f'حدث خطأ أثناء إلغاء تفعيل حساب الفندق {hotel_request.hotel_name}: {str(e)}')
                )

    deactivate_hotel_request.short_description = _("إلغاء تفعيل الحسابات المحددة")

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