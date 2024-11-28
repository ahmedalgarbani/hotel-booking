# urls.py
from django.urls import path
from .views import dashpord,mananghotel,approve_hotel_account,details_hotel_account, edit_hotel_account_request,delete_hotel_account_request


urlpatterns = [
    
    path('edit_hotel_account_request/<int:id>/', edit_hotel_account_request, name='edit_hotel_account_request'),
    path('delet_hotel_account_request/<int:id_request>/', delete_hotel_account_request, name='delet_hotel_account_request'),

    path('details-request/<int:id>/', details_hotel_account, name='details_hotel_account'),
    path('approve-request/<int:id>/', approve_hotel_account, name='approve_hotel_account'),
    path('reject-request/<int:id>/', approve_hotel_account, name='reject_hotel_account'),
    
    path('', dashpord, name='index'),
    path('mananghotel/', mananghotel, name='mananghotel'),
    path('mananghotel/', mananghotel, name='mananghotel'),
   
]