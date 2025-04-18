from datetime import timedelta
from unittest.mock import DEFAULT
from django.conf import settings
from django.db import models,transaction
from django.urls import reverse
from HotelManagement.models import BaseModel
from bookings.tasks import send_booking_end_reminders
from notifications.models import Notifications
from rooms.models import Availability
from django.db import models
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.conf import settings
from services.models import RoomTypeService
from django.core.validators import MinValueValidator
from django.core.exceptions import ValidationError
from django.contrib.auth import get_user_model
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
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.name} - {self.id}"




# ------------ Booking -------------


class Booking(BaseModel):
    class BookingStatus(models.TextChoices):
        PENDING = "0", _("قيد الانتظار")
        CONFIRMED = "1", _("مؤكد")
        CANCELED = "2", _("ملغي")
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
        is_new = self._state.adding
        previous = None
        previous_status = None
        previous_actual_checkout = None

        if not is_new:
            previous = Booking.objects.filter(pk=self.pk).first()
            if previous:
                previous_status = previous.status
                previous_actual_checkout = previous.actual_check_out_date

        if self.status == Booking.BookingStatus.CONFIRMED:
            if not self.check_in_date or not self.check_out_date:
                raise ValidationError("يجب تحديد تاريخ الوصول والمغادرة.")
            if self.check_out_date <= self.check_in_date:
                raise ValidationError("تاريخ المغادرة يجب أن يكون بعد تاريخ الوصول.")
            
            start_date = self.check_in_date.date()
            end_date = self.check_out_date.date()
            for day in range((end_date - start_date).days):
                date = start_date + timedelta(days=day)
                availability = Availability.objects.filter(
                    hotel=self.hotel,
                    room_type=self.room,
                    availability_date=date
                ).first()

                if not availability or availability.available_rooms < self.rooms_booked:
                    raise ValidationError(f"لا يوجد غرف كافية في يوم {date}")

        if self.status == Booking.BookingStatus.CONFIRMED and (is_new or previous_status != Booking.BookingStatus.CONFIRMED):
            self.update_availability(-self.rooms_booked)

        if previous_status == Booking.BookingStatus.CONFIRMED and self.status in [Booking.BookingStatus.CANCELED, Booking.BookingStatus.PENDING]:
            self.update_availability(self.rooms_booked)

        if self.actual_check_out_date and previous and not previous_actual_checkout:
            self.update_availability(self.rooms_booked)

        super().save(*args, **kwargs)

        if self.status == Booking.BookingStatus.CONFIRMED and self.check_out_date:
            send_booking_end_reminders.apply_async(
                args=[self.id],
                eta=self.check_out_date - timezone.timedelta(hours=5)
            )




    def send_notification(self):
        """Send a notification to the user to add guests."""
        message = _("يرجى إضافة الضيوف لحجزك.")
        action_url = reverse("payments:add_guest", args=[self.room.id]) 
        Notifications.objects.create(
            sender=self.user, 
            user=self.user,
            title="اشعار اتمام الحجز",
            message=message,
            notification_type='1', 
            action_url=action_url,
        )
         
    
    def update_availability(self, change):
        if not self.check_in_date or not self.check_out_date:
            return

        start_date = self.check_in_date.date()
        end_date = self.check_out_date.date()
        total_days = (end_date - start_date).days

        with transaction.atomic():
            for day in range(total_days):
                date = start_date + timedelta(days=day)
                availability, created = Availability.objects.get_or_create(
                    hotel=self.hotel,
                    room_type=self.room,
                    availability_date=date,
                    defaults={'available_rooms': 0}
                )
                availability.available_rooms += change
                if availability.available_rooms < 0:
                    raise ValidationError(f"لا يوجد غرف كافية في يوم {date}")
                availability.save()

    


    def __str__(self):
        return f"Booking #{self.id} - {self.room.name} ({self.rooms_booked} rooms)"


    @property
    def get_status_class(self):
        status_map = {
            '0': 'info',
            '1': 'success',
            '2': 'danger'
        }
        return status_map.get(self.status, 'info')
    
    @property
    def get_status_icon(self):
        icon_map = {
            '0': 'clock',
            '1': 'check',
            '2': 'times'
        }
        return icon_map.get(self.status, 'clock')


# ------------ Booking Detail -------------
class BookingDetail(BaseModel):
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
            self.id = self.booking.id  
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.service} - {self.id}"




#----------- Booking Extenseion ----------

class ExtensionMovement(models.Model):
    movement_number = models.AutoField(primary_key=True, verbose_name="رقم الحركة")
    booking = models.ForeignKey(Booking, on_delete=models.CASCADE,verbose_name="رقم الحجز")
    payment_receipt = models.ForeignKey('payments.Payment', on_delete=models.SET_NULL, null=True, blank=True,verbose_name="رقم سند الدفع")
    original_departure = models.DateField(verbose_name="تاريخ المغادرة قبل التمديد")
    extension_date = models.DateField(default=timezone.now, verbose_name="تاريخ التمديد")
    new_departure = models.DateField(verbose_name="تاريخ المغادرة الجديد")
    REASON_CHOICES = [
        ('personal', 'تغيير خطط شخصية'),
        ('business', 'تمديد أعمال'),
        ('technical', 'مشكلات فنية (طيران/مواصلات)'),
        ('other', 'أسباب أخرى'),
    ]
    reason = models.CharField(max_length=50, choices=REASON_CHOICES, verbose_name="سبب التمديد")
    extension_year = models.PositiveIntegerField(editable=False) 
    duration = models.PositiveIntegerField(verbose_name="مدة التمديد (أيام)", default=0)


    def save(self, *args, **kwargs):
        self.extension_duration = (self.new_departure - self.original_departure).days
        self.extension_year = self.extension_date.year
        super().save(*args, **kwargs)

    def __str__(self):
        return f"حركة #{self.movement_number} - حجز {self.booking.id}"    
    





# -------------- HISTORY -----------------


class BookingHistory(models.Model):
    class BookingStatus(models.TextChoices):
        PENDING = "0", _("قيد الانتظار")
        CONFIRMED = "1", _("مؤكد")
        CANCELED = "2", _("ملغي")

    booking = models.ForeignKey(
        'bookings.Booking',
        on_delete=models.CASCADE,
        verbose_name=_("الحجز"),
        related_name='history_entries'
    )
    history_date = models.DateTimeField(
        auto_now_add=True,
        verbose_name=_("تاريخ التعديل")
    )
    changed_by = models.ForeignKey(
        get_user_model(),
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_("المستخدم الذي قام بالتغيير")
    )
    previous_status = models.CharField(
        max_length=10,
        choices=Booking.BookingStatus.choices,
        verbose_name=_("الحالة السابقة"),
        null=True,
        blank=True
    )
    new_status = models.CharField(
        max_length=10,
        choices=Booking.BookingStatus.choices,
        verbose_name=_("الحالة الجديدة")
    )
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        verbose_name=_("الفندق"),
        related_name='+'
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        verbose_name=_("المستخدم"),
        related_name='+',
        null=True,
        blank=True
    )
    room = models.ForeignKey(
        'rooms.RoomType',
        on_delete=models.CASCADE,
        verbose_name=_("نوع الغرفة"),
        related_name='+'
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
    account_status = models.BooleanField(
        verbose_name=_("حالة الحساب")
    )
    rooms_booked = models.PositiveIntegerField(
        verbose_name=_("عدد الغرف المحجوزة"),
        validators=[MinValueValidator(1)]
    )
    parent_booking = models.ForeignKey(
        Booking,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name=_("الحجز الأصلي"),
        related_name='+'
    )

    class Meta:
        verbose_name = _("سجل الحجز")
        verbose_name_plural = _("سجلات الحجوزات")
        ordering = ['-history_date']

    def __str__(self):
        return f"History entry for Booking #{self.booking.id} at {self.history_date}"

        