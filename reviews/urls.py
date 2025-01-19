from . import views
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

app_name = 'reviews'

urlpatterns = [
    # Hotel Review URLs
    path('hotel-reviews/', views.hotel_review_list, name='hotel_review_list'),
    path('hotel-reviews/<int:review_id>/', views.hotel_review_detail, name='hotel_review_detail'),
    path('hotel-reviews/create/', views.hotel_review_create, name='hotel_review_create'),
    path('hotel-reviews/<int:review_id>/update/', views.hotel_review_update, name='hotel_review_update'),
    path('hotel-reviews/<int:review_id>/delete/', views.hotel_review_delete, name='hotel_review_delete'),

    # Room Review URLs
    path('room-reviews/', views.room_review_list, name='room_review_list'),
    path('room-reviews/<int:review_id>/', views.room_review_detail, name='room_review_detail'),
    path('room-reviews/create/', views.room_review_create, name='room_review_create'),
    path('room-reviews/<int:review_id>/update/', views.room_review_update, name='room_review_update'),
    path('room-reviews/<int:review_id>/delete/', views.room_review_delete, name='room_review_delete'),
]



if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
