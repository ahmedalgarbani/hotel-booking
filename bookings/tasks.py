from celery import shared_task
from django.utils import timezone
from datetime import timedelta
from django.contrib.auth import get_user_model
from HotelManagement.notifications import Notification
from .models import Booking
from notifications.models import Notifications
import logging

User = get_user_model()
logger = logging.getLogger(__name__)

@shared_task
def send_booking_end_reminders():
    """
    Send reminders for bookings ending within the next 5 hours.
    Creates in-app notifications and triggers email reminders.
    """
    try:
        now = timezone.now()
        target_time = now + timedelta(hours=5)
        
        bookings = Booking.objects.filter(
            check_out_date__lte=target_time,
            check_out_date__gt=now,
            status=Booking.BookingStatus.CONFIRMED,
            # reminder_sent=False  
        ).select_related('user', 'room__hotel')

        for booking in bookings:
            Notifications.objects.create(
                user=booking.user,
                title="تذكير بانتهاء الحجز",
                message=f"سينتهي حجزك في الغرفة {booking.room} في تمام الساعة {booking.check_out_date.astimezone(booking.user.timezone).strftime('%Y-%m-%d %H:%M')}. هل تريد التمديد؟",
                notification_type="reminder"
            )

            send_reminder_email.delay(booking.id)

            booking.reminder_sent = True
            booking.save()
        logger.info("Task executed successfully")
        return f"تم إرسال {bookings.count()} إشعاراً وإيميلات للمستخدمين حول انتهاء حجوزاتهم."

    except Exception as e:
        logger.error(f"Error in send_booking_end_reminders: {e}")
        logger.error(f"Task failed: {e}")
        raise

@shared_task(bind=True, autoretry_for=(Exception,), retry_kwargs={'max_retries': 3})
def send_reminder_email(self, booking_id):
    """
    Send email reminder for a specific booking with retry logic
    """
    try:
        booking = Booking.objects.select_related('user', 'room__hotel').get(id=booking_id)
        user = booking.user
        
        email_sent = Notification.send_end_booking_notification(
            user=user,
            hotel_name=booking.room.hotel.name,  
            check_out_time=booking.check_out_date.astimezone(user.timezone)
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