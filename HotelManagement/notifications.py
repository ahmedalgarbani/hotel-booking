from django.conf import settings
from django.core.mail import send_mail
from django.template.loader import render_to_string
from django.utils.translation import gettext as _
from django.utils.text import slugify
import logging

logger = logging.getLogger(__name__)  

class Notification:
    @staticmethod
    def send_hotel_manager_credentials(user, hotel_name, password):
        """
        إرسال بريد إلكتروني بمعلومات تسجيل الدخول لمدير الفندق
        """
        subject = _('معلومات تسجيل الدخول لنظام إدارة الفندق')
        context = {
            'user': user,
            'hotel_name': hotel_name,
            'username': user.username,
            'password': password,
            'login_url': settings.LOGIN_URL
        }
        
        # Generate slug for the hotel name
        hotel_slug = slugify(hotel_name)
        print(f"تم إنشاء slug للفندق: {hotel_slug}")

        # إرسال البريد الإلكتروني
        html_message = render_to_string('emails/hotel_manager_credentials.html', context)
        plain_message = f"""مرحباً {user.get_full_name()},

تم قبول طلبك لإدارة فندق {hotel_name}. يمكنك تسجيل الدخول باستخدام المعلومات التالية:

اسم المستخدم: {user.username}
كلمة المرور: {password}

يرجى تغيير كلمة المرور بعد تسجيل الدخول لأول مرة.

مع تحيات،
فريق إدارة الفنادق"""

        try:
            # التحقق من إعدادات البريد الإلكتروني
            if not settings.EMAIL_HOST or not settings.EMAIL_PORT:
                print("خطأ في الإعدادات: لم يتم تكوين خادم البريد الإلكتروني")
                return False

            if not settings.DEFAULT_FROM_EMAIL:
                print("خطأ في الإعدادات: لم يتم تحديد عنوان المرسل")
                return False

            if not user.email:
                print(f"خطأ: لا يوجد بريد إلكتروني للمستخدم {user.username}")
                return False

            # محاولة إرسال البريد الإلكتروني
            send_mail(
                subject=subject,
                message=plain_message,
                from_email=settings.EMAIL_HOST_USER,  # استخدام EMAIL_HOST_USER كمرسل
                recipient_list=[user.email],
                html_message=html_message,
                fail_silently=False
            )
            print(f"تم إرسال البريد الإلكتروني بنجاح إلى {user.email}")
            return True
        except Exception as e:
            print(f"""
خطأ في إرسال البريد الإلكتروني:
- نوع الخطأ: {type(e).__name__}
- رسالة الخطأ: {str(e)}
- المستخدم: {user.username}
- البريد الإلكتروني: {user.email}
- إعدادات البريد:
  * EMAIL_HOST: {getattr(settings, 'EMAIL_HOST', 'غير محدد')}
  * EMAIL_PORT: {getattr(settings, 'EMAIL_PORT', 'غير محدد')}
  * DEFAULT_FROM_EMAIL: {getattr(settings, 'DEFAULT_FROM_EMAIL', 'غير محدد')}
""")
            return False



    @staticmethod
    def send_end_booking_notification(user, hotel_name, check_out_date):

        """
        إرسال بريد إلكتروني لإعلام المستخدم بنهاية الحجز
        """
        subject = _('إشعار بنهاية الحجز في فندق {hotel_name}'.format(hotel_name=hotel_name))
        context = {
            'user': user,
            'hotel_name': hotel_name,
            'check_out_date': check_out_date,
        }

        # Constructing the HTML and plain text email body
        html_message = render_to_string('emails/hotel_end_booking.html', context)
        plain_message = f"""مرحباً {user.get_full_name()},

نود إعلامك بأن حجزك في فندق {hotel_name} سينتهي في {check_out_date.strftime('%Y-%m-%d %H:%M:%S')}.

نأمل منك إنهاء إجراءات الخروج في الوقت المحدد.

مع تحيات،
فريق إدارة الفنادق"""

        try:
            # Verify email settings
            if not settings.EMAIL_HOST or not settings.EMAIL_PORT:
                logger.error("خطأ في الإعدادات: لم يتم تكوين خادم البريد الإلكتروني")
                return False

            if not settings.DEFAULT_FROM_EMAIL:
                logger.error("خطأ في الإعدادات: لم يتم تحديد عنوان المرسل")
                return False

            if not user.email:
                logger.error(f"خطأ: لا يوجد بريد إلكتروني للمستخدم {user.username}")
                return False

            # Try sending the email
            send_mail(
                subject=subject,
                message=plain_message,
                from_email=settings.EMAIL_HOST_USER,  # استخدام EMAIL_HOST_USER كمرسل
                recipient_list=[user.email],
                html_message=html_message,
                fail_silently=False
            )
            logger.info(f"تم إرسال البريد الإلكتروني بنجاح إلى {user.email}")
            return True
        except Exception as e:
            logger.error(f"خطأ في إرسال البريد الإلكتروني:\n- نوع الخطأ: {type(e).__name__}\n- رسالة الخطأ: {str(e)}\n- المستخدم: {user.username}\n- البريد الإلكتروني: {user.email}")
            return False
