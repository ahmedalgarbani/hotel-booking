import random
from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, authenticate
from django.contrib import messages
from .models import CustomUser
from datetime import datetime, timedelta
from accounts.services import *
from django.http import JsonResponse
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import get_user_model
from django.core.mail import send_mail
from django.template.loader import render_to_string

def register(request):
    if request.method == 'POST':
        birth_date = request.POST.get('birth_date')

        try:
            birth_date_obj = datetime.strptime(birth_date, '%Y-%m-%d')
            today = datetime.today()
            min_birth_date = today - timedelta(days=18*365)

            if birth_date_obj > min_birth_date:
                messages.error(request, 'يجب أن تكون أكبر من 18 عامًا.')
                return redirect('users:register')
        except ValueError:
            messages.error(request, 'تاريخ الميلاد غير صحيح.')
            return redirect('users:register')

        username = request.POST.get('username')
        email = request.POST.get('email')
        password1 = request.POST.get('password')
        password2 = request.POST.get('password2')
        phoneNumber = request.POST.get('phoneNumber')
        firstName = request.POST.get('firstName')
        lastName = request.POST.get('lastName')
        gender = request.POST.get('gender')
        profileImage = request.FILES.get("profileImage")

        if not all([username, email, password1, password2]):
            messages.error(request, 'جميع الحقول مطلوبة')
            return redirect('users:register')

        if password1 != password2:
            messages.error(request, 'كلمات المرور غير متطابقة')
            return redirect('users:register')

        if CustomUser.objects.filter(username=username).exists():
            messages.error(request, 'اسم المستخدم موجود بالفعل')
            return redirect('users:register')

        if CustomUser.objects.filter(email=email).exists():
            messages.error(request, 'البريد الإلكتروني موجود بالفعل')
            return redirect('users:register')

        try:
            random_number = random.randint(1000, 9999)
            chart = create_chart_of_account(
                account_number=f"110{random_number}",
                account_name=f"عملاء دائمون - {firstName} {lastName}",
                account_type="Assets",
                account_balance=0,
                account_parent=ChartOfAccounts.objects.get(account_number="1100"),
                account_description="الحسابات المدينة / العملاء",
                account_status=True,
            )
            user = CustomUser.objects.create_user(
                username=username,
                email=email,
                password=password1,
                user_type='customer',
                phone=phoneNumber,
                first_name=firstName,
                last_name=lastName,
                image=profileImage,
                chart=chart,
                gender=gender,
                birth_date=birth_date
            )

            
            user.backend = 'django.contrib.auth.backends.ModelBackend'
            
            login(request, user)
            messages.success(request, 'تم التسجيل بنجاح!')
            return redirect('home:index')

        except Exception as e:
            print(e)
            messages.error(request, 'حدث خطأ أثناء إنشاء الحساب. يرجى المحاولة مرة أخرى.')
            return redirect('users:register')
        
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