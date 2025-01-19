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
        related_name='hotel_reviews'
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
        related_name='room_reviews'
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

class Offer(BaseModel):
    hotel = models.ForeignKey(
        Hotel, 
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='offers'
    )
    name = models.CharField(
        max_length=100,
        verbose_name=_("اسم العرض")
    )
    description = models.TextField(
        verbose_name=_("وصف العرض"),
        help_text=_("اكتب تفاصيل العرض وشروطه")
    )
    start_date = models.DateField(
        verbose_name=_("تاريخ بداية العرض"),
        help_text=_("متى يبدأ العرض؟")
    )
    end_date = models.DateField(
        verbose_name=_("تاريخ نهاية العرض"),
        help_text=_("متى ينتهي العرض؟")
    )
    discount_percentage = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        verbose_name=_("نسبة الخصم"),
        help_text=_("نسبة الخصم (0-100)"),
        validators=[
            MinValueValidator(0),
            MaxValueValidator(100)
        ]
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_("نشط"),
        help_text=_("هل العرض متاح حالياً؟")
    )
    
    class Meta:
        verbose_name = _("عرض")
        verbose_name_plural = _("العروض")
        ordering = ['-start_date', 'end_date']
        constraints = [
            models.CheckConstraint(
                check=models.Q(end_date__gt=models.F('start_date')),
                name='offer_end_date_after_start_date'
            )
        ]

    def __str__(self):
        status = _("نشط") if self.is_active else _("منتهي")
        return f"{self.name} - {self.hotel.name} ({status})"

    def clean(self):
        super().clean()
        if self.end_date and self.start_date:
            if self.end_date < self.start_date:
                raise ValidationError({
                    'end_date': _("تاريخ نهاية العرض يجب أن يكون بعد تاريخ البداية")
                })
            
            if self.start_date < timezone.now().date():
                raise ValidationError({
                    'start_date': _("لا يمكن إنشاء عرض يبدأ في تاريخ سابق")
                })

    @property
    def is_valid(self):
        """التحقق من صلاحية العرض"""
        today = timezone.now().date()
        return (
            self.is_active and
            self.start_date <= today <= self.end_date
        )