# urls.py
from django.urls import path
from . import views  


urlpatterns = [
    # crud users
    path('create_user/', views.create_user, name='create_user'),
    path('list_user/', views.list_user, name='list_user'),
    path('update_user/<int:id>/', views.update_user, name='update_user'),
    path('delete_user/<int:id>/', views.delete_user, name='delete_user'),
#    end crud user
   path('edit_hotel_account_request/<int:id>/', views.edit_hotel_account_request, name='edit_hotel_account_request'),
   path('delet_hotel_account_request/<int:id_request>/', views.delete_hotel_account_request, name='delet_hotel_account_request'),

    path('detail_request/<slug:slug>/', views.details_hotel_account, name='request_detail'),

    #  رابط الموافقة علي الطلب
    path('approve-request/<int:id>/', views.approve_Hotel_Account_Request, name='approve_hotel_account'),
    path('create_hotel_account_request/', views.create_hotel_account_request, name='create_hotel_account_request'),
    path('', views.dashpord, name='index'),
    path('mananghotel/', views.Hotel_Account_Request_list, name='mananghotel'),
   
   
]