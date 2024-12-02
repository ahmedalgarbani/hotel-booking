from django.db import models
from django.db import models

from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import AbstractUser

from HotelManagement.models import BaseModel, Hotel


class RoomType(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق")
    )
    category_id = models.IntegerField(verbose_name=_("رقم التصنيف"))
    name = models.CharField(
        max_length=100,
        verbose_name=_("اسم نوع الغرفة")
    )
    description = models.TextField(
        blank=True, null=True,
        verbose_name=_("وصف")
    )
    default_capacity = models.IntegerField(
        verbose_name=_("السعة الافتراضية")
    )
    max_capacity = models.IntegerField(
        verbose_name=_("السعة القصوى")
    )
    number_per_room = models.IntegerField(
        verbose_name=_("عدد الأسرة لكل غرفة")
    )
    rooms_count = models.IntegerField(
        verbose_name=_("عدد الغرف")
    )

    class Meta:
        verbose_name = _("نوع الغرفة")
        verbose_name_plural = _("أنواع الغرف")


class RoomPrice(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق")
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة")
    )
    date_from = models.DateField(verbose_name=_("تاريخ البدء"))
    price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("السعر")
    )

    class Meta:
        verbose_name = _("سعر الغرفة")
        verbose_name_plural = _("أسعار الغرف")


class RoomStatus(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق")
    )
    status_code = models.CharField(
        max_length=50,
        verbose_name=_("رمز الحالة")
    )
    status_title = models.CharField(
        max_length=100,
        verbose_name=_("عنوان الحالة")
    )

    class Meta:
        verbose_name = _("حالة الغرفة")
        verbose_name_plural = _("حالات الغرف")


class Category(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق")
    )
    name = models.CharField(
        max_length=100,
        verbose_name=_("اسم التصنيف")
    )

    class Meta:
        verbose_name = _("تصنيف")
        verbose_name_plural = _("تصنيفات")


class Availability(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق")
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة")
    )
    room_status = models.ForeignKey(
        RoomStatus,
        on_delete=models.CASCADE,
        verbose_name=_("حالة الغرفة")
    )
    availability_date = models.DateField(verbose_name=_("تاريخ التوفر"))
    available_rooms = models.IntegerField(verbose_name=_("عدد الغرف المتوفرة"))
    price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("السعر")
    )

    class Meta:
        verbose_name = _("توفر الغرف")
        verbose_name_plural = _("توفر الغرف")


class RoomImage(BaseModel):
    hotel = models.ForeignKey(
        Hotel,
        on_delete=models.CASCADE,
        verbose_name=_("الفندق")
    )
    room_type = models.ForeignKey(
        RoomType,
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة")
    )
    image = models.ImageField(upload_to='rooms/img/%y/%m/%d',default=None,
        verbose_name=_("رابط الصورة"))

    class Meta:
        verbose_name = _("صورة الغرفة")
        verbose_name_plural = _("صور الغرف")

# Create your models here.

# Create your models here.
