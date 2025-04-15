from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Avg, Min, Max, Count, F, Q, DecimalField
from django.db.models.functions import Coalesce
from datetime import date, timedelta
from reportlab.lib.pagesizes import landscape, A4
import random
import decimal

from rooms.models import RoomType, RoomPrice, Category
from HotelManagement.models import Hotel, City
from bookings.admin_classes.mixins import generate_pdf_report

def get_competitor_prices(room_type, date_range=None):
    """
    Simulate competitor prices for similar room types.
    In a real application, this would fetch data from external APIs or a competitor price database.
    
    Args:
        room_type: The RoomType object to compare
        date_range: Optional date range for price comparison
        
    Returns:
        dict: Competitor pricing data
    """
    # Get similar room types from other hotels in the same city
    hotel_location = room_type.hotel.location
    if not hotel_location or not hotel_location.city:
        return []
    
    city = hotel_location.city
    
    # Find similar room types in the same city but different hotels
    similar_room_types = RoomType.objects.filter(
        hotel__location__city=city,
        category=room_type.category,
        default_capacity=room_type.default_capacity
    ).exclude(hotel=room_type.hotel)
    
    competitor_data = []
    
    # If we have real competitors, use their actual prices
    if similar_room_types.exists():
        for comp_room in similar_room_types:
            # Get the current price for this room type
            today = timezone.now().date()
            price_obj = RoomPrice.objects.filter(
                room_type=comp_room,
                date_from__lte=today,
                date_to__gte=today
            ).order_by('-date_from').first()
            
            current_price = price_obj.price if price_obj else comp_room.base_price
            
            competitor_data.append({
                'hotel_name': comp_room.hotel.name,
                'room_type_name': comp_room.name,
                'price': current_price,
                'capacity': comp_room.default_capacity,
                'category': comp_room.category.name,
                'price_difference': room_type.base_price - current_price,
                'price_difference_percent': (
                    (room_type.base_price - current_price) / current_price * 100
                    if current_price else 0
                )
            })
    
    # If we don't have enough real competitors, generate some simulated ones
    if len(competitor_data) < 5:
        # Get the average price for this category and capacity across all hotels
        avg_price = RoomType.objects.filter(
            category=room_type.category,
            default_capacity=room_type.default_capacity
        ).aggregate(avg_price=Avg('base_price'))['avg_price'] or room_type.base_price
        
        # Generate simulated competitors
        for i in range(5 - len(competitor_data)):
            # Simulate prices within ±20% of the average
            variation = random.uniform(-0.2, 0.2)
            simulated_price = avg_price * (1 + variation)
            
            competitor_data.append({
                'hotel_name': f"منافس {i+1}",
                'room_type_name': f"{room_type.category.name} - {room_type.default_capacity} أشخاص",
                'price': simulated_price,
                'capacity': room_type.default_capacity,
                'category': room_type.category.name,
                'price_difference': room_type.base_price - simulated_price,
                'price_difference_percent': (
                    (room_type.base_price - simulated_price) / simulated_price * 100
                    if simulated_price else 0
                ),
                'simulated': True  # Flag to indicate this is simulated data
            })
    
    return competitor_data

def get_price_history(room_type, days=90):
    """
    Get historical price data for a room type.
    
    Args:
        room_type: The RoomType object
        days: Number of days to look back
        
    Returns:
        list: Historical price data
    """
    today = timezone.now().date()
    start_date = today - timedelta(days=days)
    
    # Get all price records for this room type in the date range
    price_records = RoomPrice.objects.filter(
        room_type=room_type,
        date_from__gte=start_date,
        date_to__lte=today
    ).order_by('date_from')
    
    # Create a list of dates and prices
    price_history = []
    current_date = start_date
    
    while current_date <= today:
        # Find a price record that covers this date
        price_obj = RoomPrice.objects.filter(
            room_type=room_type,
            date_from__lte=current_date,
            date_to__gte=current_date
        ).order_by('-date_from').first()
        
        price = price_obj.price if price_obj else room_type.base_price
        
        price_history.append({
            'date': current_date.strftime('%Y-%m-%d'),
            'price': float(price),
            'is_special': bool(price_obj and price_obj.is_special_offer) if price_obj else False
        })
        
        current_date += timedelta(days=1)
    
    return price_history

def get_price_analysis_data(request):
    """
    Get data for price analysis report.
    """
    room_type_id = request.GET.get('room_type_id')
    hotel_id = request.GET.get('hotel_id')
    category_id = request.GET.get('category_id')
    period = request.GET.get('period', '90')  # Default to 90 days
    
    try:
        period_days = int(period)
    except (ValueError, TypeError):
        period_days = 90
    
    # Get all hotels for the filter dropdown
    hotels = Hotel.objects.all()
    
    # Get all room categories for the filter dropdown
    categories = Category.objects.all()
    
    # Base queryset for room types
    room_types_qs = RoomType.objects.all()
    
    # Apply filters
    if hotel_id and hotel_id.isdigit():
        room_types_qs = room_types_qs.filter(hotel_id=int(hotel_id))
    
    if category_id and category_id.isdigit():
        room_types_qs = room_types_qs.filter(category_id=int(category_id))
    
    # Get the specific room type if provided
    selected_room_type = None
    if room_type_id and room_type_id.isdigit():
        try:
            selected_room_type = RoomType.objects.get(id=int(room_type_id))
        except RoomType.DoesNotExist:
            selected_room_type = None
    
    # If no specific room type is selected, use the first one from the filtered queryset
    if not selected_room_type and room_types_qs.exists():
        selected_room_type = room_types_qs.first()
    
    # Prepare data for the report
    competitor_data = []
    price_history = []
    price_statistics = {}
    
    if selected_room_type:
        # Get competitor prices
        competitor_data = get_competitor_prices(selected_room_type)
        
        # Get price history
        price_history = get_price_history(selected_room_type, days=period_days)
        
        # Calculate price statistics
        today = timezone.now().date()
        start_date = today - timedelta(days=period_days)
        
        # Get all prices for this room type in the period
        prices = RoomPrice.objects.filter(
            room_type=selected_room_type,
            date_from__gte=start_date,
            date_to__lte=today
        ).values_list('price', flat=True)
        
        # Include the base price
        all_prices = list(prices) + [selected_room_type.base_price]
        
        if all_prices:
            price_statistics = {
                'min_price': min(all_prices),
                'max_price': max(all_prices),
                'avg_price': sum(all_prices) / len(all_prices),
                'current_price': selected_room_type.base_price
            }
        else:
            price_statistics = {
                'min_price': selected_room_type.base_price,
                'max_price': selected_room_type.base_price,
                'avg_price': selected_room_type.base_price,
                'current_price': selected_room_type.base_price
            }
        
        # Calculate market position
        if competitor_data:
            all_competitor_prices = [c['price'] for c in competitor_data]
            market_min = min(all_competitor_prices)
            market_max = max(all_competitor_prices)
            market_avg = sum(all_competitor_prices) / len(all_competitor_prices)
            
            price_statistics.update({
                'market_min': market_min,
                'market_max': market_max,
                'market_avg': market_avg,
                'price_position': (
                    (selected_room_type.base_price - market_min) / (market_max - market_min) * 100
                    if market_max > market_min else 50
                )
            })
    
    # Prepare data for charts
    history_dates = [item['date'] for item in price_history]
    history_prices = [item['price'] for item in price_history]
    
    competitor_names = [item['hotel_name'] for item in competitor_data]
    competitor_prices = [float(item['price']) for item in competitor_data]
    
    return {
        'room_types': room_types_qs,
        'selected_room_type': selected_room_type,
        'hotels': hotels,
        'selected_hotel_id': hotel_id,
        'categories': categories,
        'selected_category_id': category_id,
        'period': period,
        'competitor_data': competitor_data,
        'price_history': price_history,
        'price_statistics': price_statistics,
        'history_dates': history_dates,
        'history_prices': history_prices,
        'competitor_names': competitor_names,
        'competitor_prices': competitor_prices
    }

def price_analysis_report_view(request):
    """
    Display the price analysis report view.
    """
    data = get_price_analysis_data(request)
    
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
        'title': _('تقرير تحليل الأسعار'),
        'room_types': data['room_types'],
        'selected_room_type': data['selected_room_type'],
        'hotels': data['hotels'],
        'selected_hotel_id': data['selected_hotel_id'],
        'categories': data['categories'],
        'selected_category_id': data['selected_category_id'],
        'period': data['period'],
        'competitor_data': data['competitor_data'],
        'price_history': data['price_history'],
        'price_statistics': data['price_statistics'],
        'history_dates': data['history_dates'],
        'history_prices': data['history_prices'],
        'competitor_names': data['competitor_names'],
        'competitor_prices': data['competitor_prices'],
        'opts': RoomType._meta,
        'has_view_permission': True,
        'pdf_export_url': reverse('rooms:price-analysis-report-export-pdf')
    })
    
    return TemplateResponse(request, 'admin/rooms/room/price_analysis_report.html', context)

def export_price_analysis_pdf(request):
    """
    Export the price analysis report as a PDF.
    
    Args:
        request: The HTTP request object
        
    Returns:
        HttpResponse: The PDF response
    """
    data = get_price_analysis_data(request)
    selected_room_type = data['selected_room_type']
    competitor_data = data['competitor_data']
    price_statistics = data['price_statistics']
    period = data['period']
    
    if not selected_room_type:
        # Return an empty PDF if no room type is selected
        return generate_pdf_report(
            _('تقرير تحليل الأسعار'),
            [_('الفندق'), _('نوع الغرفة'), _('السعر'), _('الفرق')],
            [],
            []
        )
    
    # Define headers for the PDF table
    headers = [
        _('الفندق'),
        _('نوع الغرفة'),
        _('السعر'),
        _('الفرق'),
        _('نسبة الفرق %')
    ]
    
    # Prepare data rows
    data_rows = []
    
    # Add the selected room type as the first row
    data_rows.append([
        selected_room_type.hotel.name,
        selected_room_type.name,
        f"{selected_room_type.base_price:.2f}",
        "0.00",
        "0.00%"
    ])
    
    # Add competitor data
    for comp in competitor_data:
        price_diff = comp['price_difference']
        price_diff_percent = comp['price_difference_percent']
        
        data_rows.append([
            comp['hotel_name'],
            comp['room_type_name'],
            f"{comp['price']:.2f}",
            f"{price_diff:.2f}",
            f"{price_diff_percent:.2f}%"
        ])
    
    # Create report title
    report_title = _('تقرير تحليل الأسعار')
    
    # Add room type info to title
    report_title += f" - {selected_room_type.hotel.name} - {selected_room_type.name}"
    
    # Add period to title
    report_title += f" ({_('آخر')} {period} {_('يوم')})"
    
    # Add summary statistics
    if price_statistics:
        report_title += f"\n{_('السعر الحالي')}: {price_statistics.get('current_price', 0):.2f} | "
        report_title += f"{_('متوسط السوق')}: {price_statistics.get('market_avg', 0):.2f} | "
        report_title += f"{_('الحد الأدنى للسوق')}: {price_statistics.get('market_min', 0):.2f} | "
        report_title += f"{_('الحد الأقصى للسوق')}: {price_statistics.get('market_max', 0):.2f}"
    
    # Define column widths
    available_width = landscape(A4)[0] - 60  # A4 landscape width minus margins
    col_widths = [
        available_width * 0.25,  # الفندق
        available_width * 0.25,  # نوع الغرفة
        available_width * 0.15,  # السعر
        available_width * 0.15,  # الفرق
        available_width * 0.20   # نسبة الفرق %
    ]
    
    # Generate and return the PDF report
    return generate_pdf_report(report_title, headers, data_rows, col_widths=col_widths)
