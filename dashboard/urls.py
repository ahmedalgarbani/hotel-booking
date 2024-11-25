# urls.py
from django.urls import path
from .views import dashpord

urlpatterns = [
    
    path('index/', dashpord, name='index'),
]