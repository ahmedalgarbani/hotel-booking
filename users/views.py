from django.shortcuts import render
from django.shortcuts import render, redirect
from .forms import CustomUser_CreationForm, HotelAccountRequestForm
from .models import CustomUser
from django.contrib.auth import authenticate, login,logout
from django.contrib import messages

# def register(request):
#     if request.method == 'POST':
#         form = CustomUser_CreationForm(request.POST)

#         if form.is_valid():
#             user = form.save(commit=False)
#             user_type = form.cleaned_data.get('user_type')
#             if user_type== 'hotel_manager':
#                 return redirect('login')

#             if user_type == "admin":
#                 user.is_superuser = True
#                 user.is_staff = True

#             else:
#                 user.is_superuser = False
#                 user.is_staff = False

#             user.save()

#             return redirect('login')
#     else:

#         form = CustomUser_CreationForm()
#     return render(request, 'users/register.html', {'form': form})

def register(request):
    if request.method == 'POST':
        form = CustomUser_CreationForm(request.POST)

        if form.is_valid():
            user = form.save(commit=False)
            user_type = form.cleaned_data.get('user_type')
            
            # إذا كان نوع المستخدم هو مدير فندق، ارسله إلى صفحة فتح حساب الفندق
            if user_type == 'hotel_manager':
                return redirect('request_hotel_account')  # تأكد من أن لديك URL باسم 'request_hotel_account'

            if user_type == "admin":
                user.is_superuser = True
                user.is_staff = True
            else:
                user.is_superuser = False
                user.is_staff = False

            user.save()
            return redirect('login')  # إعادة توجيه المستخدم إلى صفحة تسجيل الدخول

    else:
        form = CustomUser_CreationForm()
    
    return render(request, 'admin/auth/register.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        email = request.POST.get('email')  # استخدام البريد الإلكتروني
        password = request.POST.get('password')

        # افترض أنك تستخدم نموذج مستخدم يدعم البريد الإلكتروني كاسم مستخدم
        user = authenticate(request, username=email, password=password)

        if user is not None:
            login(request, user)
            return redirect('index')  # تغيير 'index' إلى اسم URL الخاص بك
        else:
            messages.error(request, 'البريد الإلكتروني أو كلمة المرور غير صحيحة.')

    return render(request, 'admin/auth/login.html')  # تأكد من وجود هذا القالب


def request_hotel_account(request):
    if request.method == 'POST':
        form = HotelAccountRequestForm(request.POST, request.FILES)
        if form.is_valid():
            # حفظ الطلب
            request_instance = form.save(commit=False)
            request_instance.created_user = None  # يمكنك تعيين المستخدم لاحقًا بعد الموافقة
            request_instance.status = 'pending'  # تعيين الحالة إلى "معلق"
            request_instance.save()
            return redirect('login')  # وجه المستخدم إلى صفحة النجاح
    else:
        form = HotelAccountRequestForm()
    return render(request, 'admin/auth/request_hotel_account.html', {'form': form})
def logOut(request):
    logout(request)
    return redirect('login')