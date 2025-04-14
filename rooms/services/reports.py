from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Count, F, Sum, Case, When, IntegerField, Q
from datetime import date, timedelta
from django.db.models.functions import TruncDay, TruncWeek, TruncMonth, TruncYear
from reportlab.lib.pagesizes import landscape, A4

from rooms.models import RoomType
from bookings.models import Booking
from bookings.admin_classes.mixins import generate_pdf_report

def get_occupancy_data(request):
    """
    Get room occupancy data for the specified period.
    """
    today = date.today()
    period = request.GET.get('period', 'monthly')
    hotel_id = request.GET.get('hotel_id')

    # Define date ranges based on period
    if period == 'daily':
        start_date = today - timedelta(days=7)
        group_by_func = TruncDay
        date_format = '%Y-%m-%d'
        group_by_name = 'day'
    elif period == 'weekly':
        start_date = today - timedelta(weeks=8)
        group_by_func = TruncWeek
        date_format = '%Y-%W'
        group_by_name = 'week'
    elif period == 'yearly':
        start_date = today - timedelta(days=365)
        group_by_func = TruncYear
        date_format = '%Y'
        group_by_name = 'year'
    else:  # monthly (default)
        start_date = today - timedelta(days=180)
        group_by_func = TruncMonth
        date_format = '%Y-%m'
        group_by_name = 'month'

    # Base queryset for room types
    room_types_qs = RoomType.objects.filter(is_active=True)

    # Apply hotel filter if provided
    if hotel_id and hotel_id.isdigit():
        room_types_qs = room_types_qs.filter(hotel_id=int(hotel_id))

    # Apply user permissions filtering if needed
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                room_types_qs = room_types_qs.filter(hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                room_types_qs = room_types_qs.filter(hotel__manager=request.user.chield)

    # Get total rooms count
    total_rooms = room_types_qs.aggregate(total=Sum('rooms_count'))['total'] or 0

    # Get bookings for the period
    bookings_qs = Booking.objects.filter(
        check_in_date__gte=start_date,
        check_in_date__lte=today,
        status__in=[1, 2, 3]  # Confirmed, Checked-in, Completed
    )

    # Apply hotel filter to bookings if provided
    if hotel_id and hotel_id.isdigit():
        bookings_qs = bookings_qs.filter(hotel_id=int(hotel_id))

    # Apply user permissions filtering to bookings
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                bookings_qs = bookings_qs.filter(hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                bookings_qs = bookings_qs.filter(hotel__manager=request.user.chield)

    # Annotate with the group_by field and count bookings
    bookings_by_period = bookings_qs.annotate(
        period=group_by_func('check_in_date')
    ).values('period').annotate(
        count=Count('id')
    ).order_by('period')

    # Calculate occupancy rate for each period
    occupancy_data = []
    for entry in bookings_by_period:
        period_date = entry['period']
        if period_date:
            occupancy_rate = (entry['count'] / total_rooms) * 100 if total_rooms > 0 else 0
            occupancy_data.append({
                'date': period_date.strftime(date_format),
                'occupied': entry['count'],
                'total': total_rooms,
                'rate': round(occupancy_rate, 2)
            })

    # Get hotels for filter dropdown
    from HotelManagement.models import Hotel
    hotels = Hotel.objects.all()
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                hotels = hotels.filter(manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                hotels = hotels.filter(manager=request.user.chield)

    # Prepare data for chart
    chart_labels = [entry['date'] for entry in occupancy_data]
    chart_data = [entry['rate'] for entry in occupancy_data]

    # Calculate statistics
    avg_rate = sum(entry['rate'] for entry in occupancy_data) / len(occupancy_data) if occupancy_data else 0
    max_rate = max(entry['rate'] for entry in occupancy_data) if occupancy_data else 0

    return {
        'occupancy_data': occupancy_data,
        'period': period,
        'hotels': hotels,
        'selected_hotel_id': hotel_id,
        'chart_labels': chart_labels,
        'chart_data': chart_data,
        'avg_rate': avg_rate,
        'max_rate': max_rate,
        'start_date': start_date.strftime('%Y-%m-%d'),
        'end_date': today.strftime('%Y-%m-%d')
    }

def occupancy_report_view(request):
    """
    Display the room occupancy report view.
    """
    data = get_occupancy_data(request)

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
        'title': _('تقرير معدل الإشغال'),
        'occupancy_data': data['occupancy_data'],
        'period': data['period'],
        'hotels': data['hotels'],
        'selected_hotel_id': data['selected_hotel_id'],
        'chart_labels': data['chart_labels'],
        'chart_data': data['chart_data'],
        'avg_rate': data['avg_rate'],
        'max_rate': data['max_rate'],
        'start_date': data['start_date'],
        'end_date': data['end_date'],
        'opts': RoomType._meta,
        'has_view_permission': True,
        'pdf_export_url': reverse('rooms:occupancy-report-export-pdf')
    })

    return TemplateResponse(request, 'admin/rooms/room/occupancy_report.html', context)


def export_occupancy_report_pdf(request):
    """
    Export the occupancy report as a PDF.

    Args:
        request: The HTTP request object

    Returns:
        HttpResponse: The PDF response
    """
    data = get_occupancy_data(request)
    occupancy_data = data['occupancy_data']
    period = data['period']
    start_date = data['start_date']
    end_date = data['end_date']
    avg_rate = data['avg_rate']
    max_rate = data['max_rate']

    # Define headers for the PDF table
    headers = [
        _('الفترة'),
        _('الغرف المشغولة'),
        _('إجمالي الغرف'),
        _('معدل الإشغال')
    ]

    # Prepare data rows
    data_rows = []
    for entry in occupancy_data:
        data_rows.append([
            entry['date'],
            str(entry['occupied']),
            str(entry['total']),
            f"{entry['rate']}%"
        ])

    # Create report title
    report_title = _('تقرير معدل الإشغال')

    # Add period to title
    period_labels = {
        'daily': _('يومي'),
        'weekly': _('أسبوعي'),
        'monthly': _('شهري'),
        'yearly': _('سنوي')
    }
    period_text = period_labels.get(period, period_labels['monthly'])
    report_title += f" ({period_text}: {start_date} - {end_date})"

    # Add summary statistics
    report_title += f"\n{_('متوسط معدل الإشغال')}: {avg_rate:.2f}% | {_('أعلى معدل إشغال')}: {max_rate:.2f}%"

    # Define column widths
    available_width = landscape(A4)[0] - 60  # A4 landscape width minus margins
    col_widths = [
        available_width * 0.25,  # الفترة
        available_width * 0.25,  # الغرف المشغولة
        available_width * 0.25,  # إجمالي الغرف
        available_width * 0.25   # معدل الإشغال
    ]

    # Generate and return the PDF report
    return generate_pdf_report(report_title, headers, data_rows, col_widths=col_widths)
