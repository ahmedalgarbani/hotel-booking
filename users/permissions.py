from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from django.db.models.signals import post_migrate, post_save
from django.dispatch import receiver
from django.apps import apps

@receiver(post_migrate)
def create_hotel_staff_groups(sender, **kwargs):
    """
    إنشاء مجموعات الصلاحيات لمدراء الفنادق
    """
    try:
        # إنشاء مجموعة مدراء الفنادق
        hotel_managers_group, _ = Group.objects.get_or_create(name='Hotel Managers')
        
        # قائمة بالتطبيقات والموديلات التي يحتاج مدير الفندق للوصول إليها
        manager_apps_and_models = {
            'users': ['customuser'],  # للتحكم في الموظفين
            'auth': ['user', 'group'],  # للتحكم في المستخدمين والمجموعات
            'rooms': [
                'room',
                'roomtype',
                'roomamenity',
                'category',
                'roomimage',
                'roomprice',
                'availability',
            ],  # للتحكم الكامل في الغرف
            'services': ['roomtypeservice', 'hotelservice'],  # للتحكم في خدمات الغرف
            'bookings': [
                'booking',
                'bookingdetail',
                'bookingservice',
                'payment',
                'paymentmethod',
                'invoice'
            ],  # للتحكم الكامل في الحجوزات والمدفوعات
       

            'customers': ['customer'],  # للتحكم في العملاء
            'bookings': ['booking', 'bookingdetail', 'extensionmovement'],  # للتحكم في الحجوزات
            'reviews': ['RoomReview','HotelReview'],  # للتحكم في التقييمات
            'HotelManagement': [
                'hotel',
                'hotelamenity',
                'hotelpolicy',
                'image',
                'phone',
                'city',
                'location'
            ],  # للتحكم في معلومات الفندق
            'notifications': ['notification'],  # للتحكم في الإشعارات
            'blog': ['post', 'comment', 'category', 'tag'],  # للتحكم في المدونة
            

            

            'payments': ['currency', 'paymentoption', 'hotelpaymentmethod'],  # للتحكم في طرق الدفع


        }
        
        # إضافة صلاحيات مدير الفندق
        manager_permissions = []
        for app_label, models in manager_apps_and_models.items():
            for model_name in models:
                try:
                    content_type = ContentType.objects.get_for_model(
                        apps.get_model(app_label, model_name)
                    )
                    
                    # تحديد الصلاحيات حسب النموذج
                    if app_label == 'reviews' and model_name in ['RoomReview', 'HotelReview']:
                        # للتقييمات: عرض وحذف فقط
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=[
                                f'view_{model_name}',
                                f'delete_{model_name}'
                            ]
                        )
                    elif app_label == 'HotelManagement' and model_name in ['city', 'location', 'hotel']:
                        # للمدن والمواقع والفندق: عرض فقط
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=['view_' + model_name]
                        )
                    elif app_label == 'HotelManagement':
                        # لباقي نماذج HotelManagement: صلاحيات كاملة
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=[
                                f'add_{model_name}',
                                f'change_{model_name}',
                                f'view_{model_name}',
                                f'delete_{model_name}'
                            ]
                        )
                    else:
                        # لباقي النماذج: صلاحيات كاملة
                        perms = Permission.objects.filter(
                            content_type=content_type,
                            codename__in=[
                                f'add_{model_name}',
                                f'change_{model_name}',
                                f'view_{model_name}',
                                f'delete_{model_name}'
                            ]
                        )
                    
                    manager_permissions.extend(perms)
                except (LookupError, ContentType.DoesNotExist):
                    continue
        
        # تعيين الصلاحيات للمجموعة
        if manager_permissions:
            hotel_managers_group.permissions.set(manager_permissions)
    
    except Exception as e:
        print(f"Error creating hotel staff groups: {str(e)}")
        pass

@receiver(post_migrate)
def create_custom_permissions(sender, **kwargs):
    """إنشاء الصلاحيات المخصصة"""
    try:
        content_type = ContentType.objects.get_for_model(apps.get_model('HotelManagement', 'HotelRequest'))
        
        # إنشاء الصلاحيات المخصصة
        Permission.objects.get_or_create(
            codename='can_approve_request',
            name='Can approve hotel request',
            content_type=content_type,
        )
        
        Permission.objects.get_or_create(
            codename='can_reject_request',
            name='Can reject hotel request',
            content_type=content_type,
        )
        
        print("تم إنشاء الصلاحيات المخصصة بنجاح")
    except Exception as e:
        print(f"خطأ في إنشاء الصلاحيات المخصصة: {str(e)}")

@receiver(post_save, sender=apps.get_model('users', 'CustomUser'))
def assign_user_to_group(sender, instance, created, **kwargs):
    """
    تعيين المستخدم إلى المجموعة المناسبة عند إنشائه
    """
    try:
        if created and instance.user_type == 'hotel_manager':
            group = Group.objects.get(name='Hotel Managers')
            instance.groups.add(group)
    except Group.DoesNotExist:
        pass

# @receiver(post_save, sender=apps.get_model('users', 'CustomUser'))
# def assign_permissions(sender, instance, created, **kwargs):
#     """تعيين الصلاحيات للمستخدم"""
#     try:
#         if created:
#             content_type = ContentType.objects.get_for_model(apps.get_model('HotelManagement', 'HotelRequest'))
            
#             if instance.user_type == 'admin':
#                 approve_perm = Permission.objects.get(
#                     codename='can_approve_request',
#                     content_type=content_type
#                 )
#                 reject_perm = Permission.objects.get(
#                     codename='can_reject_request',
#                     content_type=content_type
#                 )
#                 instance.user_permissions.add(approve_perm, reject_perm)
                
#             elif instance.user_type == 'hotel_manager':
#                 approve_perm = Permission.objects.get(
#                     codename='can_approve_request',
#                     content_type=content_type
#                 )
#                 instance.user_permissions.add(approve_perm)
#     except Exception as e:
#         print(f"خطأ في تعيين الصلاحيات: {str(e)}")
