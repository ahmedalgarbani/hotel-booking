
from django.urls import path
from .views import rooms_types, rooms_availability, rooms_categories, rooms_prices

urlpatterns = [
    path('', rooms_types, name='rooms_types'),
    path('rooms_availability/', rooms_availability, name='rooms_availability'),
    path('rooms_categories/', rooms_categories, name='rooms_categories'),
    path('rooms_prices/', rooms_prices, name='rooms_prices'),
]