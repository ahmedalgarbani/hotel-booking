from django.urls import path
from . import views


app_name = 'bookings'

urlpatterns = [
    # سيتم إضافة المسارات هنا لاحقاً
    path('', views.booking_list, name='booking_list'),
    path('acutal_checkout/<int:booking_id>/', views.set_actual_check_out_date, name='set_actual_check_out_date'),
    path('guests_check_out_date/<int:guest_id>/', views.set_guests_check_out_date, name='set_guests_check_out_date'),
    # path('admin/<int:booking_id>/payment/', views.payment_view, name='booking-payment'),
    path('admin/<int:booking_id>/<int:extension_id>/payment-extend/', views.booking_extend_payment, name='booking_extend_payment'),
   
]