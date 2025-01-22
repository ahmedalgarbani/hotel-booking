from django.conf import settings
from django.core.mail import send_mail
from django.template.loader import render_to_string
from django.utils.translation import gettext as _

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
            send_mail(
                subject=subject,
                message=plain_message,
                from_email=settings.DEFAULT_FROM_EMAIL,
                recipient_list=[user.email],
                html_message=html_message,
                fail_silently=False
            )
            return True
        except Exception as e:
            # يمكنك إضافة تسجيل الأخطاء هنا
            print(f"Error sending email: {str(e)}")
            return False
