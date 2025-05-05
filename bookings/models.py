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

from users.utils import send_whatsapp_via_sadeem
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
    rooms_booked = models.PositiveIntegerField(
        verbose_name=_("عدد الغرف المحجوزة"),
        default=1,
        validators=[MinValueValidator(1)]
    )
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

    def __str__(self):
        return f"Booking #{self.id} - {self.room.name} ({self.rooms_booked} rooms)"
    def update_availability(self, change, start_date=None, end_date=None):
        """تحديث التوافر بين تاريخين محددين"""
        start = (start_date or self.check_in_date).date()
        end = (end_date or self.check_out_date).date()

        print(f"update_availability called: change={change}, start={start}, end={end}")
        with transaction.atomic():
            current = start
            while current < end:
                availability = Availability.objects.get(
                    hotel=self.hotel,
                    room_type=self.room,
                    availability_date=current
                )
                print(f"[{current}] before: {availability.available_rooms}")
                availability.available_rooms += change
                availability.save()
                print(f"[{current}] after: {availability.available_rooms}")
                current += timedelta(days=1)

    from django.utils.translation import gettext as _
    from django.urls import reverse

    def send_notification(self, type=None, title=None, receiver=None, messages=None, action=None):
        """
        إرسال إشعار للمستخدم + رسالة واتساب (عند الحاجة).
        """
        receiver = receiver or self.user
        title = title or _("إشعار إتمام الحجز")
        message = messages or _("يرجى إضافة الضيوف لحجزك.")
        action_url = action or reverse("payments:add_guest", args=[self.room.id])
        notification_type = '2' if type == 'CONFIRMED' else '1'

        Notifications.objects.create(
            sender=self.user,
            user=receiver,
            title=title,
            message=message,
            notification_type=notification_type,
            action_url=action_url,
        )

        if messages is None:
            send_whatsapp_via_sadeem(
                phone_number=f"+{receiver.phone}",
                message=(
                    f"📢 *تنبيه هام*\n"
                    f"يرجى إضافة الضيوف لحجزك لإتمام الإجراءات.\n"
                    f"رقم الحجز: {self.id}\n"
                )
            )


    def send_cancellation_notification(self):
        message = _("تم إلغاء حجزك.")
        Notifications.objects.create(
            sender=self.user,
            user=self.user,
            title=_("إلغاء الحجز"),
            message=message,
            notification_type='BOOKING_CANCELED',
        )

        send_whatsapp_via_sadeem(
            phone_number=f"+{self.user.phone}",
            message=(
                f"❌ *تم إلغاء حجزك*\n"
                f"رقم الحجز: {self.id}\n\n"
                f"للمزيد من التفاصيل، يرجى التواصل مع إدارة الفندق."
            )
        )

    def clean(self):
        super().clean()
        if self.status == Booking.BookingStatus.CONFIRMED:
            if not self.check_in_date or not self.check_out_date:
                raise ValidationError(_("يجب تحديد تاريخ الوصول والمغادرة."))
            if self.check_out_date <= self.check_in_date:
                raise ValidationError(_("تاريخ المغادرة يجب أن يكون بعد تاريخ الوصول."))
        if self.hotel != self.room.hotel:
            raise ValidationError(_("الغرفة و الفندق يجب أن يكونا من نفس الفندق."))
        

    def save(self, *args, **kwargs):
        is_new = self._state.adding
        original = None
        if not is_new:
            try:
                original = Booking.objects.get(pk=self.pk)
            except Booking.DoesNotExist:
                pass

        if is_new and self.status == Booking.BookingStatus.CONFIRMED:
            super().save(*args, **kwargs)
            print("New CONFIRMED booking: reducing availability")

            self.update_availability(change=-self.rooms_booked)

            self.send_notification(
                type='WARNING',
                title=_("إشعار بحجز جديد."),
                receiver=self.hotel.manager,
                messages=_(
                    f"📢 يوجد حجز جديد من {self.user.get_full_name()} لغرفة {self.room.name}."
                ),
                action="admin/bookings/booking/"
            )

            self.send_notification(
                type='CONFIRMED',
                title=_("تم تأكيد حجزك بنجاح.")
            )

            send_whatsapp_via_sadeem(
                phone_number=f"+{self.user.phone}",
                message=(
                    f"✅ *تم تأكيد حجزك بنجاح!*\n"
                    f"رقم الحجز: {self.id}\n"
                    f"الغرفة: {self.room.name}\n"
                    f"نشكرك على الحجز ونتمنى لك إقامة ممتعة."
                )
            )

            # Schedule end reminder
            if self.check_out_date:
                print("pass")
                # send_booking_end_reminders.apply_async(
                #     args=[self.id],
                #     eta=self.check_out_date - timezone.timedelta(hours=5)
                # )
            return

        super().save(*args, **kwargs)
        if not original:
            return

        if (
            original.status == Booking.BookingStatus.CONFIRMED and
            self.status == Booking.BookingStatus.CONFIRMED and
            (original.check_in_date != self.check_in_date or original.check_out_date != self.check_out_date)
        ):
            print("Date change on confirmed booking: resetting availability")
            self.update_availability(change=original.rooms_booked,
                                     start_date=original.check_in_date,
                                     end_date=original.check_out_date)
            self.update_availability(change=-self.rooms_booked,
                                     start_date=self.check_in_date,
                                     end_date=self.check_out_date)

        
        if original.status != self.status:
            if self.status == Booking.BookingStatus.CONFIRMED:
                print("Status changed to CONFIRMED: reducing availability")
                self.update_availability(change=-self.rooms_booked)
                self.send_notification(type='CONFIRMED', title=_("تم تأكيد حجزك بنجاح."))
                self.send_notification(type='WARNING', title=_("اشعار بحجز جديد."),receiver=original.hotel.manager,messages=_(f"يوجد لديك حجز جديد من {original.user} -  للغرفه   {original.room}"),action="admin/bookings/booking/")

                if self.check_out_date:
                    print("sss")
                    # send_booking_end_reminders.apply_async(
                    #     args=[self.id],
                    #     eta=self.check_out_date - timezone.timedelta(hours=5)
                    # )
            elif (self.status == Booking.BookingStatus.CANCELED and
                  original.status == Booking.BookingStatus.CONFIRMED):
                print("Status changed to CANCELED: restoring availability")
                self.update_availability(change=self.rooms_booked)
                self.send_cancellation_notification()

        if (
            original.status == Booking.BookingStatus.CONFIRMED and
            self.status == Booking.BookingStatus.CONFIRMED and
            self.actual_check_out_date and
            original.actual_check_out_date != self.actual_check_out_date
        ):
            print("Actual checkout updated: adjusting availability")
            actual_end = self.actual_check_out_date.date()
            self.update_availability(change=self.rooms_booked)
            # self.update_availability(change=-self.rooms_booked)

    @property
    def get_status_class(self):
        return {
            '0': 'info',
            '1': 'success',
            '2': 'danger'
        }.get(self.status, 'info')

    @property
    def get_status_icon(self):
        return {
            '0': 'clock',
            '1': 'check',
            '2': 'times'
        }.get(self.status, 'clock')




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

        