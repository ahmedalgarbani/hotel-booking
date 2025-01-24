from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, authenticate
from django.contrib import messages
from .models import CustomUser

def register(request):
    if request.method == 'POST':
        # Get form data
        username = request.POST.get('username')
        email = request.POST.get('email')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')
        
        # Basic validation
        if not all([username, email, password1, password2]):
            messages.error(request, 'جميع الحقول مطلوبة')
            return redirect('register')
        
        # Check if passwords match
        if password1 != password2:
            messages.error(request, 'كلمات المرور غير متطابقة')
            return redirect('register')
            
        # Check if user already exists
        if CustomUser.objects.filter(username=username).exists():
            messages.error(request, 'اسم المستخدم موجود بالفعل')
            return redirect('register')
            
        if CustomUser.objects.filter(email=email).exists():
            messages.error(request, 'البريد الإلكتروني موجود بالفعل')
            return redirect('register')
            
        # Create new user
        try:
            user = CustomUser.objects.create_user(
                username=username,
                email=email,
                password=password1,
                user_type='user'
            )
            
            # Log the user in
            login(request, user)
            messages.success(request, 'تم التسجيل بنجاح!')
            return redirect('home:index')
        except Exception as e:
            messages.error(request, 'حدث خطأ أثناء إنشاء الحساب. يرجى المحاولة مرة أخرى.')
            return redirect('register')
        
    return render(request, 'frontend/layout/master.html')

def logout_view(request):
    logout(request)
    messages.success(request, 'تم تسجيل الخروج بنجاح')
    return redirect('home:index')

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        remember = request.POST.get('remember')
        
        if not username or not password:
            messages.error(request, 'يرجى إدخال اسم المستخدم وكلمة المرور')
            return redirect('home:index')
            
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            login(request, user)
            
            if not remember:
                request.session.set_expiry(0)
                
            messages.success(request, 'تم تسجيل الدخول بنجاح!')
            return redirect('home:index')
        else:
            messages.error(request, 'اسم المستخدم أو كلمة المرور غير صحيحة')
            return redirect('home:index')
            
    return redirect('home:index')

def password_reset_view(request):
    messages.info(request, 'سيتم تنفيذ هذه الميزة قريباً')
    return redirect('home:index')