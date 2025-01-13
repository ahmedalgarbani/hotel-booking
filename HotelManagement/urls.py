from . import views
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

app_name = 'HotelManagement'


urlpatterns = [
    # ------------- hotels ------------------------  
    path('', views.index, name='hotel_list'),
    path('hotels/<int:hotel_slug>/', views.hotel_detail, name='hotel_detail'),
    path('hotels/create/', views.hotel_create, name='hotel_create'),    
    path('hotels/update/', views.hotel_update, name='hotel_update'),
    path('hotels/delete/', views.hotel_delete, name='hotel_delete'),
    # ------------- locations ------------------------ 
    path('locations/', views.location_list, name='location_list'),
    path('locations/<int:location_id>/', views.location_detail, name='location_detail'),
    path('locations/create/', views.location_create, name='location_create'),
    path('locations/<int:location_id>/update/', views.location_update, name='location_update'),
    path('locations/<int:location_id>/delete/', views.location_delete, name='location_delete'),

    # ------------- phones ------------------------  
    path('phones/', views.phone_list, name='phone_list'),
    path('phones/<int:phones_id>/', views.phone_detail, name='phone_detail'),
    path('phones/create/', views.phone_create, name='phone_create'),
    path('phones/<int:phones_id>/update/', views.phone_update, name='phone_update'),
    path('phones/<int:phones_id>/delete/', views.phone_delete, name='phone_delete'),

    # ------------- Image ------------------------  
    path('images/', views.image_list, name='image_list'),
    path('images/<int:image_id>/', views.image_detail, name='image_detail'),
    path('images/create/', views.image_create, name='image_create'),
    path('images/<int:image_id>/update/', views.image_update, name='image_update'),
    path('images/<int:image_id>/delete/', views.image_delete, name='image_delete'),

    # ------------- city ------------------------
    path('cities/', views.city_list, name='city_list'),
    path('cities/<int:city_id>/', views.city_detail, name='city_detail'),
    path('cities/create/', views.city_create, name='city_create'),
    path('cities/<int:city_id>/update/', views.city_update, name='city_update'),
    path('cities/<int:city_id>/delete/', views.city_delete, name='city_delete'),
]


if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
