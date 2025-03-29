from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, authenticate
from django.contrib import messages
from .models import CustomUser
from datetime import datetime, timedelta

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
            user = CustomUser.objects.create_user(
                username=username,
                email=email,
                password=password1,
                user_type='customer',
                phone=phoneNumber,
                first_name=firstName,
                last_name=lastName,
                image=profileImage,
                gender=gender,
                birth_date=birth_date
            )
            
            login(request, user)
            messages.success(request, 'تم التسجيل بنجاح!')
            return redirect('home:index')

        except Exception as e:
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

            messages.success(request, 'تم تسجيل الدخول بنجاح!')

            if next_url:
                return redirect(next_url)
            return redirect('home:index')
        else:
            messages.error(request, 'اسم المستخدم أو كلمة المرور غير صحيحة')
            return redirect('home:index')
    else:
        next_url = request.GET.get('next', '')
        return render(request, 'frontend/auth/login.html', {'next': next_url})




def password_reset_view(request):
    print("hello -----------------")
    if request.method == 'POST':

        messages.info(request, 'سيتم تنفيذ هذه الميزة قريباً')
        return redirect('home:index')