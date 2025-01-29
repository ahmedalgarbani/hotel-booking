from django.conf import settings
from django.db import models
from HotelManagement.models import BaseModel
from django.utils.translation import gettext_lazy as _

from services.models import RoomTypeService

# ------------ Guest -------------
class Guest(BaseModel):
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='guests'
    )
    name = models.CharField(
        verbose_name=_("الاسم"),
        max_length=150
    )
    phone_number = models.CharField(
        verbose_name=_("رقم الهاتف"),
        max_length=14
    )
    id_card_number = models.CharField(
        verbose_name=_("رقم الهوية"),
        max_length=30
    )
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='guests'
    )
    account = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        verbose_name=_("المستخدم"),
        related_name='guests',
        null=True,
        blank=True
    )

    class Meta:
        verbose_name = _("ضيف")
        verbose_name_plural = _("الضيوف")
        ordering = ['name']

    def __str__(self):
        return f"{self.name} - {self.phone_number}"


# ------------ Booking Status -------------
class BookingStatus(BaseModel):
    booking_status_name = models.CharField(
        max_length=50,
        verbose_name=_("اسم الحالة")
    )
    status_code = models.IntegerField(
        verbose_name=_("رمز الحالة")
    )

    class Meta:
        verbose_name = _("حالة الحجز")
        verbose_name_plural = _("حالات الحجز")
        ordering = ['status_code']

    def __str__(self):
        return f"{self.booking_status_name} ({self.status_code})"


# ------------ Booking -------------
class Booking(BaseModel):
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
    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("المبلغ")
    )
    status = models.ForeignKey(
        'bookings.BookingStatus',
        on_delete=models.CASCADE,
        verbose_name=_("حالة الحجز"),
        related_name='bookings'
    )

    class Meta:
        verbose_name = _("حجز")
        verbose_name_plural = _("الحجوزات")
        ordering = ['-check_in_date']

    def __str__(self):
        return f"Booking #{self.id if self.id else 'New'} - {self.room}"

    @property
    def duration(self):
        """حساب مدة الإقامة بالأيام"""
        if self.check_in_date and self.check_out_date:
            return (self.check_out_date - self.check_in_date).days
        return 0


# ------------ Booking Detail -------------
class BookingDetail(BaseModel):
    service = models.ForeignKey(
        RoomTypeService,
        on_delete=models.CASCADE,
        verbose_name=_("الخدمة"),
        related_name='booking_details'
    )
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='details'
    )
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='booking_details'
    )
    quantity = models.PositiveIntegerField(
        default=1,
        verbose_name=_("الكمية")
    )
    price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name=_("السعر")
    )
    notes = models.TextField(
        max_length=300,
        verbose_name=_("ملاحظات"),
        blank=True,
        null=True
    )

    class Meta:
        verbose_name = _("تفصيل الحجز")
        verbose_name_plural = _("تفاصيل الحجز")
        ordering = ['service']

    def __str__(self):
        return f"{self.service} - {self.booking}"

    @property
    def total(self):
        """حساب المبلغ الإجمالي"""
        return self.quantity * self.price
