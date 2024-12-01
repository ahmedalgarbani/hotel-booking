# urls.py
from django.urls import path
from .views import register,login_view,logOut,request_hotel_account,activity_log_view

urlpatterns = [
    path('register/', register, name='register'),
    path('login/', login_view, name='login'),
    path('logout/', logOut, name='logout'),
    path('request_hotel_account/', request_hotel_account, name='request_hotel_account'),
    path('activity_log/', activity_log_view, name='activity_log'),
   
    
]