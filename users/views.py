import random
from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, authenticate
from django.contrib import messages
from .models import CustomUser
from datetime import datetime, timedelta
from accounts.services_util import *
from django.http import JsonResponse
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import get_user_model
from django.core.mail import send_mail
from django.template.loader import render_to_string

from django.contrib.auth.hashers import make_password # مهم
from .utils import send_sms_via_sadeem # استيراد دالة الـ SMS
from django.core.validators import RegexValidator, ValidationError # استيراد للتحقق من الهاتف
import logging
from accounts.models import ChartOfAccounts
from accounts.services_util import create_chart_of_account
from django.utils.translation import gettext_lazy as _

logger = logging.getLogger(__name__)

def generate_otp_code():
    return str(random.randint(100000, 999999))

# مدقق الهاتف
phone_regex = RegexValidator(
    regex=r'^\+?\d{9,15}$',
    message=_("رقم الهاتف يجب أن يكون بالصيغة الدولية الصحيحة، مثلاً +967...")
)


def register(request):
    if request.method == 'POST':
        # --- 1. الحصول على البيانات ---
        birth_date = request.POST.get('birth_date')
        username = request.POST.get('username', '').strip()
        email = request.POST.get('email', '').strip()
        password1 = request.POST.get('password') # كلمة المرور الصريحة
        password2 = request.POST.get('password2')
        phoneNumber = request.POST.get('phoneNumber', '').strip() # اسم المتغير من طلبك
        firstName = request.POST.get('firstName', '').strip()
        lastName = request.POST.get('lastName', '').strip()
        gender = request.POST.get('gender')
        profileImage = request.FILES.get("profileImage") # سيتم التعامل معه لاحقاً

        # --- 2. التحقق من صحة البيانات ---

        # التحقق من العمر أولاً
        birth_date_obj = None
        if birth_date:
            try:
                birth_date_obj = datetime.strptime(birth_date, '%Y-%m-%d').date()
                today = datetime.today().date()
                # استخدام .date() للمقارنة الصحيحة
                if birth_date_obj > today - timedelta(days=18*365.25): # حساب تقريبي لعمر 18
                    messages.error(request, 'يجب أن تكون أكبر من 18 عامًا.')
                    # إعادة عرض النموذج مع البيانات المدخلة
                    return render(request, 'frontend/auth/register.html', request.POST)
            except ValueError:
                messages.error(request, 'تنسيق تاريخ الميلاد غير صحيح.')
                return render(request, 'frontend/auth/register.html', request.POST)
        else:
            messages.error(request, 'تاريخ الميلاد مطلوب.')
            return render(request, 'frontend/auth/register.html', request.POST)

        # التحقق من الحقول المطلوبة الأخرى
        if not all([username, email, password1, password2, phoneNumber, firstName, lastName]):
            messages.error(request, 'جميع الحقول (باستثناء الصورة) مطلوبة.')
            return render(request, 'frontend/auth/register.html', request.POST)

        # التحقق من تطابق كلمة المرور
        if password1 != password2:
            messages.error(request, 'كلمات المرور غير متطابقة')
            return render(request, 'frontend/auth/register.html', request.POST)

        # التحقق من تفرد اسم المستخدم والبريد الإلكتروني والهاتف
        if CustomUser.objects.filter(username=username).exists():
            messages.error(request, 'اسم المستخدم موجود بالفعل')
            return render(request, 'frontend/auth/register.html', request.POST)
        if CustomUser.objects.filter(email=email).exists():
            messages.error(request, 'البريد الإلكتروني موجود بالفعل')
            return render(request, 'frontend/auth/register.html', request.POST)
        if CustomUser.objects.filter(phone=phoneNumber).exists():
             messages.error(request, 'رقم الهاتف موجود بالفعل')
             return render(request, 'frontend/auth/register.html', request.POST)

        # التحقق من صحة صيغة الهاتف
        try:
            phone_regex(phoneNumber)
        except ValidationError as e:
            messages.error(request, e.message)
            return render(request, 'frontend/auth/register.html', request.POST)

        # --- إذا مرت جميع عمليات التحقق ---

        # --- 3. إنشاء وإرسال OTP ---
        otp_code = generate_otp_code()
        otp_creation_time = timezone.now()
        message_body = f"رمز التحقق الخاص بك لتسجيل حساب ديار هو: {otp_code}"

        sms_sent = send_sms_via_sadeem(phoneNumber, message_body)

        if not sms_sent:
            messages.error(request, 'حدث خطأ أثناء إرسال رمز التحقق عبر SMS. يرجى المحاولة مرة أخرى أو التأكد من رقم الهاتف.')
            return render(request, 'frontend/auth/register.html', request.POST)

        # --- 4. تخزين البيانات مؤقتًا في الجلسة (Session) ---
        hashed_password = make_password(password1) # تشفير كلمة المرور قبل التخزين

        request.session['registration_data'] = {
            'username': username,
            'email': email,
            'hashed_password': hashed_password, # تخزين النسخة المشفرة
            'phone': phoneNumber, # استخدام اسم المتغير phoneNumber
            'first_name': firstName, # استخدام اسم المتغير firstName
            'last_name': lastName, # استخدام اسم المتغير lastName
            'gender': gender,
            'birth_date': birth_date, # تخزين النص الأصلي لتاريخ الميلاد
            # ملاحظة: لا نخزن الصورة profileImage في الجلسة مباشرة
        }
        request.session['otp_details'] = {
            'code': otp_code,
            'created_at': otp_creation_time.isoformat(), # تخزين كتنسيق نصي
            'phone': phoneNumber # تخزين الهاتف للعرض في صفحة التحقق
        }

        # --- (اختياري) التعامل مع الصورة المؤقتة إذا أردت ---
        # if profileImage:
        #     # ... (منطق حفظ الصورة مؤقتًا وتخزين مسارها في الجلسة) ...
        #     # request.session['temp_image_path'] = ...
        #     pass

        messages.info(request, f"تم إرسال رمز التحقق إلى رقم هاتفك {phoneNumber}. يرجى إدخاله أدناه.")
        return redirect('users:verify_otp') # التوجيه لصفحة التحقق

    # إذا كان الطلب GET، اعرض النموذج فارغًا
    return render(request, 'frontend/auth/register.html')


def logout_view(request):
    logout(request)
    messages.success(request, 'تم تسجيل الخروج بنجاح')
    return redirect('home:index')


def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        password = request.POST.get('password', '').strip()
        remember = request.POST.get('remember')
        next_url = request.POST.get('next')

        if not username or not password:
            messages.error(request, 'يرجى إدخال اسم المستخدم وكلمة المرور')
            return redirect('home:index')

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            
            if remember:
                request.session.set_expiry(1209600) 
            else:
                request.session.set_expiry(0) 
            
            if next_url:
                return redirect(next_url)
            messages.success(request, 'تم تسجيل الدخول بنجاح!')
            return redirect('home:index')
        else:
            messages.error(request, 'اسم المستخدم أو كلمة المرور غير صحيحة')
            return redirect('users:login')
    else:
        next_url = request.GET.get('next', '')
  
        return render(request, 'frontend/auth/login.html', {'next': next_url})



import random

User = get_user_model()

def generate_otp_code():
    return str(random.randint(100000, 999999))

def send_otp_email(email, otp_code, user):
    
    subject = 'OTP Code for Password Reset'
    from_email = 'ammarragha@gmail.com'
    recipient_list = [email]
    html_message = render_to_string('emails/otp_code.html', {'otp_code': otp_code, 'user': user})
    plain_message = f'Your OTP code is: {otp_code}'

    send_mail(subject, plain_message, from_email, recipient_list, html_message=html_message)

def forgot_password(request):
    return render(request, 'frontend/auth/reset_password.html')

@csrf_exempt
def send_otp(request):
    if request.method == 'POST':
   
        email = request.POST.get('email')
        if not email:
            return JsonResponse({'error': 'Email is required'}, status=400)
        try:
            user = User.objects.get(email=email)
            otp_code = generate_otp_code()
            user.otp_code = otp_code
            user.otp_created_at = timezone.now()
            user.save(update_fields=['otp_code', 'otp_created_at'])
            send_otp_email(email, otp_code, user)
            return JsonResponse({'message': 'OTP sent'})
        except User.DoesNotExist:
            return JsonResponse({'error': 'User not found'}, status=404)
    return JsonResponse({'error': 'Invalid request'}, status=405)

@csrf_exempt
def verify_otp(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        otp_code = request.POST.get('otp_code')
        if not email or not otp_code:
            return JsonResponse({'error': 'Missing parameters'}, status=400)
        try:
            user = User.objects.get(email=email)
            if user.otp_code == otp_code:
                return JsonResponse({'message': 'OTP valid'})
            else:
                return JsonResponse({'error': 'Invalid OTP'}, status=400)
        except User.DoesNotExist:
            return JsonResponse({'error': 'هذا الايميل غير موجود'}, status=404)
    return JsonResponse({'error': 'Invalid request'}, status=405)

@csrf_exempt
def reset_password(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        otp_code = request.POST.get('otp_code')
        new_password = request.POST.get('new_password')

        if not email or not otp_code or not new_password:
            return JsonResponse({'error': 'Missing parameters'}, status=400)

        try:
            user = User.objects.get(email=email)
            if user.otp_code == otp_code:
                user.set_password(new_password)
                user.otp_code = None
                user.otp_created_at = None
                user.save(update_fields=['password', 'otp_code', 'otp_created_at'])
                return JsonResponse({'message': 'Password reset successful'})
            else:
                return JsonResponse({'error': 'Invalid OTP'}, status=400)
        except User.DoesNotExist:
            return JsonResponse({'error': 'User not found'}, status=404)
    return JsonResponse({'error': 'Invalid request'}, status=405)


def verify_otp(request):
    otp_details = request.session.get('otp_details')
    registration_data = request.session.get('registration_data')

    if not otp_details or not registration_data:
        messages.error(request, "جلسة التسجيل غير صالحة.")
        return redirect('users:register')

    phone_for_display = otp_details.get('phone', 'رقمك')

    if request.method == 'POST':
        entered_otp = request.POST.get('otp_code', '').strip()

        if not entered_otp:
            messages.error(request, "يرجى إدخال رمز التحقق.")
            return render(request, 'frontend/auth/verify_otp.html', {'phone_number': phone_for_display})

        stored_otp = otp_details.get('code')
        creation_time_str = otp_details.get('created_at')

        if not stored_otp or not creation_time_str:
             messages.error(request, "خطأ في بيانات التحقق.")
             return redirect('users:register')

        # --- التحقق من OTP ---
        if entered_otp != stored_otp:
            messages.error(request, "رمز التحقق غير صحيح.")
            return render(request, 'frontend/auth/verify_otp.html', {'phone_number': phone_for_display})

        # --- التحقق من انتهاء الصلاحية ---
        creation_time = datetime.fromisoformat(creation_time_str)
        if timezone.now() > creation_time + timedelta(minutes=5): # مدة 5 دقائق
             messages.error(request, "انتهت صلاحية رمز التحقق.")
             request.session.pop('registration_data', None)
             request.session.pop('otp_details', None)
             return redirect('users:register')

        # --- OTP صالح - إنشاء المستخدم ---
        try:
            user_data = registration_data.copy()
            hashed_password = user_data.pop('hashed_password')

            # --- إنشاء حساب مالي ---
            try:
                parent_account = ChartOfAccounts.objects.get(account_number="1100")
            except ChartOfAccounts.DoesNotExist:
                logger.error("Parent chart of account '1100' does not exist.")
                messages.error(request, "خطأ في إعداد الحسابات المالية.")
                return redirect('users:register')

            random_number = random.randint(1000, 9999)
            first = user_data.get('first_name', '')
            last = user_data.get('last_name', '')
            chart = create_chart_of_account(
                account_number=f"110{random_number}",
                account_name=f"عملاء - {first} {last}",
                account_type="Assets",
                account_balance=0,
                account_parent=parent_account,
                account_description="حساب عميل",
                account_status=True,
            )
            # --- نهاية إنشاء الحساب المالي ---

            # إنشاء المستخدم
            user = CustomUser.objects.create(
                **user_data,
                chart=chart,
                user_type='customer',
                is_active=True # تفعيل المستخدم بعد التحقق
            )
            user.password = hashed_password # تعيين كلمة المرور المشفرة
            # --- هنا يمكنك إضافة منطق التعامل مع الصورة المخزنة مؤقتًا إذا طبقت ذلك ---
            # user.image = ...
            user.save()

            # --- تنظيف الجلسة ---
            request.session.pop('registration_data', None)
            request.session.pop('otp_details', None)

            # تسجيل دخول المستخدم
            user.backend = 'django.contrib.auth.backends.ModelBackend'
            login(request, user)

            messages.success(request, f'تم التحقق وإنشاء الحساب بنجاح! مرحباً بك {user.first_name}.')
            return redirect('home:index')

        except Exception as e:
            logger.error(f"Error creating user after OTP verification: {e}")
            messages.error(request, f'حدث خطأ أثناء إنشاء الحساب: {e}.')
            request.session.pop('registration_data', None)
            request.session.pop('otp_details', None)
            return redirect('users:register')

    return render(request, 'frontend/auth/verify_otp.html', {'phone_number': phone_for_display})