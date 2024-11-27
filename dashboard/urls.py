# urls.py
from django.urls import path
from .views import dashpord,mananghotel,approve_hotel_account,details_hotel_account


urlpatterns = [
    # path('details-request/<int:id>/', details_hotel_account, name='details_hotel_account'),
    # path('approve-request/<int:id>/', approve_hotel_account, name='approve_hotel_account'),
    # path('reject-request/<int:id>/', approve_hotel_account, name='reject_hotel_account'),
    
    path('', dashpord, name='index'),
    # path('mananghotel/', mananghotel, name='mananghotel'),
    # path('mananghotel/', mananghotel, name='mananghotel'),
    
]