from django.core.exceptions import PermissionDenied
from django.utils.translation import gettext_lazy as _
from functools import wraps
from .models.permissions import UserPermission

def check_hotel_permission(permission_name):
    """
    مُزخرف للتحقق من صلاحيات المستخدم على مستوى الفندق
    
    :param permission_name: اسم الصلاحية (مثل: can_view_hotel, can_edit_hotel)
    """
    def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            hotel_id = kwargs.get('hotel_id')
            if not hotel_id:
                raise ValueError(_('يجب تحديد معرف الفندق'))
                
            # التحقق من صلاحيات المستخدم
            user_permissions = UserPermission.objects.filter(
                user=request.user,
                hotel_id=hotel_id,
                is_active=True,
                permission_group__is_system_group=False
            )
            
            has_permission = any(
                getattr(perm.permission_group, permission_name, False)
                for perm in user_permissions
            )
            
            # إذا كان المستخدم مدير نظام، يمتلك جميع الصلاحيات
            if request.user.is_superuser or request.user.user_type == 'admin':
                has_permission = True
                
            # إذا كان المستخدم مدير الفندق، يمتلك جميع الصلاحيات على فندقه
            elif request.user.user_type == 'hotel_manager' and request.user.hotel.id == hotel_id:
                has_permission = True
                
            if not has_permission:
                raise PermissionDenied(_('ليس لديك الصلاحية للقيام بهذا الإجراء'))
                
            return view_func(request, *args, **kwargs)
        return _wrapped_view
    return decorator

def create_default_permission_groups(hotel):
    """
    إنشاء مجموعات الصلاحيات الافتراضية للفندق
    
    :param hotel: نموذج الفندق
    """
    from .models.permissions import PermissionGroup
    
    # مجموعة المشرفين
    admin_group = PermissionGroup.objects.create(
        name=_('مشرفو الفندق'),
        description=_('مجموعة المشرفين مع كامل الصلاحيات'),
        hotel=hotel,
        is_system_group=True,
        can_view_hotel=True,
        can_edit_hotel=True,
        can_view_rooms=True,
        can_add_rooms=True,
        can_edit_rooms=True,
        can_delete_rooms=True,
        can_view_bookings=True,
        can_manage_bookings=True,
        can_view_reviews=True,
        can_manage_reviews=True,
        can_view_offers=True,
        can_manage_offers=True
    )
    
    # مجموعة الموظفين
    staff_group = PermissionGroup.objects.create(
        name=_('موظفو الفندق'),
        description=_('مجموعة الموظفين مع صلاحيات محدودة'),
        hotel=hotel,
        is_system_group=True,
        can_view_hotel=True,
        can_view_rooms=True,
        can_view_bookings=True,
        can_manage_bookings=True,
        can_view_reviews=True,
        can_view_offers=True
    )
    
    return admin_group, staff_group

def assign_user_to_permission_group(user, permission_group, granted_by):
    """
    إضافة مستخدم إلى مجموعة صلاحيات
    
    :param user: المستخدم
    :param permission_group: مجموعة الصلاحيات
    :param granted_by: المستخدم الذي منح الصلاحيات
    """
    UserPermission.objects.create(
        user=user,
        permission_group=permission_group,
        hotel=permission_group.hotel,
        granted_by=granted_by
    )
