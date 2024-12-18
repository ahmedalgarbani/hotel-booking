from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from HotelManagement.models import BaseModel, Hotel

class PermissionGroup(BaseModel):
    name = models.CharField(
        max_length=255,
        verbose_name=_('الاسم')
    )
    STAFF_TYPE_CHOICES = [
        ('manager', 'مدير الفندق'),
        ('receptionist', 'موظف استقبال'),
        ('booking_agent', 'مسؤول حجوزات'),
        ('housekeeping', 'مشرف نظافة'),
        ('maintenance', 'مسؤول صيانة'),
        ('accountant', 'محاسب'),
    ]
    staff_type = models.CharField(
        max_length=20,
        choices=STAFF_TYPE_CHOICES,
        null=True,
        blank=True,
        verbose_name='نوع الموظف'
    )
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        null=True,
        blank=True,
        verbose_name=_('الفندق'),
        related_name='permission_groups'
    )
    description = models.TextField(
        blank=True,
        null=True,
        verbose_name=_('الوصف')
    )
    is_system_group = models.BooleanField(
        default=False,
        verbose_name=_('مجموعة نظام'),
        help_text=_('إذا كانت True، فهذه مجموعة نظام لا يمكن تعديلها')
    )
    
    # التحكم في عرض الجداول
    can_view_hotel_model = models.BooleanField(default=True, verbose_name=_('عرض جدول الفنادق'))
    can_view_image_model = models.BooleanField(default=True, verbose_name=_('عرض جدول الصور'))
    can_view_location_model = models.BooleanField(default=True, verbose_name=_('عرض جدول المواقع'))
    can_view_city_model = models.BooleanField(default=True, verbose_name=_('عرض جدول المدن'))
    can_view_room_model = models.BooleanField(default=True, verbose_name=_('عرض جدول الغرف'))
    can_view_booking_model = models.BooleanField(default=True, verbose_name=_('عرض جدول الحجوزات'))
    can_view_review_model = models.BooleanField(default=True, verbose_name=_('عرض جدول التقييمات'))
    can_view_service_model = models.BooleanField(default=True, verbose_name=_('عرض جدول الخدمات'))
    can_view_payment_model = models.BooleanField(default=True, verbose_name=_('عرض جدول المدفوعات'))
    can_view_offer_model = models.BooleanField(default=True, verbose_name=_('عرض جدول العروض'))
    
    # الصلاحيات العامة
    is_superuser = models.BooleanField(default=False, verbose_name='مدير النظام')
    can_view_admin = models.BooleanField(default=False, verbose_name='الوصول للوحة التحكم')
    
    # صلاحيات المستخدمين
    can_view_users = models.BooleanField(default=False, verbose_name='عرض المستخدمين')
    can_add_users = models.BooleanField(default=False, verbose_name='إضافة مستخدمين')
    can_edit_users = models.BooleanField(default=False, verbose_name='تعديل المستخدمين')
    can_delete_users = models.BooleanField(default=False, verbose_name='حذف المستخدمين')
    
    # صلاحيات مجموعات الصلاحيات
    can_view_permissions = models.BooleanField(default=False, verbose_name='عرض الصلاحيات')
    can_manage_permissions = models.BooleanField(default=False, verbose_name='إدارة الصلاحيات')
    
    # صلاحيات الفندق
    can_view_hotel = models.BooleanField(default=False, verbose_name='عرض الفندق')
    can_edit_hotel = models.BooleanField(default=False, verbose_name='تعديل الفندق')
    can_manage_hotel_settings = models.BooleanField(default=False, verbose_name='إدارة إعدادات الفندق')
    
    # صلاحيات الغرف
    can_view_rooms = models.BooleanField(default=False, verbose_name='عرض الغرف')
    can_add_rooms = models.BooleanField(default=False, verbose_name='إضافة غرف')
    can_edit_rooms = models.BooleanField(default=False, verbose_name='تعديل الغرف')
    can_delete_rooms = models.BooleanField(default=False, verbose_name='حذف الغرف')
    can_manage_room_prices = models.BooleanField(default=False, verbose_name='إدارة أسعار الغرف')
    can_manage_room_availability = models.BooleanField(default=False, verbose_name='إدارة توفر الغرف')
    
    # صلاحيات الحجوزات
    can_view_bookings = models.BooleanField(default=False, verbose_name='عرض الحجوزات')
    can_add_bookings = models.BooleanField(default=False, verbose_name='إضافة حجوزات')
    can_edit_bookings = models.BooleanField(default=False, verbose_name='تعديل الحجوزات')
    can_delete_bookings = models.BooleanField(default=False, verbose_name='حذف الحجوزات')
    can_confirm_bookings = models.BooleanField(default=False, verbose_name='تأكيد الحجوزات')
    can_cancel_bookings = models.BooleanField(default=False, verbose_name='إلغاء الحجوزات')
    can_modify_booking_prices = models.BooleanField(default=False, verbose_name='تعديل أسعار الحجوزات')
    
    # صلاحيات التقييمات
    can_view_reviews = models.BooleanField(default=False, verbose_name='عرض التقييمات')
    can_add_reviews = models.BooleanField(default=False, verbose_name='إضافة تقييمات')
    can_edit_reviews = models.BooleanField(default=False, verbose_name='تعديل التقييمات')
    can_delete_reviews = models.BooleanField(default=False, verbose_name='حذف التقييمات')
    can_respond_to_reviews = models.BooleanField(default=False, verbose_name='الرد على التقييمات')
    
    # صلاحيات العروض والخصومات
    can_view_offers = models.BooleanField(default=False, verbose_name='عرض العروض')
    can_add_offers = models.BooleanField(default=False, verbose_name='إضافة عروض')
    can_edit_offers = models.BooleanField(default=False, verbose_name='تعديل العروض')
    can_delete_offers = models.BooleanField(default=False, verbose_name='حذف العروض')
    can_manage_offers = models.BooleanField(default=False, verbose_name='إدارة العروض')
    can_create_discounts = models.BooleanField(default=False, verbose_name='إنشاء خصومات')
    can_modify_discounts = models.BooleanField(default=False, verbose_name='تعديل الخصومات')
    can_delete_discounts = models.BooleanField(default=False, verbose_name='حذف الخصومات')
    
    # صلاحيات الخدمات
    can_view_services = models.BooleanField(default=False, verbose_name='عرض الخدمات')
    can_add_services = models.BooleanField(default=False, verbose_name='إضافة خدمات')
    can_edit_services = models.BooleanField(default=False, verbose_name='تعديل الخدمات')
    can_delete_services = models.BooleanField(default=False, verbose_name='حذف الخدمات')
    can_manage_service_prices = models.BooleanField(default=False, verbose_name='إدارة أسعار الخدمات')
    
    # صلاحيات المدفوعات
    can_view_payments = models.BooleanField(default=False, verbose_name='عرض المدفوعات')
    can_process_payments = models.BooleanField(default=False, verbose_name='معالجة المدفوعات')
    can_refund_payments = models.BooleanField(default=False, verbose_name='استرداد المدفوعات')
    can_view_payment_reports = models.BooleanField(default=False, verbose_name='عرض تقارير المدفوعات')
    
    # صلاحيات التقارير والإحصائيات
    can_view_reports = models.BooleanField(default=False, verbose_name='عرض التقارير')
    can_export_reports = models.BooleanField(default=False, verbose_name='تصدير التقارير')
    can_view_statistics = models.BooleanField(default=False, verbose_name='عرض الإحصائيات')
    can_view_financial_reports = models.BooleanField(default=False, verbose_name='عرض التقارير المالية')
    
    # صلاحيات إدارة الموظفين
    can_view_staff = models.BooleanField(default=False, verbose_name='عرض الموظفين')
    can_add_staff = models.BooleanField(default=False, verbose_name='إضافة موظفين')
    can_edit_staff = models.BooleanField(default=False, verbose_name='تعديل بيانات الموظفين')
    can_delete_staff = models.BooleanField(default=False, verbose_name='حذف الموظفين')
    can_manage_staff_permissions = models.BooleanField(default=False, verbose_name='إدارة صلاحيات الموظفين')
    
    # صلاحيات إضافية لمدير الفندق
    is_hotel_manager = models.BooleanField(default=False, verbose_name='مدير الفندق')
    can_create_permission_groups = models.BooleanField(default=False, verbose_name='إنشاء مجموعات صلاحيات')
    can_assign_permissions = models.BooleanField(default=False, verbose_name='تعيين صلاحيات للموظفين')
    
    # صلاحيات المواقع والمدن
    can_view_locations = models.BooleanField(default=False, verbose_name='عرض المواقع')
    can_add_locations = models.BooleanField(default=False, verbose_name='إضافة مواقع')
    can_edit_locations = models.BooleanField(default=False, verbose_name='تعديل المواقع')
    can_delete_locations = models.BooleanField(default=False, verbose_name='حذف المواقع')
    can_manage_cities = models.BooleanField(default=False, verbose_name='إدارة المدن')
    
    created_at = models.DateTimeField(auto_now_add=True)
    
    def get_permissions_summary(self):
        permissions = []
        
        # الصلاحيات العامة
        if self.is_superuser: permissions.append('مدير النظام')
        if self.can_view_admin: permissions.append('الوصول للوحة التحكم')
        
        # صلاحيات عرض الجداول في لوحة التحكم
        if self.can_view_hotel_model: permissions.append('عرض جدول الفنادق')
        if self.can_view_image_model: permissions.append('عرض جدول الصور')
        if self.can_view_location_model: permissions.append('عرض جدول المواقع')
        if self.can_view_city_model: permissions.append('عرض جدول المدن')
        if self.can_view_room_model: permissions.append('عرض جدول الغرف')
        if self.can_view_booking_model: permissions.append('عرض جدول الحجوزات')
        if self.can_view_review_model: permissions.append('عرض جدول التقييمات')
        if self.can_view_service_model: permissions.append('عرض جدول الخدمات')
        if self.can_view_payment_model: permissions.append('عرض جدول المدفوعات')
        if self.can_view_offer_model: permissions.append('عرض جدول العروض')
        
        # صلاحيات المستخدمين
        if self.can_view_users: permissions.append('عرض المستخدمين')
        if self.can_add_users: permissions.append('إضافة مستخدمين')
        if self.can_edit_users: permissions.append('تعديل المستخدمين')
        if self.can_delete_users: permissions.append('حذف المستخدمين')
        
        # صلاحيات الفندق
        if self.can_view_hotel: permissions.append('عرض الفندق')
        if self.can_edit_hotel: permissions.append('تعديل الفندق')
        if self.can_manage_hotel_settings: permissions.append('إدارة إعدادات الفندق')
        
        # صلاحيات الغرف
        if self.can_view_rooms: permissions.append('عرض الغرف')
        if self.can_add_rooms: permissions.append('إضافة غرف')
        if self.can_edit_rooms: permissions.append('تعديل الغرف')
        if self.can_delete_rooms: permissions.append('حذف الغرف')
        if self.can_manage_room_prices: permissions.append('إدارة أسعار الغرف')
        if self.can_manage_room_availability: permissions.append('إدارة توفر الغرف')
        
        # صلاحيات الحجوزات
        if self.can_view_bookings: permissions.append('عرض الحجوزات')
        if self.can_add_bookings: permissions.append('إضافة حجوزات')
        if self.can_edit_bookings: permissions.append('تعديل الحجوزات')
        if self.can_delete_bookings: permissions.append('حذف الحجوزات')
        if self.can_confirm_bookings: permissions.append('تأكيد الحجوزات')
        if self.can_cancel_bookings: permissions.append('إلغاء الحجوزات')
        if self.can_modify_booking_prices: permissions.append('تعديل أسعار الحجوزات')
        
        # صلاحيات التقييمات
        if self.can_view_reviews: permissions.append('عرض التقييمات')
        if self.can_add_reviews: permissions.append('إضافة تقييمات')
        if self.can_edit_reviews: permissions.append('تعديل التقييمات')
        if self.can_delete_reviews: permissions.append('حذف التقييمات')
        if self.can_respond_to_reviews: permissions.append('الرد على التقييمات')
        
        # صلاحيات العروض والخصومات
        if self.can_view_offers: permissions.append('عرض العروض')
        if self.can_add_offers: permissions.append('إضافة عروض')
        if self.can_edit_offers: permissions.append('تعديل العروض')
        if self.can_delete_offers: permissions.append('حذف العروض')
        if self.can_manage_offers: permissions.append('إدارة العروض')
        if self.can_create_discounts: permissions.append('إنشاء خصومات')
        if self.can_modify_discounts: permissions.append('تعديل الخصومات')
        if self.can_delete_discounts: permissions.append('حذف الخصومات')
        
        # صلاحيات الخدمات
        if self.can_view_services: permissions.append('عرض الخدمات')
        if self.can_add_services: permissions.append('إضافة خدمات')
        if self.can_edit_services: permissions.append('تعديل الخدمات')
        if self.can_delete_services: permissions.append('حذف الخدمات')
        if self.can_manage_service_prices: permissions.append('إدارة أسعار الخدمات')
        
        # صلاحيات المدفوعات
        if self.can_view_payments: permissions.append('عرض المدفوعات')
        if self.can_process_payments: permissions.append('معالجة المدفوعات')
        if self.can_refund_payments: permissions.append('استرداد المدفوعات')
        if self.can_view_payment_reports: permissions.append('عرض تقارير المدفوعات')
        
        # صلاحيات التقارير والإحصائيات
        if self.can_view_reports: permissions.append('عرض التقارير')
        if self.can_export_reports: permissions.append('تصدير التقارير')
        if self.can_view_statistics: permissions.append('عرض الإحصائيات')
        if self.can_view_financial_reports: permissions.append('عرض التقارير المالية')
        
        # صلاحيات إدارة الموظفين
        if self.can_view_staff: permissions.append('عرض الموظفين')
        if self.can_add_staff: permissions.append('إضافة موظفين')
        if self.can_edit_staff: permissions.append('تعديل بيانات الموظفين')
        if self.can_delete_staff: permissions.append('حذف الموظفين')
        if self.can_manage_staff_permissions: permissions.append('إدارة صلاحيات الموظفين')
        
        # صلاحيات إضافية لمدير الفندق
        if self.is_hotel_manager: permissions.append('مدير الفندق')
        if self.can_create_permission_groups: permissions.append('إنشاء مجموعات صلاحيات')
        if self.can_assign_permissions: permissions.append('تعيين صلاحيات للموظفين')
        
        # صلاحيات المواقع والمدن
        if self.can_view_locations: permissions.append('عرض المواقع')
        if self.can_add_locations: permissions.append('إضافة مواقع')
        if self.can_edit_locations: permissions.append('تعديل المواقع')
        if self.can_delete_locations: permissions.append('حذف المواقع')
        if self.can_manage_cities: permissions.append('إدارة المدن')
        
        return ', '.join(permissions[:3]) + ('...' if len(permissions) > 3 else '')

    def can_manage_hotel(self, hotel):
        """التحقق من أن المستخدم يمكنه إدارة الفندق المحدد"""
        return self.is_hotel_manager and self.hotel == hotel
    
    def can_manage_staff_for_hotel(self, hotel):
        """التحقق من أن المستخدم يمكنه إدارة موظفي الفندق المحدد"""
        return (self.is_hotel_manager or self.can_manage_staff_permissions) and self.hotel == hotel
    
    def get_assignable_permissions(self):
        """الحصول على الصلاحيات التي يمكن للمستخدم تعيينها لغيره"""
        if not (self.is_hotel_manager or self.can_assign_permissions):
            return []
        
        assignable_permissions = []
        for field in self._meta.fields:
            if isinstance(field, models.BooleanField) and field.name.startswith('can_'):
                # لا يمكن تعيين صلاحيات المدير أو الصلاحيات الخاصة
                if field.name not in ['is_hotel_manager', 'is_superuser', 'can_create_permission_groups']:
                    assignable_permissions.append({
                        'name': field.name,
                        'verbose_name': field.verbose_name,
                        'value': getattr(self, field.name)
                    })
        return assignable_permissions

    def save(self, *args, **kwargs):
        if self.staff_type:
            # تعيين الصلاحيات الافتراضية حسب نوع الموظف
            self.set_default_permissions_by_type()
        super().save(*args, **kwargs)

    def set_default_permissions_by_type(self):
        """تعيين الصلاحيات الافتراضية حسب نوع الموظف"""
        # إعادة تعيين جميع الصلاحيات إلى False
        for field in self._meta.fields:
            if isinstance(field, models.BooleanField) and field.name.startswith('can_'):
                setattr(self, field.name, False)

        # تعيين الصلاحيات حسب نوع الموظف
        if self.staff_type == 'manager':
            self.is_hotel_manager = True
            self.can_view_admin = True
            self.can_manage_staff_permissions = True
            self.can_assign_permissions = True
            # صلاحيات إدارة الفندق
            self._set_all_hotel_permissions(True)

        elif self.staff_type == 'receptionist':
            self.can_view_admin = True
            # صلاحيات الاستقبال
            self.can_view_rooms = True
            self.can_view_bookings = True
            self.can_add_bookings = True
            self.can_edit_bookings = True
            self.can_view_guests = True
            self.can_add_guests = True

        elif self.staff_type == 'booking_agent':
            self.can_view_admin = True
            # صلاحيات الحجوزات
            self.can_view_rooms = True
            self.can_view_bookings = True
            self.can_add_bookings = True
            self.can_edit_bookings = True
            self.can_delete_bookings = True
            self.can_manage_room_prices = True

        elif self.staff_type == 'housekeeping':
            self.can_view_admin = True
            # صلاحيات النظافة
            self.can_view_rooms = True
            self.can_view_maintenance = True
            self.can_add_maintenance = True

        elif self.staff_type == 'maintenance':
            self.can_view_admin = True
            # صلاحيات الصيانة
            self.can_view_maintenance = True
            self.can_add_maintenance = True
            self.can_edit_maintenance = True
            self.can_delete_maintenance = True

        elif self.staff_type == 'accountant':
            self.can_view_admin = True
            # صلاحيات المحاسبة
            self.can_view_payments = True
            self.can_add_payments = True
            self.can_edit_payments = True
            self.can_view_reports = True
            self.can_generate_reports = True

    def _set_all_hotel_permissions(self, value):
        """تعيين جميع صلاحيات إدارة الفندق"""
        hotel_permissions = [
            'can_view_hotel', 'can_edit_hotel',
            'can_view_rooms', 'can_add_rooms', 'can_edit_rooms', 'can_delete_rooms',
            'can_view_bookings', 'can_add_bookings', 'can_edit_bookings', 'can_delete_bookings',
            'can_view_guests', 'can_add_guests', 'can_edit_guests', 'can_delete_guests',
            'can_view_payments', 'can_add_payments', 'can_edit_payments', 'can_delete_payments',
            'can_view_reports', 'can_generate_reports',
            'can_view_maintenance', 'can_add_maintenance', 'can_edit_maintenance', 'can_delete_maintenance',
            'can_manage_room_prices', 'can_manage_services'
        ]
        for perm in hotel_permissions:
            setattr(self, perm, value)

    class Meta:
        verbose_name = _('مجموعة صلاحيات')
        verbose_name_plural = _('مجموعات الصلاحيات')
        unique_together = ('name', 'hotel')

    def __str__(self):
        return f"{self.name} - {self.hotel.name if self.hotel else 'عام'}"

class UserPermission(BaseModel):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='custom_user_permissions',
        verbose_name=_('المستخدم')
    )
    permission_group = models.ForeignKey(
        PermissionGroup,
        on_delete=models.CASCADE,
        related_name='user_permissions',
        verbose_name=_('مجموعة الصلاحيات')
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_('نشط')
    )

    class Meta:
        verbose_name = _('صلاحية مستخدم')
        verbose_name_plural = _('صلاحيات المستخدمين')
        unique_together = ('user', 'permission_group')

    def __str__(self):
        return f"{self.user.username} - {self.permission_group.name}"
