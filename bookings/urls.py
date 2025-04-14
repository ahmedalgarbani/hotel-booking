from django.urls import path
from . import views
from django.contrib.admin.views.decorators import staff_member_required
from bookings.services.reports import daily_report_view, export_daily_report_pdf


app_name = 'bookings'

urlpatterns = [
    # سيتم إضافة المسارات هنا لاحقاً
    path('', views.booking_list, name='booking_list'),
    path('acutal_checkout/<int:booking_id>/', views.set_actual_check_out_date, name='set_actual_check_out_date'),
    path('guests_check_out_date/<int:guest_id>/', views.set_guests_check_out_date, name='set_guests_check_out_date'),
    # path('admin/<int:booking_id>/payment/', views.payment_view, name='booking-payment'),
    path('admin/<int:booking_id>/<int:extension_id>/payment-extend/', views.booking_extend_payment, name='booking_extend_payment'),

    # تقارير
    path('reports/daily/', staff_member_required(daily_report_view), name='daily-report'),
    path('reports/daily/export-pdf/', staff_member_required(export_daily_report_pdf), name='daily-report-export-pdf'),
]