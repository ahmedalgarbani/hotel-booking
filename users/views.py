from django.shortcuts import render
from django.shortcuts import render, redirect
from .forms import CustomUser_CreationForm
from .models import CustomUser
from django.contrib.auth import authenticate, login
from django.contrib import messages

def register(request):
    if request.method == 'POST':
        form = CustomUser_CreationForm(request.POST)

        if form.is_valid():
            user = form.save(commit=False)
            user_type = form.cleaned_data.get('user_type')

            if user_type == "admin":
                user.is_superuser = True
                user.is_staff = True

            else:
                user.is_superuser = False
                user.is_staff = False

            user.save()

            return redirect('login')
    else:

        form = CustomUser_CreationForm()
    return render(request, 'users/register.html', {'form': form})



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

    return render(request, 'users/login.html')  # تأكد من وجود هذا القالب


def dashpord(request):
    user = request.user
    

    return render(request, 'users/index.html',{'user':user})
