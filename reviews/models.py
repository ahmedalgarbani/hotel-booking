from django.db import models
from django.utils.translation import gettext_lazy as _
from HotelManagement.models import BaseModel, Hotel
from django.conf import settings
from django.core.exceptions import ValidationError
from django.contrib.auth import get_user_model
from django.utils import timezone
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from django.conf import settings
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _

from django.db import models
import uuid
from unidecode import unidecode  # Import unidecode

from rooms.models import RoomType


class HotelReview(BaseModel):
    hotel = models.ForeignKey(
        Hotel, 
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='hotel_reviews'
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("صاحب المراجعة"),
        on_delete=models.CASCADE,
        related_name='hotel_review'
    )

    rating_service = models.PositiveSmallIntegerField(
        verbose_name=_("الخدمات"),
        choices=[(i, f"{i} نجوم" if i > 1 else "نجمة واحدة") for i in range(1, 6)],
        default=5,
    )
    rating_location = models.PositiveSmallIntegerField(
        verbose_name=_("موقع الفندق"),
        choices=[(i, f"{i} نجوم" if i > 1 else "نجمة واحدة") for i in range(1, 6)],
        default=5,
    )
    rating_value_for_money = models.PositiveSmallIntegerField(
        verbose_name=_("القيمة مقابل المال"),
        choices=[(i, f"{i} نجوم" if i > 1 else "نجمة واحدة") for i in range(1, 6)],
        default=5,
    )
    rating_cleanliness = models.PositiveSmallIntegerField(
        verbose_name=_("النظافة"),
        choices=[(i, f"{i} نجوم" if i > 1 else "نجمة واحدة") for i in range(1, 6)],
        default=5,
    )
    review = models.TextField(
        verbose_name=_("التعليق"),
        help_text=_("اكتب رأيك عن تجربتك في الفندق")
    )
    status = models.BooleanField(
        verbose_name=_("نشط"),
        default=True,
        help_text=_("هل المراجعة مرئية للجميع؟")
    )

    class Meta:
        verbose_name = _("مراجعة فندق")
        verbose_name_plural = _("مراجعات الفنادق")
        ordering = ['-created_at']
        constraints = [
            models.UniqueConstraint(
                fields=['hotel', 'user'],
                name='unique_hotel_user_review'
            )
        ]

    def __str__(self):
        return f"{self.user.get_full_name()} - {self.hotel.name} ({self.rating_service} نجوم)"
    
    

class RoomReview(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='rooms_reviews'
    )

    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.SET_NULL,
        verbose_name=_("نوع الغرفة"),
        related_name='room_reviews',
        null=True,
        blank=True
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        verbose_name=_("صاحب المراجعة"),
        on_delete=models.CASCADE,
        related_name='room_reviews'
    )
    rating = models.PositiveSmallIntegerField(
        verbose_name=_("تقييم الغرفة"),
        choices=[(i, f"{i} نجوم" if i > 1 else "نجمة واحدة") for i in range(1, 6)],
        default=5,
    )
    review = models.TextField(
        verbose_name=_("التعليق"),
        help_text=_("اكتب رأيك عن الغرفة")
    )
    status = models.BooleanField(
        verbose_name=_("نشط"),
        default=True,
        help_text=_("هل المراجعة مرئية للجميع؟")
    )

    class Meta:
        verbose_name = _("مراجعة غرفة")
        verbose_name_plural = _("مراجعات الغرف")
        ordering = ['-created_at']
        constraints = [
            models.UniqueConstraint(
                fields=['hotel', 'room_type', 'user'],
                name='unique_room_user_review'
            )
        ]


    def __str__(self):
        return f"{self.user.get_full_name()} - {self.room_type.name if self.room_type else 'No Room'} ({self.rating} نجوم)"



class RoomReview(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='rooms_reviews'
    )

    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.SET_NULL,
        verbose_name=_("نوع الغرفة"),
        related_name='room_reviews',
        null=True,
        blank=True
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        verbose_name=_("صاحب المراجعة"),
        on_delete=models.CASCADE,
        related_name='room_reviews'
    )
    rating = models.PositiveSmallIntegerField(
        verbose_name=_("تقييم الغرفة"),
        choices=[(i, f"{i} نجوم" if i > 1 else "نجمة واحدة") for i in range(1, 6)],
        default=5,
    )
    review = models.TextField(
        verbose_name=_("التعليق"),
        help_text=_("اكتب رأيك عن الغرفة")
    )
    status = models.BooleanField(
        verbose_name=_("نشط"),
        default=True,
        help_text=_("هل المراجعة مرئية للجميع؟")
    )

    class Meta:
        verbose_name = _("مراجعة غرفة")
        verbose_name_plural = _("مراجعات الغرف")
        ordering = ['-created_at']
        constraints = [
            models.UniqueConstraint(
                fields=['hotel', 'room_type', 'user'],
                name='unique_room_user_review'
            )
        ]

  
    def __str__(self):
        return f"{self.user.get_full_name()} - {self.room_type.name if self.room_type else 'No Room'} ({self.rating} نجوم)"
