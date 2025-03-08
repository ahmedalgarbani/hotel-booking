from django.conf import settings
from django.db import models,transaction
from django.urls import reverse
from HotelManagement.models import BaseModel
from notifications.models import Notifications
from rooms.models import Availability, RoomStatus
from django.db import models
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from services.models import RoomTypeService
from django.core.validators import MinValueValidator
from django.core.exceptions import ValidationError
import uuid
# ------------ Guest ------------

class Guest(models.Model):
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
    id_card_image = models.ImageField(
        verbose_name=_("صورة الهوية"),
        upload_to='guests/id_card_images/',
        null=True,
        blank=True
    )
    gender = models.CharField(
        verbose_name=_("الجنس"),
        max_length=10,
        choices=[('male', _('ذكر')), ('female', _('أنثى'))],
        null=True,
        blank=True
    )
    birthday_date = models.DateField(
        verbose_name=_("تاريخ الميلاد"),
        null=True,
        blank=True
    )
    check_in_date = models.DateTimeField(verbose_name=_("تاريخ تسجيل الدخول"), null=True, blank=True)
    check_out_date = models.DateTimeField(verbose_name=_("تاريخ تسجيل الخروج"), null=True, blank=True)

    class Meta:
        verbose_name = _("ضيف")
        verbose_name_plural = _("الضيوف")
        ordering = ['name']


    def save(self, *args, **kwargs):
        if self.booking:
            self.booking_number = self.booking.booking_number  
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
    rooms_booked = models.PositiveIntegerField(verbose_name=_("عدد الغرف المحجوزة"), default=1, validators=[MinValueValidator(1)])
    parent_booking = models.ForeignKey(
        'self',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_("الحجز الأصلي"),
        related_name='extensions'
    )

    class Meta:
        verbose_name = _("حجز")
        verbose_name_plural = _("الحجوزات")
        ordering = ['-check_in_date']



    def save(self, *args, **kwargs):
        is_new_booking = self._state.adding  
        previous_status = None

        if not is_new_booking:
            previous_booking = Booking.objects.get(pk=self.pk)
            previous_status = previous_booking.status

        latest_availability = (
            Availability.objects.filter(hotel=self.hotel, room_type=self.room)
            .order_by('-availability_date')
            .first()
        )

        available_rooms = latest_availability.available_rooms if latest_availability else self.room.rooms_count

        if is_new_booking and self.rooms_booked > available_rooms:
            raise ValidationError(f"Cannot book {self.rooms_booked} rooms. Only {available_rooms} rooms are available.")

        super().save(*args, **kwargs)  

        today = timezone.now().date()

        if is_new_booking or (previous_status == "1" and self.status == "0"):  
            self.update_availability(-self.rooms_booked, today)

        if self.actual_check_out_date:
            self.update_availability(self.rooms_booked, today)

        if previous_status != "2" and self.status == "2":  
            self.update_availability(self.rooms_booked, today)

        if self.status == "1": 
            self.send_notification() 



    def send_notification(self):
        """Send a notification to the user to add guests."""
        message = _("يرجى إضافة الضيوف لحجزك.")
        action_url = reverse("payments:add_guest", args=[self.room.id]) 
        Notifications.objects.create(
            sender=self.user, 
            user=self.user,
            message=message,
            notification_type='1', 
            action_url=action_url,
        )
         
    def update_availability(self, change, date):
        """Ensure availability is updated or created for today's date"""
        today = timezone.now().date() 

        with transaction.atomic():
            availability, created = Availability.objects.get_or_create(
                hotel=self.hotel,
                room_type=self.room,
                availability_date=today, 
                defaults={
                    "room_status": RoomStatus.objects.get(id=3),  
                    "available_rooms": max(0, self.room.rooms_count + change),  
                    "notes": f"Updated due to booking #{self.booking_number}",
                }
            )

            if not created:
                availability.available_rooms = max(0, availability.available_rooms + change)
                availability.notes = f"Updated due to booking #{self.booking_number}"
                availability.save()


    def __str__(self):
        return f"Booking #{self.booking_number} - {self.room.name} ({self.rooms_booked} rooms)"



# ------------ Booking Detail -------------
class BookingDetail(BaseModel):
    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='details'
    )
    booking_number = models.CharField(
        max_length=255,
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
