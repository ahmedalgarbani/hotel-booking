
from django.urls import path
from . import views
from django.contrib.admin.views.decorators import staff_member_required
from rooms.services.reports import occupancy_report_view, export_occupancy_report_pdf


app_name = 'rooms'


urlpatterns = [
   # path('room_search',views.room_search,name='room_search'),
   path('room_detail/<int:room_id>/', views.room_detail, name='room_detail'),

   # Reports
   path('reports/occupancy/', staff_member_required(occupancy_report_view), name='occupancy-report'),
   path('reports/occupancy/export-pdf/', staff_member_required(export_occupancy_report_pdf), name='occupancy-report-export-pdf'),
]