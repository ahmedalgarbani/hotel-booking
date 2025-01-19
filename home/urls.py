from django.urls import path,include
from . import views


app_name = 'home'

urlpatterns = [
    path('',views.index,name='index'),
    path('about',views.about,name='about'),
    path('hotels',views.hotels,name='hotels'),
    path('hotel/<slug:slug>/', views.hotel_detail, name='hotel_detail'),
    
    ]
