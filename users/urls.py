# urls.py
from django.urls import path
from .views import register,login_view,dashpord

urlpatterns = [
    path('register/', register, name='register'),
    path('login/', login_view, name='login'),
    path('index/', dashpord, name='index'),
]