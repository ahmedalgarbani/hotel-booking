from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Count, Sum, F, Q
from datetime import date, timedelta
from reportlab.lib.pagesizes import landscape, A4

from services.models import RoomTypeService
from bookings.models import BookingDetail
from bookings.admin_classes.mixins import generate_pdf_report

def get_additional_services_data(request):
    """
    Get data for additional services report.
    """
    today = date.today()
    period = request.GET.get('period', 'monthly')
    hotel_id = request.GET.get('hotel_id')
    
    # Define date ranges based on period
    if period == 'weekly':
        start_date = today - timedelta(days=7)
    elif period == 'monthly':
        start_date = today - timedelta(days=30)
    elif period == 'quarterly':
        start_date = today - timedelta(days=90)
    else:  # yearly (default)
        start_date = today - timedelta(days=365)
    
    # Base queryset for booking details with services
    booking_details_qs = BookingDetail.objects.filter(
        booking__check_in_date__gte=start_date,
        booking__check_in_date__lte=today
    )
    
    # Apply hotel filter if provided
    if hotel_id and hotel_id.isdigit():
        booking_details_qs = booking_details_qs.filter(hotel_id=int(hotel_id))
    
    # Apply user permissions filtering if needed
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                booking_details_qs = booking_details_qs.filter(hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                booking_details_qs = booking_details_qs.filter(hotel__manager=request.user.chield)
    
    # Get services with their usage count and total revenue
    services_data = booking_details_qs.values(
        'service__id', 'service__name', 'service__description', 'service__additional_fee', 'hotel__name'
    ).annotate(
        usage_count=Count('id'),
        total_revenue=Sum('total')
    ).order_by('-usage_count')
    
    # Calculate total usage and revenue
    total_usage = sum(service['usage_count'] for service in services_data)
    total_revenue = sum(service['total_revenue'] for service in services_data if service['total_revenue'])
    
    # Calculate percentage of usage for each service
    for service in services_data:
        service['usage_percentage'] = (service['usage_count'] / total_usage * 100) if total_usage > 0 else 0
    
    # Get hotels for filter dropdown
    from HotelManagement.models import Hotel
    hotels = Hotel.objects.all()
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                hotels = hotels.filter(manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                hotels = hotels.filter(manager=request.user.chield)
    
    # Prepare data for charts
    top_services = services_data[:10]  # Top 10 services
    service_names = [service['service__name'] for service in top_services]
    usage_counts = [service['usage_count'] for service in top_services]
    revenue_amounts = [float(service['total_revenue']) if service['total_revenue'] else 0 for service in top_services]
    
    return {
        'services_data': services_data,
        'period': period,
        'hotels': hotels,
        'selected_hotel_id': hotel_id,
        'service_names': service_names,
        'usage_counts': usage_counts,
        'revenue_amounts': revenue_amounts,
        'total_usage': total_usage,
        'total_revenue': total_revenue,
        'start_date': start_date.strftime('%Y-%m-%d'),
        'end_date': today.strftime('%Y-%m-%d')
    }

def additional_services_report_view(request):
    """
    Display the additional services report view.
    """
    data = get_additional_services_data(request)
    
    # Create context without using admin_site.each_context to avoid NoReverseMatch error
    from django.contrib import admin
    context = {
        'site_title': admin.site.site_title,
        'site_header': admin.site.site_header,
        'site_url': admin.site.site_url,
        'has_permission': True,
        'available_apps': [],
        'is_popup': False,
        'is_nav_sidebar_enabled': True,
        'app_list': []  # Empty app_list to avoid NoReverseMatch error
    }
    
    context.update({
        'title': _('تقرير الخدمات الإضافية'),
        'services_data': data['services_data'],
        'period': data['period'],
        'hotels': data['hotels'],
        'selected_hotel_id': data['selected_hotel_id'],
        'service_names': data['service_names'],
        'usage_counts': data['usage_counts'],
        'revenue_amounts': data['revenue_amounts'],
        'total_usage': data['total_usage'],
        'total_revenue': data['total_revenue'],
        'start_date': data['start_date'],
        'end_date': data['end_date'],
        'opts': RoomTypeService._meta,
        'has_view_permission': True,
        'pdf_export_url': reverse('services:additional-services-report-export-pdf')
    })
    
    return TemplateResponse(request, 'admin/services/service/additional_services_report.html', context)

def export_additional_services_pdf(request):
    """
    Export the additional services report as a PDF.
    
    Args:
        request: The HTTP request object
        
    Returns:
        HttpResponse: The PDF response
    """
    data = get_additional_services_data(request)
    services_data = data['services_data']
    period = data['period']
    start_date = data['start_date']
    end_date = data['end_date']
    total_usage = data['total_usage']
    total_revenue = data['total_revenue']
    
    # Define headers for the PDF table
    headers = [
        _('الخدمة'),
        _('الفندق'),
        _('عدد مرات الاستخدام'),
        _('نسبة الاستخدام'),
        _('إجمالي الإيرادات')
    ]
    
    # Prepare data rows
    data_rows = []
    for service in services_data:
        data_rows.append([
            service['service__name'],
            service['hotel__name'],
            str(service['usage_count']),
            f"{service['usage_percentage']:.2f}%",
            f"{service['total_revenue']:.2f}" if service['total_revenue'] else "0.00"
        ])
    
    # Create report title
    report_title = _('تقرير الخدمات الإضافية الأكثر طلبًا')
    
    # Add period to title
    period_labels = {
        'weekly': _('أسبوعي'),
        'monthly': _('شهري'),
        'quarterly': _('ربع سنوي'),
        'yearly': _('سنوي')
    }
    period_text = period_labels.get(period, period_labels['monthly'])
    report_title += f" ({period_text}: {start_date} - {end_date})"
    
    # Add summary statistics
    report_title += f"\n{_('إجمالي الاستخدام')}: {total_usage} | {_('إجمالي الإيرادات')}: {total_revenue:.2f}"
    
    # Define column widths
    available_width = landscape(A4)[0] - 60  # A4 landscape width minus margins
    col_widths = [
        available_width * 0.25,  # الخدمة
        available_width * 0.25,  # الفندق
        available_width * 0.15,  # عدد مرات الاستخدام
        available_width * 0.15,  # نسبة الاستخدام
        available_width * 0.20   # إجمالي الإيرادات
    ]
    
    # Generate and return the PDF report
    return generate_pdf_report(report_title, headers, data_rows, col_widths=col_widths)
