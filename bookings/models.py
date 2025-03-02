from django.conf import settings
from django.db import models
from HotelManagement.models import BaseModel
from django.utils.translation import gettext_lazy as _
from rooms.models import Availability
from django.db import models
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from services.models import RoomTypeService

import uuid
# ------------ Guest ------------

class Guest(BaseModel):
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='guests'
    )
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='guests'
    )
    booking_number = models.CharField(
        max_length=20,
        verbose_name=_("رقم الحجز"),
        editable=False
    )
    name = models.CharField(verbose_name=_("الاسم"), max_length=150)
    phone_number = models.CharField(verbose_name=_("رقم الهاتف"), max_length=14)
    id_card_number = models.CharField(verbose_name=_("رقم الهوية"), max_length=30)
    age = models.PositiveIntegerField(verbose_name=_("العمر"), null=True, blank=True)
    check_in_date = models.DateTimeField(verbose_name=_("تاريخ تسجيل الدخول"), null=True, blank=True)
    check_out_date = models.DateTimeField(verbose_name=_("تاريخ تسجيل الخروج"), null=True, blank=True)

    class Meta:
        verbose_name = _("ضيف")
        verbose_name_plural = _("الضيوف")
        ordering = ['name']
        unique_together = ('hotel', 'id_card_number')

    def save(self, *args, **kwargs):
        if self.booking:
            self.booking_number = self.booking.booking_number  # ربط برقم الحجز
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name} - {self.booking_number}"





# ------------ Booking -------------


class Booking(BaseModel):
    class BookingStatus(models.TextChoices):
        PENDING = "0", _("قيد الانتظار")
        CONFIRMED = "1", _("مؤكد")
        CANCELED = "2", _("ملغي")

    booking_number = models.CharField(
        max_length=20,
        editable=False,
        verbose_name=_("رقم الحجز")
    )
    
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='bookings'
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        verbose_name=_("المستخدم"),
        related_name='bookings',
        null=True,
        blank=True
    )
    room = models.ForeignKey(
        'rooms.RoomType',
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة"),
        related_name='bookings'
    )
    check_in_date = models.DateTimeField(
        verbose_name=_("تاريخ تسجيل الدخول"),
        null=True,
        blank=True
    )
    check_out_date = models.DateTimeField(
        verbose_name=_("تاريخ تسجيل الخروج"),
        null=True,
        blank=True
    )
    actual_check_out_date = models.DateTimeField(
        verbose_name=_("تاريخ المغادرة الفعلي"),
        null=True,
        blank=True
    )
    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("المبلغ")
    )
    status = models.CharField(
        max_length=10,
        choices=BookingStatus.choices,
        default=BookingStatus.PENDING,
        verbose_name=_("حالة الحجز")
    )
    account_status = models.BooleanField(
        default=True,
        verbose_name=_("حالة الحساب")
    )

    class Meta:
        verbose_name = _("حجز")
        verbose_name_plural = _("الحجوزات")
        ordering = ['-check_in_date']

    def save(self, *args, **kwargs):
        if not self.booking_number:
            self.booking_number = f"BKG-{uuid.uuid4().hex[:10].upper()}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Booking #{self.booking_number} - {self.room}"

    @property
    def duration(self):
        """حساب مدة الإقامة بالأيام"""
        if self.check_in_date and self.check_out_date:
            return (self.check_out_date - self.check_in_date).days
        return 0

# ------------ Booking Detail -------------
class BookingDetail(BaseModel):
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='details'
    )
    booking_number = models.CharField(
        max_length=20,
        verbose_name=_("رقم الحجز"),
        editable=False
    )
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='booking_details'
    )
    service = models.ForeignKey(
        RoomTypeService,
        on_delete=models.CASCADE,
        verbose_name=_("الخدمة"),
        related_name='booking_details'
    )
    quantity = models.PositiveIntegerField(default=1, verbose_name=_("الكمية"))
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name=_("السعر"))
    total = models.DecimalField(max_digits=10, decimal_places=2, verbose_name=_("الإجمالي"), editable=False)
    notes = models.TextField(max_length=300, verbose_name=_("ملاحظات"), blank=True, null=True)

    class Meta:
        verbose_name = _("تفصيل الحجز")
        verbose_name_plural = _("تفاصيل الحجز")
        ordering = ['service']

    def save(self, *args, **kwargs):
        self.total = self.quantity * self.price
        if self.booking:
            self.booking_number = self.booking.booking_number  
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.service} - {self.booking_number}"
