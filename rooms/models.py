from django.db import models
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
from django.core.validators import MinValueValidator, MaxValueValidator
from django.core.exceptions import ValidationError
from HotelManagement.models import BaseModel, Hotel
from django.utils import timezone

from users.models import CustomUser


class Category(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='room_categories'
    )
    name = models.CharField(
        max_length=100,
        verbose_name=_("اسم التصنيف")
    )
    description = models.TextField(
        verbose_name=_("وصف التصنيف"),
        blank=True,
        null=True
    )

    class Meta:
        verbose_name = _("تصنيف")
        verbose_name_plural = _("تصنيفات")
        ordering = ['name']
        constraints = [
            models.UniqueConstraint(
                fields=['hotel', 'name'],
                name='unique_hotel_category'
            )
        ]

    def __str__(self):
        return f"{self.name} - {self.hotel.name}"


class RoomType(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='room_types'
    )
    category = models.ForeignKey(
        Category,
        on_delete=models.PROTECT,
        verbose_name=_("التصنيف"),
        related_name='room_types'
    )
    name = models.CharField(
        max_length=100,
        verbose_name=_("اسم نوع الغرفة")
    )
    
    description = models.TextField(
        verbose_name=_("وصف"),
        blank=True,
        null=True
    )
    default_capacity = models.PositiveIntegerField(
        verbose_name=_("السعة الافتراضية"),
        validators=[MinValueValidator(1)]
    )
    max_capacity = models.PositiveIntegerField(
        verbose_name=_("السعة القصوى"),
        validators=[MinValueValidator(1)]
    )
    beds_count = models.PositiveIntegerField(
        verbose_name=_("عدد الأسرة"),
        validators=[MinValueValidator(1)]
    )
    rooms_count = models.PositiveIntegerField(
        verbose_name=_("عدد الغرف"),
        validators=[MinValueValidator(0)]
    )
    base_price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("السعر الأساسي"),
        help_text=_("السعر الافتراضي للغرفة في الليلة الواحدة")
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_("متاح للحجز")
    )

    class Meta:
        verbose_name = _("نوع الغرفة")
        verbose_name_plural = _("أنواع الغرف")
        ordering = ['category', 'name']
        constraints = [
            models.CheckConstraint(
        check=models.Q(max_capacity__gte=models.F('default_capacity')),
        name='max_capacity_gte_default'
    )
        ]

    def __str__(self):
        return f"{self.name} ({self.hotel.name})"

    def clean(self):
        super().clean()
        if self.max_capacity < self.default_capacity:
            raise ValidationError({
                'max_capacity': _("السعة القصوى يجب أن تكون أكبر من أو تساوي السعة الافتراضية")
            })
    def get_absolute_url(self):
        return reverse('rooms:room_detail', args=[self.slug])
    

    @property
    def available_rooms_count(self):
        """عدد الغرف المتاحة حالياً"""
        today = timezone.now().date()
        availability = self.availabilities.filter(
            availability_date=today
        ).first()
        return availability.available_rooms if availability else 0


class RoomPrice(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='room_prices'
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة"),
        related_name='prices'
    )
    date_from = models.DateField(
        verbose_name=_("تاريخ البدء")
    )
    date_to = models.DateField(
        verbose_name=_("تاريخ الانتهاء")
    )
    price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("السعر"),
        validators=[MinValueValidator(0)]
    )
    is_special_offer = models.BooleanField(
        default=False,
        verbose_name=_("عرض خاص")
    )

    class Meta:
        verbose_name = _("سعر الغرفة")
        verbose_name_plural = _("أسعار الغرف")
        ordering = ['-date_from', 'room_type']
        constraints = [
            models.CheckConstraint(
                check=models.Q(date_to__gt=models.F('date_from')),
                name='valid_price_date_range'
            )
        ]

    def __str__(self):
        return f"{self.room_type.name} - {self.price} ({self.date_from} إلى {self.date_to})"

    def clean(self):
        super().clean()
        if self.date_to and self.date_from:
            if self.date_to <= self.date_from:
                raise ValidationError({
                    'date_to': _("تاريخ الانتهاء يجب أن يكون بعد تاريخ البدء")
                })


class RoomStatus(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='room_statuses'
    )
    code = models.CharField(
        max_length=50,
        verbose_name=_("رمز الحالة")
    )
    name = models.CharField(
        max_length=100,
        verbose_name=_("اسم الحالة")
    )
    description = models.TextField(
        verbose_name=_("وصف الحالة"),
        blank=True,
        null=True
    )
    is_available = models.BooleanField(
        default=True,
        verbose_name=_("متاح للحجز"),
        help_text=_("هل يمكن حجز الغرف في هذه الحالة؟")
    )

    class Meta:
        verbose_name = _("حالة الغرفة")
        verbose_name_plural = _("حالات الغرف")
        ordering = ['code']
        constraints = [
            models.UniqueConstraint(
                fields=['hotel', 'code'],
                name='unique_hotel_status_code'
            )
        ]

    def __str__(self):
        return f"{self.name} ({self.code})"



class Availability(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='room_availabilities'
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة"),
        related_name='availabilities'
    )
    room_status = models.ForeignKey(
        RoomStatus,
        on_delete=models.CASCADE,
        verbose_name=_("حالة الغرفة"),
        related_name='availabilities'
    )
    availability_date = models.DateField(  
        verbose_name=_("تاريخ التوفر")
    )
    available_rooms = models.PositiveIntegerField(
        verbose_name=_("عدد الغرف المتوفرة"),
        validators=[MinValueValidator(0)]
    )
    notes = models.TextField(
        verbose_name=_("ملاحظات"),
        blank=True,
        null=True
    )

    class Meta:
        verbose_name = _("توفر الغرف")
        verbose_name_plural = _("توفر الغرف")
        ordering = ['-availability_date', 'room_type']
        constraints = [
            models.UniqueConstraint(
                fields=['hotel', 'room_type', 'availability_date'],
                name='unique_room_availability'
            )
        ]

    def clean(self):
        super().clean()
        if self.available_rooms > self.room_type.rooms_count:
            raise ValidationError({
                'available_rooms': _("عدد الغرف المتوفرة لا يمكن أن يتجاوز العدد الكلي للغرف")
            })



class RoomImage(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='room_images'
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة"),
        related_name='images'
    )
    image = models.ImageField(
        upload_to='room_images/',
        verbose_name=_("الصورة")
    )
    is_main = models.BooleanField(
        default=False,
        verbose_name=_("صورة رئيسية")
    )
    caption = models.CharField(
        max_length=255,
        verbose_name=_("وصف الصورة"),
        blank=True,
        null=True
    )

    class Meta:
        verbose_name = _("صورة الغرفة")
        verbose_name_plural = _("صور الغرف")
        ordering = ['-is_main', 'room_type']

    def __str__(self):
        main_text = _("رئيسية") if self.is_main else _("إضافية")
        return f"{self.room_type.name} - {main_text}"

    def clean(self):
        super().clean()
        if self.is_main and RoomImage.objects.filter(room_type=self.room_type, is_main=True).exists():
            raise ValidationError(_("لا يمكن أن تكون هناك أكثر من صورة رئيسية واحدة لكل نوع غرفة"))




#تحت التطوير 
class Review(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='reviews'
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة"),
        related_name='reviews'
    )
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    rating = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(5)],
        verbose_name=_("التقييم")
    )
    content = models.TextField(
        verbose_name=_("محتوى المراجعة")
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = _("مراجعة")
        verbose_name_plural = _("مراجعات")
        ordering = ['-created_at']

    def __str__(self):
        return f'Review by {self.user.username} for {self.room_type.name} in {self.hotel.name}'