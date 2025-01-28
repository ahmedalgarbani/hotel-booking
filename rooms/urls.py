
from django.urls import path
from . import views
app_name = 'rooms'


urlpatterns = [
   path('room_search',views.room_search,name='room_search'),
   path('room_detail/<int:room_id>/', views.room_detail, name='room_detail'),

]