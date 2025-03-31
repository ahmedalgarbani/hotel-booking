from django.urls import path
from . import views

app_name = 'services'
urlpatterns = [
    path('apply-coupon/', views.apply_coupon, name='apply_coupon'),

    # path('services/', views.service_list, name='service_list'),
    # path('services/<int:service_id>/', views.service_detail, name='service_detail'),
    # path('services/create/', views.service_create, name='service_create'),
    # path('services/<int:service_id>/update/', views.service_update, name='service_update'),
    # path('services/<int:service_id>/delete/', views.service_delete, name='service_delete'),
]
