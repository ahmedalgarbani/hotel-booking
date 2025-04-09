from celery import shared_task
from django.utils import timezone
from datetime import timedelta
from django.contrib.auth import get_user_model
from HotelManagement.notifications import Notification
from notifications.models import Notifications
import logging

User = get_user_model()
logger = logging.getLogger(__name__)




@shared_task
def send_booking_end_reminders(booking_id):
    """
    Send a reminder for a specific booking ending within the next 5 hours.
    """
    from .models import Booking
    from django.utils import timezone
    from datetime import timedelta

    try:
        booking = Booking.objects.select_related('user', 'room__hotel').get(id=booking_id)

        now = timezone.now()

        if booking.status == Booking.BookingStatus.CONFIRMED and booking.check_out_date > now:
            Notifications.objects.create(
                sender=booking.room.hotel.manager,  
                user=booking.user,  
                recipient_type="single_user", 
                title="تذكير بانتهاء الحجز",
                message=f"سينتهي حجزك في الغرفة {booking.room} في تمام الساعة {booking.check_out_date}. هل تريد التمديد؟",
                notification_type="0",  
                is_active=True,
                action_url="/",  
            )

            send_reminder_email.delay(booking.id)

            booking.reminder_sent = True
            booking.save()

            logger.info(f"Reminder sent for Booking #{booking.id}")
            return f"Reminder sent for Booking #{booking.id}"

        else:
            logger.info(f"No reminder needed for Booking #{booking.id}")
            return f"No reminder needed for Booking #{booking.id}"

    except Booking.DoesNotExist:
        logger.error(f"Booking with ID {booking_id} does not exist.")
        return f"Booking with ID {booking_id} does not exist."
    except Exception as e:
        logger.error(f"Error in send_booking_end_reminders: {e}")
        raise

@shared_task(bind=True, autoretry_for=(Exception,), retry_kwargs={'max_retries': 3})
def send_reminder_email(self, booking_id):
    """
    Send email reminder for a specific booking with retry logic
    """
    try:
        from .models import Booking

        booking = Booking.objects.select_related('user', 'room__hotel').get(id=booking_id)
        user = booking.user
        
        email_sent = Notification.send_end_booking_notification(
            user=user,
            hotel_name=booking.room.hotel.name,  
            check_out_date=booking.check_out_date.astimezone()
        )

        if email_sent:
            logger.info(f"تم إرسال البريد الإلكتروني بنجاح إلى {user.email}")
        else:
            logger.warning(f"فشل في إرسال البريد الإلكتروني إلى {user.email}")
            raise Exception("Email sending failed")
        logger.info("Task executed successfully")

    except Booking.DoesNotExist:
        logger.error(f"الحجز ذو المعرف {booking_id} غير موجود")
    except User.DoesNotExist:
        logger.error(f"المستخدم ذو المعرف {user.id} غير موجود")
    except Exception as e:
        logger.error(f"خطأ غير متوقع أثناء إرسال التذكير بالبريد الإلكتروني: {e}")
        raise self.retry(exc=e)