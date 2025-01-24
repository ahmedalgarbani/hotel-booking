from django.urls import path
from . import views

urlpatterns = [
    # سيتم إضافة المسارات هنا لاحقاً
    path('', views.booking_list, name='booking_list'),
]