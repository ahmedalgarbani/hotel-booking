# urls.py
from django.urls import path
from . import views
from django.contrib.admin.views.decorators import staff_member_required
from users.services.reports import vip_customers_report_view, export_vip_customers_pdf

app_name='users'
urlpatterns = [
    path('register/', views.register, name='register'),
    path('logout/', views.logout_view, name='logout'),
    path('login/', views.login_view, name='login'),
    path('forgot-password/', views.forgot_password, name='forgot_password'),
    path('send-otp/', views.send_otp, name='send_otp'),
    path('verify-otp/', views.verify_otp, name='verify_otp'),
    path('reset-password/', views.reset_password, name='reset_password'),

    # Reports
    path('reports/vip-customers/', staff_member_required(vip_customers_report_view), name='vip-customers-report'),
    path('reports/vip-customers/export-pdf/', staff_member_required(export_vip_customers_pdf), name='vip-customers-report-export-pdf'),
]