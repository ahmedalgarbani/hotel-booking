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
    Simulate competitor prices for similar room types with enhanced categorization and insights.
    In a real application, this would fetch data from external APIs or a competitor price database.

    Args:
        room_type: The RoomType object to compare
        date_range: Optional date range for price comparison

    Returns:
        dict: Enhanced competitor pricing data with categorization and insights
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
            price_difference = room_type.base_price - current_price
            price_difference_percent = (
                (room_type.base_price - current_price) / current_price * 100
                if current_price else 0
            )
            
            # Determine competitor type based on hotel category or price
            competitor_type = "منافس مباشر"
            if hasattr(comp_room.hotel, 'star_rating') and hasattr(room_type.hotel, 'star_rating'):
                if comp_room.hotel.star_rating > room_type.hotel.star_rating:
                    competitor_type = "فندق فاخر"
                elif comp_room.hotel.star_rating < room_type.hotel.star_rating:
                    competitor_type = "فندق اقتصادي"
            else:
                # Fallback to price-based categorization
                if current_price > room_type.base_price * decimal.Decimal('1.2'):
                    competitor_type = "فندق فاخر"
                elif current_price < room_type.base_price * decimal.Decimal('0.8'):
                    competitor_type = "فندق اقتصادي"
            
            # Calculate value score (simplified version)
            # In a real app, this would incorporate ratings, amenities, etc.
            value_score = 100
            if hasattr(comp_room.hotel, 'rating') and current_price > 0:
                # Higher score means better value
                value_score = (comp_room.hotel.rating / 5) * 100 / (current_price / room_type.base_price)
            else:
                # Simplified calculation based only on price
                value_score = 100 * (room_type.base_price / current_price) if current_price > 0 else 100
            
            # Cap value score between 0 and 100
            value_score = max(0, min(100, value_score))
            
            competitor_data.append({
                'hotel_name': comp_room.hotel.name,
                'room_type_name': comp_room.name,
                'price': current_price,
                'capacity': comp_room.default_capacity,
                'category': comp_room.category.name,
                'price_difference': price_difference,
                'price_difference_percent': price_difference_percent,
                'competitor_type': competitor_type,
                'value_score': round(value_score, 1),
                'recommendation': get_price_recommendation(price_difference_percent, value_score)
            })

    # If we don't have enough real competitors, generate some simulated ones
    if len(competitor_data) < 5:
        # Get the average price for this category and capacity across all hotels
        avg_price = RoomType.objects.filter(
            category=room_type.category,
            default_capacity=room_type.default_capacity
        ).aggregate(avg_price=Avg('base_price'))['avg_price'] or room_type.base_price

        # Generate simulated competitors with more realistic variation
        for i in range(5 - len(competitor_data)):
            # Create different competitor types
            competitor_types = ["منافس مباشر", "فندق فاخر", "فندق اقتصادي"]
            competitor_type = competitor_types[i % len(competitor_types)]
            
            # Adjust price variation based on competitor type
            if competitor_type == "فندق فاخر":
                variation = random.uniform(0.1, 0.3)  # 10-30% higher
            elif competitor_type == "فندق اقتصادي":
                variation = random.uniform(-0.3, -0.1)  # 10-30% lower
            else:  # Direct competitor
                variation = random.uniform(-0.1, 0.1)  # ±10%
                
            # Convert float to Decimal before multiplication to avoid TypeError
            simulated_price = avg_price * (decimal.Decimal('1.0') + decimal.Decimal(str(variation)))
            price_difference = room_type.base_price - simulated_price
            price_difference_percent = (
                (room_type.base_price - simulated_price) / simulated_price * 100
                if simulated_price else 0
            )
            
            # Simulate value score
            value_score = 50 + random.uniform(-20, 20)
            if competitor_type == "فندق فاخر":
                value_score -= 10  # Luxury hotels tend to have lower value scores
            elif competitor_type == "فندق اقتصادي":
                value_score += 10  # Budget hotels tend to have higher value scores
                
            competitor_data.append({
                'hotel_name': f"منافس {i+1} ({competitor_type})",
                'room_type_name': f"{room_type.category.name} - {room_type.default_capacity} أشخاص",
                'price': simulated_price,
                'capacity': room_type.default_capacity,
                'category': room_type.category.name,
                'price_difference': price_difference,
                'price_difference_percent': price_difference_percent,
                'competitor_type': competitor_type,
                'value_score': round(value_score, 1),
                'recommendation': get_price_recommendation(price_difference_percent, value_score),
                'simulated': True  # Flag to indicate this is simulated data
            })

    return competitor_data

def get_price_recommendation(price_difference_percent, value_score):
    """
    Generate a price recommendation based on price difference and value score.
    
    Args:
        price_difference_percent: Percentage difference from competitor price
        value_score: Value for money score (0-100)
        
    Returns:
        str: Recommendation message
    """
    if price_difference_percent < -15:  # Our price is much lower
        if value_score > 70:
            return "يمكن رفع السعر مع الحفاظ على القيمة التنافسية"
        else:
            return "السعر منخفض مقارنة بالمنافسين"
    elif price_difference_percent > 15:  # Our price is much higher
        if value_score < 50:
            return "السعر مرتفع مقارنة بالقيمة المقدمة"
        else:
            return "السعر مبرر بالقيمة العالية المقدمة"
    else:  # Price is comparable
        if value_score > 70:
            return "سعر تنافسي مع قيمة ممتازة"
        elif value_score < 50:
            return "يمكن تحسين القيمة المقدمة"
        else:
            return "سعر متوازن مع السوق"

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
    Get enhanced data for price analysis report with additional insights.
    """
    today = date.today()
    period = request.GET.get('period', '30')  # Default to 30 days
    room_type_id = request.GET.get('room_type_id')
    hotel_id = request.GET.get('hotel_id')
    category_id = request.GET.get('category_id')
    
    # Get all room types
    room_types_qs = RoomType.objects.all()
    
    # Apply user permissions filtering if needed
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                room_types_qs = room_types_qs.filter(hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                room_types_qs = room_types_qs.filter(hotel__manager=request.user.chield)
    
    # Apply hotel filter if provided
    if hotel_id and hotel_id.isdigit():
        room_types_qs = room_types_qs.filter(hotel_id=int(hotel_id))
    
    # Apply category filter if provided
    if category_id and category_id.isdigit():
        room_types_qs = room_types_qs.filter(category_id=int(category_id))
    
    # Get selected room type
    selected_room_type = None
    if room_type_id and room_type_id.isdigit():
        try:
            selected_room_type = room_types_qs.get(id=int(room_type_id))
        except RoomType.DoesNotExist:
            pass
    
    # Get competitor data if a room type is selected
    competitor_data = []
    price_statistics = {}
    price_history = []
    competitor_types_summary = {}
    price_recommendations = []
    if selected_room_type:
        competitor_data = get_competitor_prices(selected_room_type)
        
        # Calculate price statistics
        current_price = selected_room_type.base_price
        competitor_prices = [comp['price'] for comp in competitor_data]
        
        if competitor_prices:
            market_avg = sum(competitor_prices) / len(competitor_prices)
            market_min = min(competitor_prices)
            market_max = max(competitor_prices)
            
            # Calculate price position percentage (0-100%)
            price_position = 0.5  # Default to middle
            if market_max > market_min:
                price_position = (current_price - market_min) / (market_max - market_min)
            
            # Calculate market position description
            if price_position < 0.25:
                market_position_text = _("سعر منخفض مقارنة بالسوق")
            elif price_position < 0.45:
                market_position_text = _("سعر أقل من المتوسط")
            elif price_position < 0.55:
                market_position_text = _("سعر متوسط السوق")
            elif price_position < 0.75:
                market_position_text = _("سعر أعلى من المتوسط")
            else:
                market_position_text = _("سعر مرتفع مقارنة بالسوق")
            
            # Calculate average value score
            avg_value_score = sum(comp.get('value_score', 50) for comp in competitor_data) / len(competitor_data)
            
            # Get unique recommendations
            unique_recommendations = set(comp.get('recommendation', '') for comp in competitor_data if 'recommendation' in comp)
            price_recommendations = list(unique_recommendations)
            
            price_statistics = {
                'current_price': current_price,
                'market_avg': market_avg,
                'market_min': market_min,
                'market_max': market_max,
                'price_position': price_position,
                'market_position_text': market_position_text,
                'price_difference_from_avg': current_price - market_avg,
                'price_difference_percent': (current_price - market_avg) / market_avg * 100 if market_avg else 0,
                'avg_value_score': avg_value_score
            }
            
            # Calculate competitor types summary
            competitor_types_summary = {}
            for comp in competitor_data:
                comp_type = comp.get('competitor_type', _('منافس مباشر'))
                if comp_type not in competitor_types_summary:
                    competitor_types_summary[comp_type] = {
                        'count': 0,
                        'avg_price': 0,
                        'total_price': 0
                    }
                competitor_types_summary[comp_type]['count'] += 1
                competitor_types_summary[comp_type]['total_price'] += comp['price']
            
            # Calculate average prices for each competitor type
            for comp_type, data in competitor_types_summary.items():
                if data['count'] > 0:
                    data['avg_price'] = data['total_price'] / data['count']
        
        # Get price history
        try:
            days = int(period)
        except ValueError:
            days = 30
            
        price_history = get_price_history(selected_room_type, days)
    
    # Get hotels for filter dropdown
    hotels = Hotel.objects.all()
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                hotels = hotels.filter(manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                hotels = hotels.filter(manager=request.user.chield)
    
    # Get categories for filter dropdown
    categories = Category.objects.all()
    
    # Prepare data for charts
    # Check if date is already a string or a date object before calling strftime
    history_dates = []
    for item in price_history:
        if isinstance(item['date'], str):
            history_dates.append(item['date'])
        else:
            history_dates.append(item['date'].strftime('%Y-%m-%d'))
            
    history_prices = [float(item['price']) for item in price_history]
    
    competitor_names = [comp['hotel_name'] for comp in competitor_data]
    competitor_prices = [float(comp['price']) for comp in competitor_data]
    
    # Prepare data for competitor type chart
    competitor_type_labels = list(competitor_types_summary.keys())
    competitor_type_prices = [float(data['avg_price']) for data in competitor_types_summary.values()]
    competitor_type_counts = [data['count'] for data in competitor_types_summary.values()]
    
    # Calculate ideal price range based on market position and value
    ideal_price_range = {}
    if price_statistics and 'market_avg' in price_statistics:
        market_avg = price_statistics['market_avg']
        # Simple calculation: if our value score is higher than average, we can charge more
        if 'avg_value_score' in price_statistics and price_statistics['avg_value_score'] > 60:
            ideal_price_range = {
                'min': market_avg * decimal.Decimal('0.95'),
                'max': market_avg * decimal.Decimal('1.15'),
                'recommended': market_avg * decimal.Decimal('1.05')
            }
        elif 'avg_value_score' in price_statistics and price_statistics['avg_value_score'] < 40:
            ideal_price_range = {
                'min': market_avg * decimal.Decimal('0.85'),
                'max': market_avg * decimal.Decimal('0.95'),
                'recommended': market_avg * decimal.Decimal('0.9')
            }
        else:
            ideal_price_range = {
                'min': market_avg * decimal.Decimal('0.9'),
                'max': market_avg * decimal.Decimal('1.1'),
                'recommended': market_avg
            }
    
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
        'competitor_prices': competitor_prices,
        'competitor_types_summary': competitor_types_summary,
        'competitor_type_labels': competitor_type_labels,
        'competitor_type_prices': competitor_type_prices,
        'competitor_type_counts': competitor_type_counts,
        'price_recommendations': price_recommendations,
        'ideal_price_range': ideal_price_range
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
    
    # If no room type is selected but we have room types available, select the first one
    if not data['selected_room_type'] and data['room_types'].exists():
        # Get the first room type
        first_room_type = data['room_types'].first()
        
        # Redirect to the same page with the room type selected
        redirect_url = f"{request.path}?room_type_id={first_room_type.id}"
        if data['selected_hotel_id']:
            redirect_url += f"&hotel_id={data['selected_hotel_id']}"
        if data['selected_category_id']:
            redirect_url += f"&category_id={data['selected_category_id']}"
        if data['period']:
            redirect_url += f"&period={data['period']}"
        
        from django.shortcuts import redirect
        return redirect(redirect_url)
    
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
        'competitor_types_summary': data.get('competitor_types_summary', {}),
        'competitor_type_labels': data.get('competitor_type_labels', []),
        'competitor_type_prices': data.get('competitor_type_prices', []),
        'competitor_type_counts': data.get('competitor_type_counts', []),
        'price_recommendations': data.get('price_recommendations', []),
        'ideal_price_range': data.get('ideal_price_range', {}),
        'opts': RoomType._meta,
        'has_view_permission': True,
        'pdf_export_url': reverse('rooms:price-analysis-report-export-pdf')
    })
    
    return TemplateResponse(request, 'admin/rooms/room/price_analysis_report.html', context)

def export_price_analysis_pdf(request):
    """
    Export the enhanced price analysis report as a PDF with additional insights and recommendations.

    Args:
        request: The HTTP request object

    Returns:
        HttpResponse: The enhanced PDF response with insights
    """
    data = get_price_analysis_data(request)
    selected_room_type = data['selected_room_type']
    competitor_data = data['competitor_data']
    price_statistics = data['price_statistics']
    period = data['period']
    price_recommendations = data.get('price_recommendations', [])
    ideal_price_range = data.get('ideal_price_range', {})
    competitor_types_summary = data.get('competitor_types_summary', {})

    if not selected_room_type:
        # Return an empty PDF if no room type is selected
        return generate_pdf_report(
            str(_('تقرير تحليل الأسعار')),
            [str(_('الفندق')), str(_('نوع الغرفة')), str(_('السعر')), str(_('الفرق'))],
            [],
            []
        )

    # Define headers for the PDF table - convert translation proxies to strings
    headers = [
        str(_('الفندق')),
        str(_('نوع الغرفة')),
        str(_('نوع المنافس')),
        str(_('السعر')),
        str(_('الفرق')),
        str(_('نسبة الفرق %')),
        str(_('مؤشر القيمة')),
        str(_('التوصية'))
    ]

    # Prepare data rows
    data_rows = []

    # Add the selected room type as the first row with highlighted formatting
    data_rows.append([
        selected_room_type.hotel.name,
        selected_room_type.name,
        str(_('الفندق الحالي')),
        f"{selected_room_type.base_price:.2f}",
        "0.00",
        "0.00%",
        "100",
        str(_('السعر المرجعي'))
    ])

    # Add competitor data with enhanced information
    for comp in competitor_data:
        price_diff = comp['price_difference']
        price_diff_percent = comp['price_difference_percent']
        
        # Get competitor type and value score
        competitor_type = comp.get('competitor_type', str(_('منافس مباشر')))
        value_score = comp.get('value_score', 50)
        recommendation = comp.get('recommendation', '')

        data_rows.append([
            comp['hotel_name'],
            comp['room_type_name'],
            competitor_type,
            f"{comp['price']:.2f}",
            f"{price_diff:.2f}",
            f"{price_diff_percent:.2f}%",
            f"{value_score}",
            recommendation
        ])

    # Create report title - convert translation proxies to strings
    report_title = str(_('تقرير تحليل الأسعار المحسن'))

    # Add room type info to title
    report_title += f" - {selected_room_type.hotel.name} - {selected_room_type.name}"

    # Add period to title
    report_title += f" ({str(_('آخر'))} {period} {str(_('يوم'))})"
    
    # Create metadata for subtitle and statistics
    metadata = {
        'subtitle': str(_('تحليل تنافسي للأسعار مع توصيات التسعير')),
        'statistics': []
    }
    
    # Add market position information
    if price_statistics and 'market_position_text' in price_statistics:
        metadata['statistics'].append(
            f"{str(_('موقع السعر'))}: {price_statistics['market_position_text']}"
        )
    
    # Add price statistics
    if price_statistics:
        metadata['statistics'].append(
            f"{str(_('السعر الحالي'))}: {price_statistics.get('current_price', 0):.2f} | "
            f"{str(_('متوسط السوق'))}: {price_statistics.get('market_avg', 0):.2f}"
        )
        metadata['statistics'].append(
            f"{str(_('الحد الأدنى للسوق'))}: {price_statistics.get('market_min', 0):.2f} | "
            f"{str(_('الحد الأقصى للسوق'))}: {price_statistics.get('market_max', 0):.2f}"
        )
    
    # Add value score if available
    if price_statistics and 'avg_value_score' in price_statistics:
        metadata['statistics'].append(
            f"{str(_('متوسط مؤشر القيمة'))}: {price_statistics['avg_value_score']:.1f}/100"
        )
    
    # Add ideal price range if available
    if ideal_price_range:
        metadata['statistics'].append(
            f"{str(_('نطاق السعر المثالي'))}: {ideal_price_range.get('min', 0):.2f} - {ideal_price_range.get('max', 0):.2f}"
        )
        if 'recommended' in ideal_price_range:
            metadata['statistics'].append(
                f"{str(_('السعر الموصى به'))}: {ideal_price_range['recommended']:.2f}"
            )
    
    # Add price recommendations
    if price_recommendations:
        metadata['statistics'].append(str(_('التوصيات:')))
        for i, rec in enumerate(price_recommendations[:3], 1):  # Limit to top 3 recommendations
            metadata['statistics'].append(f"{i}. {rec}")

    # Define column widths
    available_width = landscape(A4)[0] - 60  # A4 landscape width minus margins
    col_widths = [
        available_width * 0.15,  # الفندق
        available_width * 0.15,  # نوع الغرفة
        available_width * 0.12,  # نوع المنافس
        available_width * 0.10,  # السعر
        available_width * 0.10,  # الفرق
        available_width * 0.10,  # نسبة الفرق %
        available_width * 0.08,  # مؤشر القيمة
        available_width * 0.20   # التوصية
    ]

    # Generate and return the PDF report with RTL support
    return generate_pdf_report(report_title, headers, data_rows, col_widths=col_widths, rtl=True, metadata=metadata)
