from django.shortcuts import render, redirect
from django.contrib.auth import login
from django.contrib import messages
from .models import CustomUser

def register(request):
    if request.method == 'POST':
        # Get form data
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        # Check if user already exists
        if CustomUser.objects.filter(username=username).exists():
            messages.error(request, 'Username already exists')
            return redirect('users:register')
            
        if CustomUser.objects.filter(email=email).exists():
            messages.error(request, 'Email already exists')
            return redirect('users:register')
            
        # Create new user
        user = CustomUser.objects.create_user(
            username=username,
            email=email,
            password=password
        )
        
        # Log the user in
        login(request, user)
        messages.success(request, 'Registration successful!')
        return redirect('home')
        
    return render(request, 'frontend/layout/master.html')