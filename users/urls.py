# urls.py
from django.urls import path
from . import views
app_name='users'
urlpatterns = [
    path('register/', views.register, name='register'),
    path('logout/', views.logout_view, name='logout'),
    path('login/', views.login_view, name='login'),
    path('password-reset/', views.password_reset_view, name='password_reset'),
]