from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from django.db.models.signals import post_migrate, post_save
from django.dispatch import receiver
from django.apps import apps

@receiver(post_migrate)
def create_hotel_staff_groups(sender, **kwargs):
    """
    إنشاء مجموعات الصلاحيات لمدراء الفنادق وموظفيهم
    """
    try:
        # إنشاء مجموعة مدراء الفنادق
        hotel_managers_group, _ = Group.objects.get_or_create(name='Hotel Managers')
        
        # إنشاء مجموعة موظفي الفندق
        hotel_staff_group, _ = Group.objects.get_or_create(name='Hotel Staff')
        
        # قائمة بالتطبيقات والموديلات التي يحتاج مدير الفندق للوصول إليها
        manager_apps_and_models = {
            'users': ['customuser'],  # للتحكم في الموظفين
            'auth': ['user'],  # للتحكم في المستخدمين
            'rooms': ['room', 'roomtype', 'roomamenity'],  # للتحكم في الغرف
            'bookings': ['booking', 'bookingservice'],  # للتحكم في الحجوزات
            'services': ['service'],  # للتحكم في الخدمات
            'reviews': ['review'],  # لقراءة التقييمات
            'hotels': ['hotel', 'hotelamenity'],  # للتحكم في معلومات الفندق
        }

        # قائمة بالتطبيقات والموديلات التي يحتاج الموظف للوصول إليها
        staff_apps_and_models = {
            'bookings': ['booking', 'bookingservice'],  # للتعامل مع الحجوزات
            'rooms': ['room'],  # لعرض الغرف فقط
            'services': ['service'],  # لعرض وإضافة الخدمات
        }
        
        # إضافة صلاحيات مدير الفندق
        manager_permissions = []
        for app_label, models in manager_apps_and_models.items():
            for model_name in models:
                try:
                    content_type = ContentType.objects.get_for_model(
                        apps.get_model(app_label, model_name)
                    )
                    
                    if app_label == 'users' and model_name == 'customuser':
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=['add_customuser', 'change_customuser', 'view_customuser', 'delete_customuser']
                        )
                    elif app_label == 'auth' and model_name == 'user':
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=['add_user', 'change_user', 'view_user', 'delete_user']
                        )
                    elif app_label == 'reviews' and model_name == 'review':
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=['view_review']
                        )
                    else:
                        perms = Permission.objects.filter(content_type=content_type)
                    
                    manager_permissions.extend(perms)
                except (LookupError, ContentType.DoesNotExist):
                    continue
        
        # إضافة صلاحيات الموظف
        staff_permissions = []
        for app_label, models in staff_apps_and_models.items():
            for model_name in models:
                try:
                    content_type = ContentType.objects.get_for_model(
                        apps.get_model(app_label, model_name)
                    )
                    
                    if app_label == 'rooms' and model_name == 'room':
                        # للموظف فقط صلاحية العرض للغرف
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=['view_room']
                        )
                    elif app_label == 'bookings':
                        # للموظف صلاحية إضافة وتعديل وعرض الحجوزات
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=[f'add_{model_name}', f'change_{model_name}', f'view_{model_name}']
                        )
                    elif app_label == 'services':
                        # للموظف صلاحية إضافة وعرض الخدمات
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=['add_service', 'view_service']
                        )
                    
                    staff_permissions.extend(perms)
                except (LookupError, ContentType.DoesNotExist):
                    continue
        
        # تعيين الصلاحيات للمجموعات
        if manager_permissions:
            hotel_managers_group.permissions.set(manager_permissions)
        if staff_permissions:
            hotel_staff_group.permissions.set(staff_permissions)
    
    except Exception as e:
        print(f"Error creating hotel staff groups: {str(e)}")
        pass

@receiver(post_save, sender=apps.get_model('users', 'CustomUser'))
def assign_user_to_group(sender, instance, created, **kwargs):
    """
    تعيين المستخدم إلى المجموعة المناسبة عند إنشائه
    """
    try:
        if created:
            if instance.user_type == 'hotel_manager':
                group = Group.objects.get(name='Hotel Managers')
                instance.groups.add(group)
            elif instance.chield is not None:  # إذا كان موظفاً تحت مدير فندق
                group = Group.objects.get(name='Hotel Staff')
                instance.groups.add(group)
    except Group.DoesNotExist:
        pass
