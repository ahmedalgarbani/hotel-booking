from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist
from .models import Booking, BookingHistory
from rooms.models import Availability 
from django.db.models.signals import pre_save
from django.dispatch import receiver
from django.core.exceptions import ObjectDoesNotExist
from django.utils import timezone
from bookings.models import Booking
from users.utils import send_whatsapp_via_sadeem

@receiver(pre_save, sender=Booking)
def store_booking_pre_save(sender, instance, **kwargs):
    """
    تخزين نسخة من حالة الحجز قبل التعديل (إذا كان الحجز موجوداً بالفعل)
    """
    if instance.pk:
        try:
            pre_instance = sender.objects.get(pk=instance.pk)
            instance._pre_save_instance = pre_instance
            previous_status = pre_instance.status
            current_status = instance.status
            today = timezone.now().date()

            # 1- من مؤكد إلى ملغي
            if previous_status == "1" and current_status == "0":
                instance.update_availability(-instance.rooms_booked)
                send_whatsapp_via_sadeem(
                    phone_number=f"+{instance.user.phone}",
                    message=(
                        f"❌ *تم إلغاء الحجز*\n"
                        f"رقم الحجز: {instance.id}\n"
                        f"لقد تم إلغاء الحجز الخاص بك. إذا كان لديك استفسار، يرجى التواصل معنا."
                    )
                )

            # 2- تسجيل الخروج
            if instance.actual_check_out_date:
                instance.update_availability(instance.rooms_booked)
                send_whatsapp_via_sadeem(
                    phone_number=f"+{instance.user.phone}",
                    message=(
                        f"👋 *شكراً لإقامتك معنا!*\n"
                        f"نتمنى أنك قضيت وقتاً ممتعاً.\n"
                        f"📄 رقم الحجز: {instance.id}\n"
                        f"إذا كان لديك أي ملاحظات، يسعدنا الاستماع إليها!"
                    )
                )

            # 3- من أي حالة إلى مكتمل
            if previous_status != "2" and current_status == "2":
                instance.update_availability(instance.rooms_booked)
                send_whatsapp_via_sadeem(
                    phone_number=f"+{instance.user.phone}",
                    message=(
                        f"✅ *تم إكمال الحجز*\n"
                        f"📄 رقم الحجز: {instance.id}\n"
                        f"تم اعتبار الحجز مكتمل بنجاح. نأمل أن تكون التجربة مميزة!"
                    )
                )

            # 4- حجز تم تأكيده
            if current_status == "1" and previous_status != "1":
                instance.send_notification()
                send_whatsapp_via_sadeem(
                    phone_number=f"+{instance.user.phone}",
                    message=(
                        f"✅ *تم تأكيد الحجز*\n"
                        f"📄 رقم الحجز: {instance.id}\n"
                        f"تم تأكيد حجزك. نتطلع للترحيب بك في موعد الإقامة! 🏨"
                    )
                )

        except ObjectDoesNotExist:
            instance._pre_save_instance = None
    else:
        instance._pre_save_instance = None



@receiver(post_save, sender=Booking)
def create_booking_history_on_change(sender, instance, created, **kwargs):
    """
    Log changes to Booking in BookingHistory without modifying availability.
    """
    if instance.parent_booking is not None:
        return

    pre = getattr(instance, '_pre_save_instance', None)
    if not pre:
        return

    if (
        pre.status != instance.status or
        pre.amount != instance.amount or
        pre.rooms_booked != instance.rooms_booked or
        pre.room_id != instance.room_id or
        pre.actual_check_out_date != instance.actual_check_out_date
    ):
        BookingHistory.objects.create(
            booking=instance,
            changed_by=instance.user,
            previous_status=pre.status,
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
