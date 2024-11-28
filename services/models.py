from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from django.utils.text import slugify
from django.core.exceptions import ValidationError
from HotelManagement.models import BaseModel,Hotel

class Service(BaseModel):
    name = models.CharField(
        max_length=255,
        verbose_name=_("اسم الخدمة")
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
    #TODO------- add this column when abdullah done room model
    # room = models.ForeignKey(
    #     "Room",  
    #     null=True,
    #     blank=True,
    #     on_delete=models.CASCADE,
    #     related_name="services",
    #     verbose_name=_("الغرفة")
    # )

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
