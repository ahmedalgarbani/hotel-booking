from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from django.utils.text import slugify
from django.core.exceptions import ValidationError
from HotelManagement.models import BaseModel,Hotel
from rooms.models import RoomType
from ckeditor.fields import RichTextField


class HotelService(BaseModel):
    name = models.CharField(
        max_length=255,
        verbose_name=_("اسم الخدمة"),
        default="Default Name"
    )
    description = models.TextField(
        max_length=1000,
        blank=True,
        verbose_name=_("وصف الخدمة")
    )
    icon = models.ImageField(
        upload_to="service/hotel/icon",
        blank=True,
        null=True,
        verbose_name=_("رمز الخدمة")
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_("نشطة")
    )
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        related_name="hotel_services",
        verbose_name=_("الفندق")
    )

    class Meta:
        verbose_name = _("خدمة فندقية")
        verbose_name_plural = _("الخدمات الفندقية")

    def __str__(self):
        return self.name



class RoomTypeService(BaseModel):
    name = models.CharField(
        max_length=255,
        verbose_name=_("اسم الخدمة"),
        default="Default Name"
    )
    description = models.TextField(
        max_length=1000,
        blank=True,
        verbose_name=_("وصف الخدمة")
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_("نشطة")
    )
    icon = models.ImageField(
        upload_to="service/roomtype/icon",
        blank=True,
        null=True,
        verbose_name=_("رمز الخدمة")
    )
    additional_fee = models.FloatField(
        default=0.0,
        verbose_name=_("القيمة المضافة")
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        related_name="room_services",
        verbose_name=_("نوع الغرفة")
    )
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        related_name="room_services",
        verbose_name=_("الفندق")
    )

    class Meta:
        verbose_name = _("خدمة نوع الغرفة")
        verbose_name_plural = _("خدمات أنواع الغرف")

    def __str__(self):
        return self.name



# -------------------- Offer ----------------------------

class Offer(BaseModel):
    hotel = models.ForeignKey(
        Hotel, 
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='service_offers' 
    )
    offer_name = models.CharField(
        max_length=100,
        verbose_name=_("اسم العرض")
    )
    offer_description = models.TextField(
        verbose_name=_("وصف العرض")
    )
    offer_start_date = models.DateField(
        verbose_name=_("تاريخ بداية العرض")
    )
    offer_end_date = models.DateField(
        verbose_name=_("تاريخ نهاية العرض")
    )
    # created_by = models.ForeignKey(
    #     settings.AUTH_USER_MODEL,
    #     on_delete=models.SET_NULL,
    #     null=True,
    #     related_name='service_offers_created',  # Added specific related_name
    #     verbose_name=_("تم الإنشاء بواسطة")
    # )
    # updated_by = models.ForeignKey(
    #     settings.AUTH_USER_MODEL,
    #     on_delete=models.SET_NULL,
    #     null=True,
    #     related_name='service_offers_updated',  # Added specific related_name
    #     verbose_name=_("تم التحديث بواسطة")
    # )
    
    class Meta:
        verbose_name = _("عرض")
        verbose_name_plural = _("العروض")
        db_table = 'service_offers'  # Changed from review_offers to service_offers

    def __str__(self):
        return self.offer_name

    def clean(self):
        if self.offer_end_date < self.offer_start_date:
            raise ValidationError(_("تاريخ نهاية العرض يجب أن يكون بعد تاريخ البداية"))
        



# ------------------ Coupon --------------------------

class Coupon(BaseModel):
    DISCOUNT_TYPES = [
        ('percent', 'Percent'),
        ('amount', 'Amount'),
    ]
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        related_name="hotel_coupon",
        verbose_name=_("الفندق")
    )
    name = models.CharField(max_length=255)
    code = models.CharField(max_length=255, unique=True)
    description = RichTextField()
    quantity = models.IntegerField()
    min_purchase_amount = models.IntegerField(default=0)
    expired_date = models.DateField()
    discount_type = models.CharField(max_length=10, choices=DISCOUNT_TYPES)
    discount = models.FloatField()
    status = models.BooleanField(default=True)

    def __str__(self):
        return self.name
