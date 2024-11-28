# urls.py
from django.urls import path
from .views import dashpord,Hotel_Account_Request_list,approve_Hotel_Account_Request,create_hotel_account_request,details_hotel_account, edit_hotel_account_request,delete_hotel_account_request


urlpatterns = [
    
    path('edit_hotel_account_request/<int:id>/', edit_hotel_account_request, name='edit_hotel_account_request'),
    path('delet_hotel_account_request/<int:id_request>/', delete_hotel_account_request, name='delet_hotel_account_request'),

    path('details-request/<int:id>/', details_hotel_account, name='details_hotel_account'),
    path('approve-request/<int:id>/', approve_Hotel_Account_Request, name='approve_hotel_account'),
    path('create_hotel_account_request/', create_hotel_account_request, name='create_hotel_account_request'),
    path('', dashpord, name='index'),
    path('mananghotel/', Hotel_Account_Request_list, name='mananghotel'),
   
   
]