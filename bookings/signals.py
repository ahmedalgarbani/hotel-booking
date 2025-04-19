from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist
from .models import Booking, BookingHistory
from rooms.models import Availability 

@receiver(pre_save, sender=Booking)
def store_booking_pre_save(sender, instance, **kwargs):
    """
    تخزين نسخة من حالة الحجز قبل التعديل (إذا كان الحجز موجوداً بالفعل)
    """
    if instance.pk:
        try:
            instance._pre_save_instance = sender.objects.get(pk=instance.pk)
        except ObjectDoesNotExist:
            instance._pre_save_instance = None
    else:
        instance._pre_save_instance = None

@receiver(post_save, sender=Booking)
def create_booking_history_on_change(sender, instance, created, **kwargs):
    """
    إنشاء سجل جديد إذا تم تعديل الحجز الأصلي في أحد الحقول التالية:
    - الحالة
    - المبلغ
    - عدد الغرف
    - نوع الغرفة
    بالإضافة لتحديث التوفر وإرسال الإشعارات في حال تغيرت الحالة.
    """
    if instance.parent_booking is not None:
        return

    

    pre_instance = getattr(instance, '_pre_save_instance', None)
    if not pre_instance:
        return

    changes_detected = (
        pre_instance.status != instance.status or
        pre_instance.amount != instance.amount or
        pre_instance.rooms_booked != instance.rooms_booked or
        pre_instance.room_id != instance.room_id or
        pre_instance.actual_check_out_date != instance.actual_check_out_date
    )

    if changes_detected:
        BookingHistory.objects.create(
            booking=instance,
            changed_by=instance.user,
            previous_status=pre_instance.status,
            new_status=instance.status,
            hotel=instance.hotel,
            user=instance.user,
            room=instance.room,
            check_in_date=instance.check_in_date,
            check_out_date=instance.check_out_date,
            actual_check_out_date=instance.actual_check_out_date,
            amount=instance.amount,
            account_status=instance.account_status,
            rooms_booked=instance.rooms_booked,
            parent_booking=instance.parent_booking
        )

    previous_status = pre_instance.status
    today = timezone.now().date()

    if previous_status == "1" and instance.status == "0":
        instance.update_availability(-instance.rooms_booked)

    if instance.actual_check_out_date:
        instance.update_availability(instance.rooms_booked)

    if previous_status != "2" and instance.status == "2":
        instance.update_availability(instance.rooms_booked)

    if instance.status == "1":
        instance.send_confirmation_notification()

# @receiver(post_save, sender=Booking)
# def update_availability_on_completion(sender, instance, **kwargs):
#     """
#     تحديث التوفر عند اكتمال الحجز، على سبيل المثال عند تغير الحالة إلى 'complete'
#     """
#     if instance.status == '1':
#         availability = Availability.objects.filter(
#             room_type=instance.room,   
#             date=instance.check_in_date
#         ).first()
#         if availability and availability.available_rooms > 0:
#             availability.available_rooms -= 1  
#             availability.save()
