from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
from django.conf import settings

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
    created_by = models.OneToOneField(
        settings.AUTH_USER_MODEL,  
        related_name="%(class)s_created",
        verbose_name=_("المنشى"),
        on_delete=models.CASCADE
    )
    updated_by = models.OneToOneField(
        settings.AUTH_USER_MODEL, 
        related_name="%(class)s_updated",
        verbose_name=_("المعدل"),
        on_delete=models.CASCADE
    )

    class Meta:
        abstract = True





# -------------------- Hotel ----------------------------

class Hotel(BaseModel): 
    location = models.ForeignKey(
        "Location",
        verbose_name=_("موقع الفندق"), 
        on_delete=models.CASCADE
    )
    name = models.CharField(
        max_length=255, 
        blank=True, 
        verbose_name=_("اسم الفندق")
    )
    email = models.EmailField(
        max_length=255, 
        blank=True, 
        verbose_name=_("البريد الإلكتروني")
    )
    description = models.TextField(
        max_length=3000, 
        blank=True, 
        verbose_name=_("وصف الفندق")
    )
    rating = models.IntegerField(
        verbose_name=_("التقييم")
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

    class Meta:
        verbose_name = _("فندق")
        verbose_name_plural = _("فنادق")

    def __str__(self):
        return self.name if self.name else _("فندق بدون اسم")


# -------------------- Location ----------------------------
class Location(BaseModel):
    name = models.CharField(max_length=255,verbose_name=_("الموقع"))
    address = models.CharField(max_length=255, verbose_name=_("العنوان"))
    city = models.ForeignKey("City",
        verbose_name=_("موقع الفندق"), 
        on_delete=models.CASCADE)
    class Meta:
        verbose_name = _("الموقع")
        verbose_name_plural = _("المواقع")

    def __str__(self):
        return self.name if self.name else _("موقع بدون اسم")
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

    class Meta:
        verbose_name = _("رقم هاتف")
        verbose_name_plural = _("أرقام الهواتف")

    def __str__(self):
        return f"{self.country_code}-{self.phone_number}"

#----------------------  images  -------------------------------
    
class Image(BaseModel):    
    image_path = models.CharField(_("مسار الصوره"),max_length=255)
    image_url = models.CharField(_("مسار الصوره على الانترنت"), null=True,max_length=3000)


# -------------------- City ----------------------------

class City(BaseModel): 
    name = models.CharField(
        _("المدينه"), 
        max_length=255
    )
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
        return self.name if self.name else _("منطقه بدون اسم")


    