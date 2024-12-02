# urls.py
from django.urls import path
from .views import dashpord,Hotel_Account_Request_list,approve_Hotel_Account_Request,create_hotel_account_request,details_hotel_account, edit_hotel_account_request,delete_hotel_account_request
from .views import rooms_types, rooms_availability, rooms_categories, rooms_prices,rooms_status,rooms_images,add_rooms_images

urlpatterns = [
    
    path('edit_hotel_account_request/<int:id>/', edit_hotel_account_request, name='edit_hotel_account_request'),
    path('delet_hotel_account_request/<int:id_request>/', delete_hotel_account_request, name='delet_hotel_account_request'),

    path('details-request/<int:id>/', details_hotel_account, name='details_hotel_account'),
    path('approve-request/<int:id>/', approve_Hotel_Account_Request, name='approve_hotel_account'),
    path('create_hotel_account_request/', create_hotel_account_request, name='create_hotel_account_request'),
    path('', dashpord, name='index'),
    path('mananghotel/', Hotel_Account_Request_list, name='mananghotel'),
  #-----------------------url rooms--------------------------# 
    path('rooms_types', rooms_types, name='rooms_types'),
    path('rooms_availability/', rooms_availability, name='rooms_availability'),
    path('rooms_categories/', rooms_categories, name='rooms_categories'),
    path('rooms_prices/', rooms_prices, name='rooms_prices'),
    path('rooms_status/', rooms_status, name='rooms_status'),
    path('rooms_images/', rooms_images, name='rooms_images'),
    path('add_imgadd_rooms_images/', add_rooms_images, name='add_rooms_images'),
   
]