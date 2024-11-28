from django.db import models
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import BaseModel,Hotel
from django.conf import settings

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
