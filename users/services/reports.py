from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Count, Sum, F, Q, Max
from datetime import date, timedelta
from reportlab.lib.pagesizes import landscape, A4

from django.contrib.auth import get_user_model
from bookings.models import Booking
from payments.models import Payment
from bookings.admin_classes.mixins import generate_pdf_report

User = get_user_model()

def get_vip_customers_data(request):
    """
    Get data for VIP customers report with enhanced luxury features.
    """
    today = date.today()
    period = request.GET.get('period', 'yearly')
    sort_by = request.GET.get('sort_by', 'bookings')
    hotel_id = request.GET.get('hotel_id')
    show_premium = request.GET.get('show_premium', 'yes') == 'yes'

    # Define date ranges based on period
    if period == 'monthly':
        start_date = today - timedelta(days=30)
    elif period == 'quarterly':
        start_date = today - timedelta(days=90)
    elif period == 'half_yearly':
        start_date = today - timedelta(days=180)
    else:  # yearly (default)
        start_date = today - timedelta(days=365)

    # Base queryset for customers
    customers_qs = User.objects.filter(user_type='customer')

    # Apply hotel filter if provided
    hotel_filter = Q()
    if hotel_id and hotel_id.isdigit():
        hotel_filter = Q(bookings__hotel_id=int(hotel_id))

    # Apply user permissions filtering if needed
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                hotel_filter &= Q(bookings__hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                hotel_filter &= Q(bookings__hotel__manager=request.user.chield)

    # Filter bookings by date range
    date_filter = Q(bookings__check_in_date__gte=start_date) & Q(bookings__check_in_date__lte=today)

    # Combine filters
    combined_filter = hotel_filter & date_filter

    # Annotate customers with booking count and total spending
    customers_with_stats = customers_qs.filter(combined_filter).annotate(
        booking_count=Count('bookings', distinct=True),
        total_spent=Sum('payments__payment_totalamount'),
        avg_booking_value=Sum('payments__payment_totalamount') / Count('bookings', distinct=True),
        last_booking_date=Max('bookings__check_in_date')
    ).filter(booking_count__gt=0)

    # Sort customers based on user preference
    if sort_by == 'spending':
        customers_with_stats = customers_with_stats.order_by('-total_spent')
    else:  # default: sort by booking count
        customers_with_stats = customers_with_stats.order_by('-booking_count')

    # Limit to top 50 customers
    customers_with_stats = customers_with_stats[:50]

    # Get hotels for filter dropdown
    from HotelManagement.models import Hotel
    hotels = Hotel.objects.all()
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                hotels = hotels.filter(manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                hotels = hotels.filter(manager=request.user.chield)

    # Calculate loyalty scores and spending trends for each customer
    from datetime import datetime
    today_date = datetime.now().date()
    
    for customer in customers_with_stats:
        # Calculate recency score (0-100)
        if customer.last_booking_date:
            # Convert datetime to date if needed
            if hasattr(customer.last_booking_date, 'date'):
                last_booking_date = customer.last_booking_date.date()
            else:
                last_booking_date = customer.last_booking_date
                
            days_since_last_booking = (today_date - last_booking_date).days
            recency_score = max(0, 100 - min(days_since_last_booking, 365) / 3.65)
        else:
            recency_score = 0
            
        # Calculate frequency score (0-100)
        frequency_score = min(customer.booking_count * 10, 100)
        
        # Calculate monetary score (0-100)
        monetary_value = float(customer.total_spent) if customer.total_spent else 0
        monetary_score = min(monetary_value / 100, 100)
        
        # Calculate overall loyalty score (0-100)
        customer.loyalty_score = int((recency_score * 0.35) + (frequency_score * 0.35) + (monetary_score * 0.3))
        
        # Determine customer tier based on loyalty score
        if customer.loyalty_score >= 80:
            customer.tier = 'platinum'
            customer.tier_arabic = 'بلاتيني'
        elif customer.loyalty_score >= 60:
            customer.tier = 'gold'
            customer.tier_arabic = 'ذهبي'
        elif customer.loyalty_score >= 40:
            customer.tier = 'silver'
            customer.tier_arabic = 'فضي'
        elif customer.loyalty_score >= 20:
            customer.tier = 'bronze'
            customer.tier_arabic = 'برونزي'
        else:
            customer.tier = 'regular'
            customer.tier_arabic = 'عادي'
    
    # Prepare data for charts
    customer_names = [f"{c.first_name} {c.last_name}" if c.first_name and c.last_name else c.username for c in customers_with_stats[:10]]
    booking_counts = [c.booking_count for c in customers_with_stats[:10]]
    spending_amounts = [float(c.total_spent) if c.total_spent else 0 for c in customers_with_stats[:10]]
    loyalty_scores = [c.loyalty_score for c in customers_with_stats[:10]]

    # Calculate average loyalty score and spending
    avg_loyalty_score = sum(c.loyalty_score for c in customers_with_stats) / len(customers_with_stats) if customers_with_stats else 0
    total_spending = sum(float(c.total_spent) if c.total_spent else 0 for c in customers_with_stats)
    
    # Get tier distribution
    tier_distribution = {
        'platinum': len([c for c in customers_with_stats if c.tier == 'platinum']),
        'gold': len([c for c in customers_with_stats if c.tier == 'gold']),
        'silver': len([c for c in customers_with_stats if c.tier == 'silver']),
        'bronze': len([c for c in customers_with_stats if c.tier == 'bronze']),
        'regular': len([c for c in customers_with_stats if c.tier == 'regular'])
    }
    
    return {
        'customers': customers_with_stats,
        'period': period,
        'sort_by': sort_by,
        'hotels': hotels,
        'selected_hotel_id': hotel_id,
        'customer_names': customer_names,
        'booking_counts': booking_counts,
        'spending_amounts': spending_amounts,
        'loyalty_scores': loyalty_scores,
        'start_date': start_date.strftime('%Y-%m-%d'),
        'end_date': today.strftime('%Y-%m-%d'),
        'avg_loyalty_score': int(avg_loyalty_score),
        'total_spending': total_spending,
        'tier_distribution': tier_distribution,
        'show_premium': show_premium
    }

def vip_customers_report_view(request):
    """
    Display the VIP customers report view.
    """
    data = get_vip_customers_data(request)

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
        'title': _('تقرير العملاء المميزين - النسخة الفاخرة'),
        'customers': data['customers'],
        'period': data['period'],
        'sort_by': data['sort_by'],
        'hotels': data['hotels'],
        'selected_hotel_id': data['selected_hotel_id'],
        'customer_names': data['customer_names'],
        'booking_counts': data['booking_counts'],
        'spending_amounts': data['spending_amounts'],
        'loyalty_scores': data['loyalty_scores'],
        'start_date': data['start_date'],
        'end_date': data['end_date'],
        'avg_loyalty_score': data['avg_loyalty_score'],
        'total_spending': data['total_spending'],
        'tier_distribution': data['tier_distribution'],
        'show_premium': data['show_premium'],
        'opts': User._meta,
        'has_view_permission': True,
        'pdf_export_url': reverse('users:vip-customers-report-export-pdf')
    })

    return TemplateResponse(request, 'admin/users/user/vip_customers_report.html', context)


def export_vip_customers_pdf(request):
    """
    Export the VIP customers report as a PDF.

    Args:
        request: The HTTP request object

    Returns:
        HttpResponse: The PDF response
    """
    data = get_vip_customers_data(request)
    customers = data['customers']
    period = data['period']
    sort_by = data['sort_by']
    start_date = data['start_date']
    end_date = data['end_date']

    # Define headers for the PDF table
    headers = [
        _('الترتيب'),
        _('اسم العميل'),
        _('البريد الإلكتروني'),
        _('رقم الهاتف'),
        _('عدد الحجوزات'),
        _('إجمالي الإنفاق'),
        _('درجة الولاء'),
        _('تصنيف العميل'),
        _('متوسط قيمة الحجز')
    ]

    # Prepare data rows
    data_rows = []
    for i, customer in enumerate(customers, 1):
        # Use the calculated tier from the loyalty score
        rank = _(customer.tier_arabic)

        # Format customer name
        customer_name = customer.get_full_name() if customer.get_full_name() else customer.username

        # Add row data with enhanced information
        avg_booking_value = customer.avg_booking_value if hasattr(customer, 'avg_booking_value') and customer.avg_booking_value else 0
        
        data_rows.append([
            str(i),
            customer_name,
            customer.email,
            customer.phone,
            str(customer.booking_count),
            f"{customer.total_spent or 0:.2f}",
            f"{customer.loyalty_score}/100",
            rank,
            f"{avg_booking_value:.2f}"
        ])

    # Create report title
    report_title = _('تقرير العملاء المميزين - النسخة الفاخرة')

    # Add period to title
    period_labels = {
        'monthly': _('شهري'),
        'quarterly': _('ربع سنوي'),
        'half_yearly': _('نصف سنوي'),
        'yearly': _('سنوي')
    }
    period_text = period_labels.get(period, period_labels['yearly'])
    report_title += f" ({period_text}: {start_date} - {end_date})"

    # Add sort criteria to title
    sort_labels = {
        'bookings': _('عدد الحجوزات'),
        'spending': _('إجمالي الإنفاق')
    }
    sort_text = sort_labels.get(sort_by, sort_labels['bookings'])
    report_title += f" - {_('ترتيب حسب')}: {sort_text}"

    # Define column widths - more compact to fit all columns properly
    available_width = landscape(A4)[0] - 60  # A4 landscape width minus margins
    col_widths = [
        available_width * 0.05,  # الترتيب
        available_width * 0.15,  # اسم العميل
        available_width * 0.15,  # البريد الإلكتروني
        available_width * 0.10,  # رقم الهاتف
        available_width * 0.08,  # عدد الحجوزات
        available_width * 0.10,  # إجمالي الإنفاق
        available_width * 0.08,  # درجة الولاء
        available_width * 0.08,  # تصنيف العميل
        available_width * 0.08   # متوسط قيمة الحجز
    ]

    # Generate and return the PDF report
    return generate_pdf_report(report_title, headers, data_rows, col_widths=col_widths,rtl=True)
