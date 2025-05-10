from datetime import timedelta
from unittest.mock import DEFAULT
from django.conf import settings
from django.db import models,transaction
from django.urls import reverse
from HotelManagement.models import BaseModel
from bookings.services.helpers import to_date
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
    rooms_booked = models.PositiveIntegerField(
        verbose_name=_("عدد الغرف المحجوزة"),
        default=1,
        validators=[MinValueValidator(1)]
    )


    class Meta:
        verbose_name = _("حجز")
        verbose_name_plural = _("الحجوزات")
        ordering = ['-check_in_date']

    def __str__(self):
        return f"Booking #{self.id} - {self.room.name} ({self.rooms_booked} rooms)"
    def update_availability(self, change, start_date=None, end_date=None):
        """تحديث التوافر بين تاريخين محددين"""
        start = to_date(start_date or self.check_in_date)
        end = to_date(end_date or self.check_out_date)

        # تم إزالة التأكد من وجود سجلات توافر للفترة المطلوبة

        print(f"update_availability called: change={change}, start={start}, end={end}")
        with transaction.atomic():
            current = start
            while current < end:
                try:
                    availability = Availability.objects.get(
                        hotel=self.hotel,
                        room_type=self.room,
                        availability_date=current
                    )
                    print(f"[{current}] before: {availability.available_rooms}")
                    availability.available_rooms += change
                    # التأكد من أن عدد الغرف المتوفرة لا يتجاوز إجمالي عدد الغرف
                    if availability.available_rooms > self.room.rooms_count:
                        availability.available_rooms = self.room.rooms_count
                    # التأكد من أن عدد الغرف المتوفرة لا يقل عن صفر
                    if availability.available_rooms < 0:
                        availability.available_rooms = 0
                    availability.save()
                    print(f"[{current}] after: {availability.available_rooms}")
                except Availability.DoesNotExist:

                    print(f"[{current}] created: {availability.available_rooms}")
                current += timedelta(days=1)

    def send_notification(self, type=None, title=None,receiver=None,messages=None,action=None):
        """إرسال إشعار للمستخدم"""
        message = messages if messages else  _("يرجى إضافة الضيوف لحجزك.")
        action_url = action if action else reverse("payments:add_guest", args=[self.room.id])
        Notifications.objects.create(
            sender=self.user,
            user=receiver if receiver else self.user,
            title=title if title else _("اشعار اتمام الحجز"),
            message=message,
            notification_type='2' if type == 'CONFIRMED' else '1',
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

    def clean(self):
        super().clean()
        if self.status == Booking.BookingStatus.CONFIRMED:
            if not self.check_in_date or not self.check_out_date:
                raise ValidationError(_("يجب تحديد تاريخ الوصول والمغادرة."))
            if self.check_out_date <= self.check_in_date:
                raise ValidationError(_("تاريخ المغادرة يجب أن يكون بعد تاريخ الوصول."))
        # التحقق من أن الفندق والغرفة من نفس الفندق فقط إذا تم تعيين كلاهما
        if hasattr(self, 'hotel') and hasattr(self, 'room') and self.hotel and self.room:
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

        # تعيين الفندق تلقائيًا من الغرفة إذا لم يتم تعيينه
        if not self.hotel_id and self.room_id:
            self.hotel = self.room.hotel

        if is_new and self.status == Booking.BookingStatus.CONFIRMED:
            super().save(*args, **kwargs)
            print("New CONFIRMED booking: reducing availability")
            self.update_availability(change=-self.rooms_booked)
            self.send_notification(type='WARNING', title=_("اشعار بحجز جديد."),receiver=original.hotel.manager,messages=_(f"يوجد لديك حجز جديد من {original.user} -  للغرفه   {original.room}"),action="bookings/booking/")
            self.send_notification(type='CONFIRMED', title=_("تم تأكيد حجزك بنجاح."))
            # Schedule end reminder
            if self.check_out_date:
                print("pass")
                # send_booking_end_reminders.apply_async(
                #     args=[self.id],
                #     eta=self.check_out_date - timezone.timedelta(hours=5)
                # )
            return
        if is_new and self.status == Booking.BookingStatus.PENDING:
            super().save(*args, **kwargs)
            self.send_notification(type='WARNING', title=_("اشعار بحجز جديد."),receiver=self.hotel.manager,messages=_(f"يوجد لديك حجز جديد من {self.user} -  للغرفه   {self.room}"),action="bookings/booking/")
            self.send_notification(type='WARNING', title=_(" استلام حجزك بنجاح."),messages=_("يرجى الانتظار الى حين مراحعه حجزك"))
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

    from django.core.exceptions import ValidationError
    from datetime import timedelta


    def clean(self):
        super().clean()

        if self.new_departure <= self.original_departure:
            raise ValidationError(_("تاريخ المغادرة الجديد يجب أن يكون بعد التاريخ الأصلي."))

        booking = self.booking
        hotel = booking.hotel
        room = booking.room
        rooms_needed = booking.rooms_booked

        current_date = self.original_departure
        while current_date < self.new_departure:
            try:
                availability = Availability.objects.get(
                    hotel=hotel,
                    room_type=room,
                    availability_date=current_date
                )
                if availability.available_rooms < rooms_needed:
                    raise ValidationError(
                        _(f"لا توجد غرف كافية في تاريخ {current_date.strftime('%Y-%m-%d')}. المتاح: {availability.available_rooms}, المطلوب: {rooms_needed}")
                    )
            except Availability.DoesNotExist:
                raise ValidationError(
                    _(f"لا توجد بيانات توافر ليوم {current_date.strftime('%Y-%m-%d')}.")
                )
            current_date += timedelta(days=1)

    def save(self, *args, **kwargs):
        self.extension_year = self.extension_date.year
        is_new = self._state.adding

        if not is_new:
            original = ExtensionMovement.objects.get(pk=self.pk)
            if original.new_departure != self.new_departure:
                self.booking.update_availability(
                    change=-self.booking.rooms_booked,
                    start_date=self.original_departure,
                    end_date=self.new_departure
                )
        else:
            self.booking.update_availability(
                change=-self.booking.rooms_booked,
                start_date=self.original_departure,
                end_date=self.new_departure
            )

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


    class Meta:
        verbose_name = _("سجل الحجز")
        verbose_name_plural = _("سجلات الحجوزات")
        ordering = ['-history_date']

    def __str__(self):
        return f"History entry for Booking #{self.booking.id} at {self.history_date}"

