from django.db import models
from HotelManagement.models import BaseModel
from django.utils.translation import gettext_lazy as _

# ------------ Guest -------------
class Guest(BaseModel):
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='guests'
    )
    name = models.CharField(_("Name"), max_length=150)
    phone_number = models.CharField(_("Phone Number"), max_length=14)
    id_card_number = models.CharField(_("ID Card Number"), max_length=30)  
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='guest_bookings' 
    )
    account = models.ForeignKey(
        'users.CustomUser',
        on_delete=models.CASCADE,
        verbose_name=_("المستخدم"),
        related_name='guest_accounts',
        null=True,
        blank=True
    )

    class Meta:
        verbose_name = _("ضيف")
        verbose_name_plural = _("الضيوف")

    def __str__(self):
        return f"{self.name}"


# ------------ Booking Status -------------
class BookingStatus(BaseModel):
    booking_status_name = models.CharField(max_length=50)
    status_code = models.IntegerField()

    class Meta:
        verbose_name = _("حالة الحجز")
        verbose_name_plural = _("حالات الحجز")

    def __str__(self):
        return f"{self.booking_status_name}"


# ------------ Booking -------------
class Booking(BaseModel):
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='bookings'
    )
    #!----- فك التعليق هذا ياعمار ياسر
    # user = models.ForeignKey(  
    #     'users.CustomUser',
    #     on_delete=models.CASCADE,
    #     verbose_name=_("المستخدم"),
    #     related_name='user_bookings', 
    #     null=True,
    #     blank=True
    # )
    room = models.ForeignKey(
        'rooms.RoomType',
        on_delete=models.CASCADE,
        verbose_name=_("الغرفة"),
        related_name='room_bookings'  
    )
    check_in_date = models.DateTimeField(
        null=True,
        blank=True,
        verbose_name=_("تاريخ بداية الحجز")
    )
    check_out_date = models.DateTimeField(
        null=True,
        blank=True,
        verbose_name=_("تاريخ الخروج")
    )
    amount = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        verbose_name = _("حجز")
        verbose_name_plural = _("حجوزات")

    def __str__(self):
        return f"Booking at {self.hotel} - Amount: {self.amount}"


# ------------ Booking Detail -------------
class BookingDetail(BaseModel):
    service = models.ForeignKey(
        'services.Service',
        on_delete=models.CASCADE,
        verbose_name=_("الخدمة"),
        related_name='booking_details_sercives'  
    )
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='booking_details_bookings'  
    )
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='booking_details_hotels'
    )

    class Meta:
        verbose_name = _("تفصيل الحجز")
        verbose_name_plural = _("تفاصيل الحجز")

    def __str__(self):
        return f"Detail for Booking: {self.booking.id}"
