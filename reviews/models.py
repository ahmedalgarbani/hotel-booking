from django.db import models
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import BaseModel,Hotel
from django.conf import settings
from django.core.exceptions import ValidationError
from django.contrib.auth import get_user_model

class Review(BaseModel):
    hotel_id = models.ForeignKey(
        Hotel, 
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
    )
    user_id = models.OneToOneField(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("صاحب المراجعه"),
        on_delete=models.CASCADE
    )
    rating = models.PositiveSmallIntegerField(
        _("التقييم"),
        choices=[(i, str(i)) for i in range(1, 6)],  
        default=1,
    )
    review = models.TextField(_("التعليق"))
    status = models.BooleanField(_("الحاله"), default=True)
    has_res = models.BooleanField(_("هل قام بالحجز"), default=False)

    class Meta:
        verbose_name = _("مراجعه")
        verbose_name_plural = _("المراجعات")
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.user_id} - {self.hotel_id} - {self.rating}"


# -------------------- Offer ----------------------------

class Offer(BaseModel):
    offer_id = models.AutoField(primary_key=True)
    hotel_id = models.ForeignKey(
        Hotel, 
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
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
    
    class Meta:
        verbose_name = _("عرض")
        verbose_name_plural = _("العروض")
        db_table = 'offers'

    def __str__(self):
        return self.offer_name

    def clean(self):
        if self.offer_end_date < self.offer_start_date:
            raise ValidationError(_("تاريخ نهاية العرض يجب أن يكون بعد تاريخ البداية"))