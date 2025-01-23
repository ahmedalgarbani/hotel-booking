# models.py

from django.db import models
from django.utils.text import slugify
from django.conf import settings
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import User
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
        settings.AUTH_USER_MODEL,
        related_name="%(class)s_created",
        verbose_name=_("المنشى"),
        on_delete=models.CASCADE,
        blank=True,
        null=True,
    )
    updated_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name="%(class)s_updated",
        verbose_name=_("المعدل"),
        on_delete=models.CASCADE,
        blank=True,
        null=True,
    )
    slug = models.SlugField(
        unique=True,
        max_length=255,
        verbose_name=_("Slug"),
        blank=True
    )

    class Meta:
        abstract = True

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = self.generate_unique_slug()
        super(BaseModel, self).save(*args, **kwargs)

    def generate_unique_slug(self):
        base_slug = slugify(self.name) if hasattr(self, 'name') and self.name else slugify(str(self.id) if self.id else str(self))
        slug = base_slug
        num = 1

        model_class = self.__class__
        while model_class.objects.filter(slug=slug).exists():
            slug = f'{base_slug}-{num}'
            num += 1

        return slug

    def get_absolute_url(self):
        return reverse(f"{self.__class__.__name__.lower()}_detail", kwargs={"slug": self.slug})
# -------------------- Location ----------------------------
class Location(BaseModel):
    address = models.CharField(max_length=255, verbose_name=_("العنوان"))
    city = models.ForeignKey(
        "HotelManagement.City",
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
       settings.AUTH_USER_MODEL,
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
    image_path = models.ImageField(upload_to='hotels/images/', blank=True, null=True)
    image_url = models.CharField(_("مسار الصوره على الانترنت"), null=True, max_length=3000)
    hotel = models.ForeignKey(Hotel,verbose_name=_("فندق"),on_delete=models.CASCADE,related_name='image')

    class Meta:
        verbose_name = _("صورة")
        verbose_name_plural = _("صور")
    def __str__(self):
        return f"{self.image_path}"
# -------------------- City ----------------------------
class City(BaseModel):
    state = models.CharField(
        _("المحافظة"),
        max_length=255
    )
    country = models.CharField(
        _("الدول"),
        max_length=255
    )
    class Meta:
        verbose_name = _("منطقه")
        verbose_name_plural = _("المناطق")
    def __str__(self):
        return f"{self.state}"
class HotelRequest(models.Model):
    # معلومات المستخدم
    name = models.CharField(max_length=255, verbose_name="اسمك")
    email = models.EmailField(verbose_name="بريدك الإلكتروني")
    role = models.CharField(max_length=50, verbose_name="دورك في العمل")
    # معلومات الفندق
    official_name = models.CharField(max_length=255, verbose_name="الاسم التجاري الرسمي")
    country = models.CharField(max_length=100, verbose_name="البلد")
    city = models.CharField(max_length=100, verbose_name="المدينة")
    street_address = models.CharField(max_length=255, verbose_name="عنوان الشارع")
    additional_address_info = models.CharField(max_length=255, verbose_name="معلومات إضافية عن العنوان")
    longitude = models.FloatField(verbose_name="خط الطول", blank=True, null=True)
    latitude = models.FloatField(verbose_name="خط العرض", blank=True, null=True)
    # بيانات الاتصال
    phone = models.CharField(max_length=20, verbose_name="الهاتف",blank=True, null=True)
    fax = models.CharField(max_length=20, verbose_name="الفاكس",blank=True, null=True)
    website = models.URLField(verbose_name="عنوان موقع الويب", blank=True, null=True)
    facebook = models.URLField(verbose_name="صفحة Facebook", blank=True, null=True)
    instagram = models.URLField(verbose_name="صفحة Instagram", blank=True, null=True)
    twitter = models.URLField(verbose_name="صفحة Twitter", blank=True, null=True)
    linkedin = models.URLField(verbose_name="صفحة Linkedin", blank=True, null=True)
    # معلومات الفندق
    total_rooms = models.IntegerField(verbose_name="إجمالي عدد الغرف والأجنحة", blank=True, null=True)
    price_range_min = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="أقل سعر", blank=True, null=True)
    price_range_max = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="أعلى سعر", blank=True, null=True)
    currency = models.CharField(max_length=10, verbose_name="العملة", blank=True, null=True)
    description = models.TextField(verbose_name="وصف الفندق", blank=True, null=True)
    additional_description = models.TextField(verbose_name="وصف إضافي", blank=True, null=True)
    # وسائل الراحة
    airport_transportation = models.BooleanField(default=False, verbose_name="مواصلات المطار")
    bar_lounge = models.BooleanField(default=False, verbose_name="بار / ردهة")
    beach = models.BooleanField(default=False, verbose_name="شاطئ بحر")
    swimming_pool = models.BooleanField(default=False, verbose_name="حمام السباحة")
    wifi = models.BooleanField(default=False, verbose_name="واي فاي")
    air_conditioning = models.BooleanField(default=False, verbose_name="تكييف")
    elevator = models.BooleanField(default=False, verbose_name="مصعد في المبنى")
    wheelchair_access = models.BooleanField(default=False, verbose_name="مسموح الكرسي المتحركة")
    fitness_facility = models.BooleanField(default=False, verbose_name="مرافق اللياقة البدنية")
    breakfast = models.BooleanField(default=False, verbose_name="وجبة افطار")
    pets_allowed = models.BooleanField(default=False, verbose_name="مسموح بدخول الحيوانات الأليفة")
    restaurant = models.BooleanField(default=False, verbose_name="مطعم")
    free_parking = models.BooleanField(default=False, verbose_name="موقف سيارات مجاني")
    # الصور
    image = models.ImageField(upload_to='hotel_requests/', verbose_name="صورة الفندق",blank=True, null=True)
    # حالة الطلب
    is_approved = models.BooleanField(default=False, verbose_name="تم التفعيل")
    def __str__(self):
        return self.official_name