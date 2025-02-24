from django.urls import path,include
from . import views


app_name = 'home'

urlpatterns = [
    path('',views.index,name='index'),
    path('about',views.about,name='about'),
    path('hotels',views.hotels,name='hotels'),
    path('hotel/<slug:slug>/', views.hotel_detail, name='hotel_detail'),
    # Rooms
    path('room-search-result', views.room_search_result, name='room-search-result'),
    path('rooms', views.room_list, name='room_list'),
    
    ]
