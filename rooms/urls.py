
from django.urls import path
from . import views
app_name = 'rooms'


urlpatterns = [
   path('room_search',views.room_search,name='room_search')
]