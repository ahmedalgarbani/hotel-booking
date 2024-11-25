from django.urls import path
from .views import rooms,rooms_types,rooms_prices,rooms_availability

urlpatterns = [
    path('',rooms, name='rooms'),
    path('rooms_types/', rooms_types, name='rooms_types'),
    path('rooms_prices/', rooms_prices, name='rooms_prices'),
    path('rooms_availability/', rooms_availability, name='rooms_availability'),
]