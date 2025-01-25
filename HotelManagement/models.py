# models.py

from django.db import models
from django.utils.text import slugify
from django.conf import settings
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
from django.contrib.auth import get_user_model
from django.utils import timezone
from django.core.mail import send_mail
from django.template.loader import render_to_string
from django.contrib.auth.models import Group
from django.utils.crypto import get_random_string
from .notifications import Notification
from users.models import CustomUser
import json


class BaseModel(models.Model):
    created_at = models.DateTimeField(
        auto_now_add=True,
        verbose_name=_("تاريخ الإنشاء")
    )
    updated_at = models.DateTimeField(
        auto_now=True,
        verbose_name=_("تاريخ التعديل")
    )
    deleted_at = models.DateTimeField(
        null=True,
        blank=True,
        verbose_name=_("تاريخ الحذف")
    )
    created_by = models.ForeignKey(
        get_user_model(),
        related_name="%(class)s_created",
        verbose_name=_("المنشى"),
        on_delete=models.CASCADE,
        blank=True,
        null=True,
    )
    updated_by = models.ForeignKey(
        get_user_model(),
        related_name="%(class)s_updated",
        verbose_name=_("المعدل"),
        on_delete=models.CASCADE,
        blank=True,
        null=True,
    )
    

    class Meta:
        abstract = True



# -------------------- City ----------------------------
class City(BaseModel):
    state = models.CharField(
        _("المحافظة"),
        max_length=255
    )
    slug = models.SlugField(
        unique=True,
        max_length=255,
        verbose_name=_("Slug"),
        blank=True
    )
    country = models.CharField(
        _("الدول"),
        max_length=255
    )

    class Meta:
        verbose_name = _("منطقه")
        verbose_name_plural = _("المناطق")

    def __str__(self):
        return f"{self.state}, {self.country}"

# -------------------- Location ----------------------------
class Location(BaseModel):
    address = models.CharField(max_length=255, verbose_name=_("العنوان"))
    city = models.ForeignKey(
        City,
        verbose_name=_("المدينه "),
        on_delete=models.CASCADE
    )

    class Meta:
        verbose_name = _("الموقع")
        verbose_name_plural = _("المواقع")

    def __str__(self):
        return f"{self.address}"

# -------------------- Hotel ----------------------------
class Hotel(BaseModel):
    location = models.ForeignKey(
        Location,
        verbose_name=_("موقع الفندق"),
        on_delete=models.CASCADE
    )
    name = models.CharField(
        max_length=255,
        blank=True,
        verbose_name=_("اسم الفندق")
    )
    slug = models.SlugField(
        unique=True,
        max_length=255,
        verbose_name=_("Slug"),
        blank=True
    )
    profile_picture = models.ImageField(upload_to='hotels/images/', blank=True, null=True)
    description = models.TextField(
        max_length=3000,
        blank=True,
        verbose_name=_("وصف الفندق")
    )
    business_license_number = models.CharField(
        max_length=50,
        verbose_name=_('رقم الرخصة التجارية'),
        null=True,
        blank=True,
        help_text=_('رقم الرخصة التجارية للفندق')
    )
    document_path = models.FileField(
        upload_to='hotel_documents/%Y/%m/%d/',
        verbose_name=_('مستندات الفندق'),
        help_text=_('المستندات الرسمية للفندق (رخصة العمل، السجل التجاري، إلخ)'),
        null=True,
        blank=True
    )
    is_verified = models.BooleanField(
        default=False,
        verbose_name=_("تم التحقق")
    )
    verification_date = models.DateTimeField(
        null=True,
        blank=True,
        verbose_name=_("تاريخ التحقق")
    )
    manager = models.OneToOneField(
        get_user_model(),
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        limit_choices_to={'user_type': 'hotel_manager'},
        verbose_name=_("مدير الفندق")
    )

    class Meta:
        verbose_name = _("فندق")
        verbose_name_plural = _("فنادق")

    def __str__(self):
        return f"{self.name}"

    def save(self, *args, **kwargs):
        if not self.slug and self.name:
            base_slug = slugify(self.name)
            slug = base_slug
            num = 1

            while Hotel.objects.filter(slug=slug).exists():
                slug = f"{base_slug}-{num}"
                num += 1

            self.slug = slug
        super(Hotel, self).save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('home:hotel_detail', args=[self.slug])

# -------------------- Phone ----------------------------
class Phone(BaseModel):
    phone_number = models.CharField(
        max_length=10,
        verbose_name=_("رقم الهاتف")
    )
    country_code = models.CharField(
        max_length=5,
        verbose_name=_("رمز الدوله")
    )
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='phones'
    )

    class Meta:
        verbose_name = _("رقم هاتف")
        verbose_name_plural = _("أرقام الهواتف")

    def __str__(self):
        return f"{self.phone_number}"

# ---------------------- Image -------------------------------
class Image(BaseModel):
    image_path = models.ImageField(upload_to='hotels/images/', blank=True, null=True, verbose_name=_("مسار الصورة"))
    image_url = models.CharField(_("مسار الصورة على الانترنت"), null=True, max_length=3000, blank=True)
    hotel = models.ForeignKey(Hotel, verbose_name=_("الفندق"), on_delete=models.CASCADE, related_name='images')

    class Meta:
        verbose_name = _("صورة")
        verbose_name_plural = _("صور")

    def __str__(self):
        return f"{self.image_path if self.image_path else self.image_url}"

# -------------------- HotelRequest ----------------------------
class HotelRequest(models.Model):
    # معلومات المستخدم
    name = models.CharField(max_length=100, verbose_name=_("الاسم"))
    email = models.EmailField(verbose_name=_("البريد الإلكتروني"))
    role = models.CharField(max_length=100, verbose_name=_("دور العمل"))
    
    # معلومات الفندق
    hotel_name = models.CharField(max_length=100, verbose_name=_("اسم الفندق"))
    description = models.TextField(verbose_name=_("وصف الفندق"))
    profile_picture = models.ImageField(upload_to='hotel_requests/profile_pictures/', verbose_name=_("الصورة الرئيسية"))
    business_license_number = models.CharField(
        max_length=50,
        verbose_name=_('رقم الرخصة التجارية'),
        null=True,
        blank=True,
        help_text=_('رقم الرخصة التجارية للفندق')
    )
    document_path = models.FileField(
        upload_to='hotel_requests/documents/%Y/%m/%d/',
        verbose_name=_('مستندات الفندق'),
        help_text=_('المستندات الرسمية للفندق (رخصة العمل، السجل التجاري، إلخ)'),
        null=True,
        blank=True
    )
    additional_images = models.JSONField(default=list, blank=True, verbose_name=_("صور إضافية"))
    
    # معلومات المدينه
    country = models.CharField(max_length=100, verbose_name=_("الدولة"))
    state = models.CharField(max_length=100, verbose_name=_("المحافظة"))

    # معلومات الموقع
    city_name = models.CharField(max_length=100, verbose_name=_("المدينة"))
    address = models.CharField(max_length=255, verbose_name=_("العنوان"))
    
    # معلومات الاتصال
    country_code = models.CharField(max_length=5, verbose_name=_("رمز الدولة"))
    phone_number = models.CharField(max_length=20, verbose_name=_("رقم الهاتف"))
    
    # حالة الطلب
    is_approved = models.BooleanField(default=False, verbose_name=_("تمت الموافقة"))
    approved_by = models.ForeignKey(
        get_user_model(),
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='approved_hotel_requests',
        verbose_name=_("تمت الموافقة بواسطة")
    )
    approved_at = models.DateTimeField(null=True, blank=True, verbose_name=_("تاريخ الموافقة"))
    
    # معلومات التتبع
    created_at = models.DateTimeField(auto_now_add=True, verbose_name=_("تاريخ الإنشاء"))
    updated_at = models.DateTimeField(auto_now=True, verbose_name=_("تاريخ التحديث"))
    created_by = models.ForeignKey(
        get_user_model(),
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='created_hotel_requests',
        verbose_name=_("تم الإنشاء بواسطة")
    )
    updated_by = models.ForeignKey(
        get_user_model(),
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='updated_hotel_requests',
        verbose_name=_("تم التحديث بواسطة")
    )
    
    def __str__(self):
        return f"{self.hotel_name} - {self.name}"
    
    @property
    def status(self):
        """حالة الطلب"""
        if self.is_approved:
            return "تمت الموافقة"
        return "في انتظار الموافقة"
    
    class Meta:
        verbose_name = _("طلب إضافة فندق")
        verbose_name_plural = _("طلبات إضافة الفنادق")
        ordering = ['-created_at']
    
    def approve(self, user=None):
        """
        الموافقة على طلب إضافة الفندق
        """
        
        User = get_user_model()
        
        # إنشاء مستخدم جديد كمدير فندق
        username = self.email  # استخدام البريد الإلكتروني كاسم مستخدم
        # التحقق من عدم وجود مستخدم بنفس البريد الإلكتروني
        if not CustomUser.objects.filter(email=self.email).exists():
            # إنشاء مستخدم جديد
            hotel_manager = CustomUser.objects.create_user(
                username=username,
                email=self.email,
                first_name=self.name,
                user_type="hotel_manager",
                is_staff=True,
            )
            
            # تعيين كلمة مرور عشوائية
            password = get_random_string(length=12)
            hotel_manager.set_password(password)
            
            # إضافة المستخدم إلى مجموعة مدراء الفنادق وإضافة الصلاحيات
            hotel_manager_group, created = Group.objects.get_or_create(name='hotel_manager')
            
            if created:
                # إضافة الصلاحيات الأساسية لمدير الفندق
                from django.contrib.auth.models import Permission
                from django.contrib.contenttypes.models import ContentType
                
                # إنشاء قائمة بالنماذج والصلاحيات المطلوبة
                models_permissions = {
                    Hotel: ['add', 'change', 'view', 'delete'],
                    Phone: ['add', 'change', 'view', 'delete'],
                    Image: ['add', 'change', 'view', 'delete'],
                    Location: ['add', 'change', 'view', 'delete'],
                    City: ['view'],
                }
                
                # إضافة الصلاحيات لكل نموذج
                for model, actions in models_permissions.items():
                    content_type = ContentType.objects.get_for_model(model)
                    for action in actions:
                        codename = f"{action}_{model._meta.model_name}"
                        try:
                            permission = Permission.objects.get(
                                content_type=content_type,
                                codename=codename
                            )
                            hotel_manager_group.permissions.add(permission)
                        except Permission.DoesNotExist:
                            continue
            
            hotel_manager.groups.add(hotel_manager_group)
            hotel_manager.save()
            
            # إرسال بريد إلكتروني للمستخدم مع معلومات تسجيل الدخول
            print(f"محاولة إرسال بريد إلكتروني إلى {hotel_manager.email}")
            email_sent = Notification.send_hotel_manager_credentials(hotel_manager, self.hotel_name, password)
            if not email_sent:
                print(f"فشل في إرسال البريد الإلكتروني إلى {hotel_manager.email}")
        else:
            hotel_manager = User.objects.get(email=self.email)
        
        # إنشاء سجل المدينة إذا لم تكن موجودة
        city, created = City.objects.get_or_create(
            state=self.state,
            country=self.country
        )
        
        # إنشاء الموقع
        location = Location.objects.create(
            address=self.address,
            city=city,
            created_by=user
        )
        
        # إنشاء الفندق
        hotel = Hotel.objects.create(
            name=self.hotel_name,
            description=self.description,
            location=location,
            profile_picture=self.profile_picture,
            business_license_number=self.business_license_number,
            document_path=self.document_path,
            manager=hotel_manager,
            created_by=user,
            is_verified=True,
            verification_date=timezone.now(),

        )
        
        # إضافة رقم الهاتف
        Phone.objects.create(
            hotel=hotel,
            country_code=self.country_code,
            phone_number=self.phone_number,
            created_by=user
        )
        
        # إضافة الصور الإضافية
        if isinstance(self.additional_images, str):
            try:
                images_list = json.loads(self.additional_images)
                if isinstance(images_list, list):
                    for image_data in images_list:
                        if isinstance(image_data, dict) and 'image_path' in image_data:
                            Image.objects.create(
                                hotel=hotel,
                                image_path=image_data['image_path'],
                                created_by=user
                            )
            except json.JSONDecodeError:
                pass
        
        # تحديث حالة الطلب
        self.is_approved = True
        self.approved_by = user
        self.approved_at = timezone.now()
        self.save()
        
        return hotel
