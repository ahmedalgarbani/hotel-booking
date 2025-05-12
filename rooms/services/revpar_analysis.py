from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Count, F, Sum, Case, When, IntegerField, Q, Avg, DecimalField
from datetime import date, timedelta
from django.db.models.functions import TruncDay, TruncWeek, TruncMonth, TruncYear
from reportlab.lib.pagesizes import landscape, A4
from decimal import Decimal

from rooms.models import RoomType
from bookings.models import Booking
from payments.models import Payment
from bookings.admin_classes.mixins import generate_pdf_report


def get_revpar_data(request):
    """
    Get RevPAR (Revenue Per Available Room) data for the specified period.
    
    RevPAR = Total Room Revenue / Total Available Rooms
    """
    today = date.today()
    period = request.GET.get('period', '30')
    hotel_id = request.GET.get('hotel_id')
    room_type_id = request.GET.get('room_type_id')
    
    try:
        days = int(period)
    except (ValueError, TypeError):
        days = 30  # Default to 30 days
    
    # Define date range
    start_date = today - timedelta(days=days)
    end_date = today
    
    # Base queryset for room types
    room_types_qs = RoomType.objects.filter(is_active=True)
    
    # Apply hotel filter if provided
    if hotel_id and hotel_id.isdigit():
        room_types_qs = room_types_qs.filter(hotel_id=int(hotel_id))
    
    # Apply room type filter if provided
    selected_room_type = None
    if room_type_id and room_type_id.isdigit():
        room_types_qs = room_types_qs.filter(id=int(room_type_id))
        selected_room_type = room_types_qs.first()
    
    # Apply user permissions filtering if needed
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                room_types_qs = room_types_qs.filter(hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                room_types_qs = room_types_qs.filter(hotel__manager=request.user.chield)
    
    # Get hotels for filter dropdown
    from HotelManagement.models import Hotel
    hotels = Hotel.objects.all()
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                hotels = hotels.filter(manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                hotels = hotels.filter(manager=request.user.chield)
    
    # Prepare RevPAR data
    revpar_data = []
    room_type_data = []
    total_revenue = Decimal('0.00')
    total_available_rooms = 0
    overall_revpar = Decimal('0.00')
    
    # Get bookings for the period
    bookings_qs = Booking.objects.filter(
        check_in_date__gte=start_date,
        check_in_date__lte=end_date,
        status__in=[1, 2, 3]  # Confirmed, Checked-in, Completed
    )
    
    # Apply hotel filter to bookings if provided
    if hotel_id and hotel_id.isdigit():
        bookings_qs = bookings_qs.filter(hotel_id=int(hotel_id))
    
    # Apply room type filter to bookings if provided
    if room_type_id and room_type_id.isdigit():
        bookings_qs = bookings_qs.filter(room_id=int(room_type_id))
    
    # Apply user permissions filtering to bookings
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                bookings_qs = bookings_qs.filter(hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                bookings_qs = bookings_qs.filter(hotel__manager=request.user.chield)
    
    # Calculate RevPAR for each day in the period
    current_date = start_date
    date_labels = []
    revpar_values = []
    occupancy_rates = []
    adr_values = []  # Average Daily Rate
    
    while current_date <= end_date:
        next_date = current_date + timedelta(days=1)
        
        # Get bookings for this day
        day_bookings = bookings_qs.filter(
            Q(check_in_date__lte=current_date) & 
            (Q(check_out_date__gt=current_date) | Q(check_out_date__isnull=True))
        )
        
        # Calculate revenue for this day
        # For simplicity, we'll divide the total booking amount by the number of days
        day_revenue = Decimal('0.00')
        for booking in day_bookings:
            # Calculate booking duration
            checkout = booking.check_out_date or (booking.check_in_date + timedelta(days=1))
            duration = (checkout - booking.check_in_date).days or 1
            
            # Get payments for this booking
            payments = Payment.objects.filter(booking=booking, payment_status=1)
            total_paid = payments.aggregate(total=Sum('payment_totalamount'))['total'] or Decimal('0.00')
            
            # Calculate daily rate
            daily_rate = total_paid / duration
            day_revenue += daily_rate
        
        # Count available rooms for this day
        available_rooms = 0
        for room_type in room_types_qs:
            available_rooms += room_type.rooms_count
        
        # Calculate RevPAR
        revpar = day_revenue / available_rooms if available_rooms > 0 else Decimal('0.00')
        
        # Calculate occupancy rate
        occupied_rooms = day_bookings.count()
        occupancy_rate = (occupied_rooms / available_rooms * 100) if available_rooms > 0 else 0
        
        # Calculate ADR (Average Daily Rate)
        adr = day_revenue / occupied_rooms if occupied_rooms > 0 else Decimal('0.00')
        
        # Add to data
        revpar_data.append({
            'date': current_date.strftime('%Y-%m-%d'),
            'revenue': day_revenue,
            'available_rooms': available_rooms,
            'occupied_rooms': occupied_rooms,
            'revpar': revpar,
            'occupancy_rate': occupancy_rate,
            'adr': adr
        })
        
        # Add to chart data
        date_labels.append(current_date.strftime('%m-%d'))
        revpar_values.append(float(revpar))
        occupancy_rates.append(float(occupancy_rate))
        adr_values.append(float(adr))
        
        # Update totals
        total_revenue += day_revenue
        total_available_rooms += available_rooms
        
        # Move to next day
        current_date = next_date
    
    # Calculate overall RevPAR
    overall_revpar = total_revenue / total_available_rooms if total_available_rooms > 0 else Decimal('0.00')
    
    # Calculate RevPAR by room type
    for room_type in room_types_qs:
        # Get bookings for this room type
        room_type_bookings = bookings_qs.filter(room=room_type)
        
        # Calculate revenue for this room type
        room_type_revenue = Decimal('0.00')
        for booking in room_type_bookings:
            # Get payments for this booking
            payments = Payment.objects.filter(booking=booking, payment_status=1)
            total_paid = payments.aggregate(total=Sum('payment_totalamount'))['total'] or Decimal('0.00')
            room_type_revenue += total_paid
        
        # Calculate available rooms for the period
        room_type_available_rooms = room_type.rooms_count * days
        
        # Calculate RevPAR
        room_type_revpar = room_type_revenue / room_type_available_rooms if room_type_available_rooms > 0 else Decimal('0.00')
        
        # Calculate occupancy
        room_type_bookings_count = room_type_bookings.count()
        room_type_occupancy = (room_type_bookings_count / room_type_available_rooms * 100) if room_type_available_rooms > 0 else 0
        
        # Calculate ADR
        room_type_adr = room_type_revenue / room_type_bookings_count if room_type_bookings_count > 0 else Decimal('0.00')
        
        room_type_data.append({
            'name': room_type.name,
            'hotel': room_type.hotel.name,
            'revenue': room_type_revenue,
            'available_rooms': room_type_available_rooms,
            'revpar': room_type_revpar,
            'occupancy': room_type_occupancy,
            'adr': room_type_adr
        })
    
    # Sort room types by RevPAR (highest first)
    room_type_data.sort(key=lambda x: x['revpar'], reverse=True)
    
    # Calculate market comparison data
    market_comparison = {}
    if selected_room_type and room_type_data:
        # Find the selected room type in the data
        selected_data = next((item for item in room_type_data if item['name'] == selected_room_type.name), None)
        
        if selected_data:
            # Calculate average RevPAR for all room types
            avg_revpar = sum(item['revpar'] for item in room_type_data) / len(room_type_data)
            
            # Calculate RevPAR Index (selected RevPAR / market average RevPAR * 100)
            revpar_index = (selected_data['revpar'] / avg_revpar * 100) if avg_revpar > 0 else 0
            
            # Calculate market position
            market_position = 0
            for i, item in enumerate(room_type_data):
                if item['name'] == selected_room_type.name:
                    market_position = i + 1
                    break
            
            market_comparison = {
                'avg_market_revpar': avg_revpar,
                'revpar_index': revpar_index,
                'market_position': market_position,
                'total_competitors': len(room_type_data)
            }
    
    # Calculate RevPAR trends
    revpar_trend = 0
    if len(revpar_values) > 1:
        first_half = revpar_values[:len(revpar_values)//2]
        second_half = revpar_values[len(revpar_values)//2:]
        
        first_half_avg = sum(first_half) / len(first_half) if first_half else 0
        second_half_avg = sum(second_half) / len(second_half) if second_half else 0
        
        if first_half_avg > 0:
            revpar_trend = ((second_half_avg - first_half_avg) / first_half_avg) * 100
    
    # Calculate performance metrics
    performance_metrics = {
        'overall_revpar': overall_revpar,
        'avg_occupancy': sum(occupancy_rates) / len(occupancy_rates) if occupancy_rates else 0,
        'avg_adr': sum(adr_values) / len(adr_values) if adr_values else 0,
        'revpar_trend': revpar_trend,
        'total_revenue': total_revenue
    }
    
    # Prepare recommendations based on data
    recommendations = []
    
    # Check if RevPAR is below market average
    if market_comparison and market_comparison.get('revpar_index', 100) < 95:
        recommendations.append(_("RevPAR أقل من متوسط السوق. فكر في مراجعة استراتيجية التسعير أو تحسين جودة الغرف."))
    
    # Check occupancy vs ADR balance
    avg_occupancy = performance_metrics['avg_occupancy']
    if avg_occupancy < 60:
        recommendations.append(_("معدل الإشغال منخفض. فكر في تخفيض الأسعار أو تقديم عروض ترويجية لزيادة الإشغال."))
    elif avg_occupancy > 85:
        recommendations.append(_("معدل الإشغال مرتفع. يمكن زيادة الأسعار لتحسين RevPAR."))
    
    # Check RevPAR trend
    if revpar_trend < -10:
        recommendations.append(_("هناك انخفاض ملحوظ في RevPAR. راجع التغييرات الأخيرة في التسعير أو جودة الخدمة."))
    elif revpar_trend > 10:
        recommendations.append(_("RevPAR في تحسن مستمر. استمر في الاستراتيجية الحالية مع مراقبة ردود فعل العملاء."))
    
    # Prepare chart data
    chart_data = {
        'labels': date_labels,
        'revpar': revpar_values,
        'occupancy': occupancy_rates,
        'adr': adr_values
    }
    
    return {
        'revpar_data': revpar_data,
        'room_type_data': room_type_data,
        'performance_metrics': performance_metrics,
        'market_comparison': market_comparison,
        'recommendations': recommendations,
        'chart_data': chart_data,
        'period': period,
        'start_date': start_date.strftime('%Y-%m-%d'),
        'end_date': end_date.strftime('%Y-%m-%d'),
        'hotels': hotels,
        'room_types': room_types_qs,
        'selected_hotel_id': hotel_id,
        'selected_room_type': selected_room_type
    }


def revpar_analysis_report_view(request):
    """
    Display the RevPAR analysis report view.
    """
    data = get_revpar_data(request)
    
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
    
    # If no room type is selected but we have room types available, select the first one
    if not data['selected_room_type'] and data['room_types'].exists():
        # Get the first room type
        first_room_type = data['room_types'].first()
        
        # Redirect to the same page with the room type selected
        redirect_url = f"{request.path}?room_type_id={first_room_type.id}"
        if data['selected_hotel_id']:
            redirect_url += f"&hotel_id={data['selected_hotel_id']}"
        if data['period']:
            redirect_url += f"&period={data['period']}"
        
        from django.shortcuts import redirect
        return redirect(redirect_url)
    
    context.update({
        'title': _('تقرير تحليل العائد على الغرفة الواحدة (RevPAR)'),
        'revpar_data': data['revpar_data'],
        'room_type_data': data['room_type_data'],
        'performance_metrics': data['performance_metrics'],
        'market_comparison': data['market_comparison'],
        'recommendations': data['recommendations'],
        'chart_data': data['chart_data'],
        'period': data['period'],
        'start_date': data['start_date'],
        'end_date': data['end_date'],
        'hotels': data['hotels'],
        'room_types': data['room_types'],
        'selected_hotel_id': data['selected_hotel_id'],
        'selected_room_type': data['selected_room_type'],
        'opts': RoomType._meta,
        'has_view_permission': True,
        'pdf_export_url': reverse('rooms:revpar-analysis-report-export-pdf')
    })
    
    return TemplateResponse(request, 'admin/rooms/room/revpar_analysis_report.html', context)


def export_revpar_analysis_pdf(request):
    """
    Export the RevPAR analysis report as a PDF.
    
    Args:
        request: The HTTP request object
        
    Returns:
        HttpResponse: The PDF response
    """
    data = get_revpar_data(request)
    revpar_data = data['revpar_data']
    room_type_data = data['room_type_data']
    performance_metrics = data['performance_metrics']
    market_comparison = data['market_comparison']
    recommendations = data['recommendations']
    period = data['period']
    start_date = data['start_date']
    end_date = data['end_date']
    selected_room_type = data['selected_room_type']
    
    # Define headers for the PDF table
    headers = [
        str(_('التاريخ')),
        str(_('الإيراد')),
        str(_('الغرف المتاحة')),
        str(_('الغرف المشغولة')),
        str(_('RevPAR')),
        str(_('معدل الإشغال')),
        str(_('متوسط السعر اليومي'))
    ]
    
    # Prepare data rows for daily RevPAR
    data_rows = []
    for entry in revpar_data:
        data_rows.append([
            entry['date'],
            f"{entry['revenue']:.2f}",
            str(entry['available_rooms']),
            str(entry['occupied_rooms']),
            f"{entry['revpar']:.2f}",
            f"{entry['occupancy_rate']:.2f}%",
            f"{entry['adr']:.2f}"
        ])
    
    # Create report title - convert translation proxies to strings
    report_title = str(_('تقرير تحليل العائد على الغرفة الواحدة (RevPAR)'))
    
    # Add room type info to title if available
    if selected_room_type:
        report_title += f" - {selected_room_type.hotel.name} - {selected_room_type.name}"
    
    # Add period to title
    report_title += f" ({str(_('آخر'))} {period} {str(_('يوم'))})"
    
    # Create metadata for subtitle and statistics
    metadata = {
        'subtitle': str(_('تحليل أداء العائد على الغرفة الواحدة')),
        'statistics': []
    }
    
    # Add performance metrics
    metadata['statistics'].append(
        f"{str(_('RevPAR الإجمالي'))}: {performance_metrics['overall_revpar']:.2f}"
    )
    metadata['statistics'].append(
        f"{str(_('متوسط معدل الإشغال'))}: {performance_metrics['avg_occupancy']:.2f}% | "
        f"{str(_('متوسط السعر اليومي'))}: {performance_metrics['avg_adr']:.2f}"
    )
    
    # Add market comparison if available
    if market_comparison:
        metadata['statistics'].append(
            f"{str(_('مؤشر RevPAR'))}: {market_comparison['revpar_index']:.2f}% | "
            f"{str(_('الترتيب في السوق'))}: {market_comparison['market_position']}/{market_comparison['total_competitors']}"
        )
    
    # Add RevPAR trend
    metadata['statistics'].append(
        f"{str(_('اتجاه RevPAR'))}: {performance_metrics['revpar_trend']:.2f}%"
    )
    
    # Add recommendations
    if recommendations:
        metadata['statistics'].append(str(_('التوصيات:')))
        for i, rec in enumerate(recommendations[:3], 1):  # Limit to top 3 recommendations
            metadata['statistics'].append(f"{i}. {rec}")
    
    # Define column widths
    available_width = landscape(A4)[0] - 60  # A4 landscape width minus margins
    col_widths = [
        available_width * 0.12,  # التاريخ
        available_width * 0.14,  # الإيراد
        available_width * 0.12,  # الغرف المتاحة
        available_width * 0.12,  # الغرف المشغولة
        available_width * 0.14,  # RevPAR
        available_width * 0.14,  # معدل الإشغال
        available_width * 0.22   # متوسط السعر اليومي
    ]
    
    # Generate and return the PDF report with RTL support
    return generate_pdf_report(report_title, headers, data_rows, col_widths=col_widths, rtl=True, metadata=metadata)
