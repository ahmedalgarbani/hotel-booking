from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Count, Sum, F, Q
from datetime import date, timedelta
from reportlab.lib.pagesizes import landscape, A4

from django.contrib.auth import get_user_model
from bookings.models import Booking
from payments.models import Payment
from bookings.admin_classes.mixins import generate_pdf_report

User = get_user_model()

def get_vip_customers_data(request):
    """
    Get data for VIP customers report.
    """
    today = date.today()
    period = request.GET.get('period', 'yearly')
    sort_by = request.GET.get('sort_by', 'bookings')
    hotel_id = request.GET.get('hotel_id')

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
        total_spent=Sum('payments__payment_totalamount')
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

    # Prepare data for charts
    customer_names = [f"{c.first_name} {c.last_name}" if c.first_name and c.last_name else c.username for c in customers_with_stats[:10]]
    booking_counts = [c.booking_count for c in customers_with_stats[:10]]
    spending_amounts = [float(c.total_spent) if c.total_spent else 0 for c in customers_with_stats[:10]]

    return {
        'customers': customers_with_stats,
        'period': period,
        'sort_by': sort_by,
        'hotels': hotels,
        'selected_hotel_id': hotel_id,
        'customer_names': customer_names,
        'booking_counts': booking_counts,
        'spending_amounts': spending_amounts,
        'start_date': start_date.strftime('%Y-%m-%d'),
        'end_date': today.strftime('%Y-%m-%d')
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
        'title': _('تقرير العملاء المميزين'),
        'customers': data['customers'],
        'period': data['period'],
        'sort_by': data['sort_by'],
        'hotels': data['hotels'],
        'selected_hotel_id': data['selected_hotel_id'],
        'customer_names': data['customer_names'],
        'booking_counts': data['booking_counts'],
        'spending_amounts': data['spending_amounts'],
        'start_date': data['start_date'],
        'end_date': data['end_date'],
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
        _('تصنيف العميل')
    ]

    # Prepare data rows
    data_rows = []
    for i, customer in enumerate(customers, 1):
        # Determine customer rank
        if i <= 5:
            rank = _('ذهبي')
        elif i <= 15:
            rank = _('فضي')
        elif i <= 30:
            rank = _('برونزي')
        else:
            rank = _('عادي')

        # Format customer name
        customer_name = customer.get_full_name() if customer.get_full_name() else customer.username

        # Add row data
        data_rows.append([
            str(i),
            customer_name,
            customer.email,
            customer.phone,
            str(customer.booking_count),
            f"{customer.total_spent or 0:.2f}",
            rank
        ])

    # Create report title
    report_title = _('تقرير العملاء المميزين')

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

    # Define column widths
    available_width = landscape(A4)[0] - 60  # A4 landscape width minus margins
    col_widths = [
        available_width * 0.07,  # الترتيب
        available_width * 0.20,  # اسم العميل
        available_width * 0.20,  # البريد الإلكتروني
        available_width * 0.13,  # رقم الهاتف
        available_width * 0.10,  # عدد الحجوزات
        available_width * 0.15,  # إجمالي الإنفاق
        available_width * 0.15   # تصنيف العميل
    ]

    # Generate and return the PDF report
    return generate_pdf_report(report_title, headers, data_rows, col_widths=col_widths)
