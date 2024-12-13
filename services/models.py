from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from django.utils.text import slugify
from django.core.exceptions import ValidationError
from HotelManagement.models import BaseModel,Hotel

class Service(BaseModel):
    name = models.CharField(
        max_length=255,
        verbose_name=_("اسم الخدمة"),default="Default Name"
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
    additional_fee = models.FloatField(
        null=True,
        blank=True,
        verbose_name=_("القيمة المضافه")
        )
    hotel = models.ForeignKey(
        Hotel,
        null=True,
        blank=True,
        on_delete=models.CASCADE,
        related_name="services",
        verbose_name=_("الفندق")
    )
    room = models.ForeignKey(
        "rooms.RoomType",  
        null=True,
        blank=True,
        on_delete=models.CASCADE,
        related_name="services",
        verbose_name=_("الغرفة")
    )

    class Meta:
        verbose_name = _("خدمة")
        verbose_name_plural = _("الخدمات")

    def __str__(self):
        return self.name

    def clean(self):
        if not self.hotel and not self.room:
            raise ValidationError(_("The service must be associated with at least a hotel or a room."))

    def save(self, *args, **kwargs):
        self.clean()  
        super(Service, self).save(*args, **kwargs)



# -------------------- Offer ----------------------------

class Offer(BaseModel):
    hotel_id = models.ForeignKey(
        Hotel, 
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='service_offers'  # Changed from review_offers to service_offers
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
    created_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        related_name='service_offers_created',  # Added specific related_name
        verbose_name=_("تم الإنشاء بواسطة")
    )
    updated_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        related_name='service_offers_updated',  # Added specific related_name
        verbose_name=_("تم التحديث بواسطة")
    )
    
    class Meta:
        verbose_name = _("عرض")
        verbose_name_plural = _("العروض")
        db_table = 'service_offers'  # Changed from review_offers to service_offers

    def __str__(self):
        return self.offer_name

    def clean(self):
        if self.offer_end_date < self.offer_start_date:
            raise ValidationError(_("تاريخ نهاية العرض يجب أن يكون بعد تاريخ البداية"))