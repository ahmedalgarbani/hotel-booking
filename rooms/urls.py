
from django.urls import path
from . import views
from django.contrib.admin.views.decorators import staff_member_required
from rooms.services.reports import occupancy_report_view, export_occupancy_report_pdf
from rooms.services.price_analysis import price_analysis_report_view, export_price_analysis_pdf


app_name = 'rooms'


urlpatterns = [
   # path('room_search',views.room_search,name='room_search'),
   path('room_detail/<int:room_id>/', views.room_detail, name='room_detail'),

   # Reports
   path('reports/occupancy/', staff_member_required(occupancy_report_view), name='occupancy-report'),
   path('reports/occupancy/export-pdf/', staff_member_required(export_occupancy_report_pdf), name='occupancy-report-export-pdf'),
   path('reports/price-analysis/', staff_member_required(price_analysis_report_view), name='price-analysis-report'),
   path('reports/price-analysis/export-pdf/', staff_member_required(export_price_analysis_pdf), name='price-analysis-report-export-pdf'),
]