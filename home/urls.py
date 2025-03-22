from django.urls import path,include
from . import views


app_name = 'home'

urlpatterns = [
    path('',views.index,name='index'),
    path('about/',views.about,name='about'),
    path('price/',views.price,name='price'),
    path('contact/',views.contact,name='contact'),
    path('service/',views.service,name='service'),
    path('hotels',views.hotels,name='hotels'),
    path('hotel/<slug:slug>/', views.hotel_detail, name='hotel_detail'),
    # Rooms
    path('contact/thank-you/', views.thank_you, name='thank_you'),
    path('pricing/', views.pricing, name='pricing'),
    path('room-search-result', views.room_search_result, name='room-search-result'),
    path('rooms', views.room_list, name='room_list'),
    
    ]
