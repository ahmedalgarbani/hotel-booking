from . import views
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

app_name = 'HotelManagement'


urlpatterns = [
    # طلبات إضافة الفنادق
    path('add/', views.add_hotel_request, name='add_request'),
    path('hotel_search',views.hotel_search,name='hotel_search'),

    # path('requests/', views.hotel_requests_list, name='requests_list'),
    # path('requests/<int:request_id>/approve/', views.approve_hotel_request, name='approve_request'),
    # path('requests/<int:request_id>/reject/', views.reject_hotel_request, name='reject_request'),
    # path('test/email/', views_test.test_email, name='test_email'),
    # مسار تهيئة النظام
]


if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)