from django.urls import path
from . import views
from django.contrib.admin.views.decorators import staff_member_required
from services.services.reports import additional_services_report_view, export_additional_services_pdf

app_name = 'services'
urlpatterns = [
    path('apply-coupon/', views.apply_coupon, name='apply_coupon'),

    # path('services/', views.service_list, name='service_list'),
    # path('services/<int:service_id>/', views.service_detail, name='service_detail'),
    # path('services/create/', views.service_create, name='service_create'),
    # path('services/<int:service_id>/update/', views.service_update, name='service_update'),
    # path('services/<int:service_id>/delete/', views.service_delete, name='service_delete'),

    # Reports
    path('reports/additional-services/', staff_member_required(additional_services_report_view), name='additional-services-report'),
    path('reports/additional-services/export-pdf/', staff_member_required(export_additional_services_pdf), name='additional-services-report-export-pdf'),
]
