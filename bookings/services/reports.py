from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Q, Sum
from django.shortcuts import get_object_or_404
from datetime import date, timedelta
from reportlab.lib.pagesizes import landscape, A4

from django.contrib.auth import get_user_model
from bookings.models import Booking
from bookings.admin_classes.mixins import generate_pdf_report

User = get_user_model()


def get_filtered_daily_bookings(request):
    """
    Get filtered booking data for daily report.

    Args:
        request: The HTTP request object

    Returns:
        tuple: (filtered_bookings, start_date_str, end_date_str, customer_id)
    """
    today = date.today()
    start_date_str = request.GET.get('start_date', today.strftime('%Y-%m-%d'))
    end_date_str = request.GET.get('end_date', today.strftime('%Y-%m-%d'))
    customer_id = request.GET.get('customer_id')

    try:
        start_date = date.fromisoformat(start_date_str)
        end_date = date.fromisoformat(end_date_str) + timedelta(days=1)
    except ValueError:
        start_date = today
        end_date = today + timedelta(days=1)
        start_date_str = start_date.strftime('%Y-%m-%d')
        end_date_str = (end_date - timedelta(days=1)).strftime('%Y-%m-%d')

    # Apply user permissions filtering if needed
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                queryset = Booking.objects.filter(hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                queryset = Booking.objects.filter(hotel__manager=request.user.chield)
            else:
                queryset = Booking.objects.all()
        else:
            queryset = Booking.objects.all()
    else:
        queryset = Booking.objects.all()

    filters = Q(check_in_date__gte=start_date) & Q(check_in_date__lt=end_date)
    if customer_id and customer_id.isdigit():
        filters &= Q(user_id=int(customer_id))
    else:
        customer_id = ''

    filtered_bookings_qs = queryset.filter(filters)\
        .select_related('hotel', 'user', 'room')\
        .prefetch_related('payments')\
        .annotate(total_paid=Sum('payments__payment_totalamount'))\
        .order_by('check_in_date')

    processed_bookings = []
    for booking in filtered_bookings_qs:
        latest_payment = booking.payments.order_by('-payment_date').first()
        booking.latest_payment_status_display = latest_payment.get_payment_status_display() if latest_payment else _("لا توجد دفعات")
        booking.total_paid = booking.total_paid or 0.00
        processed_bookings.append(booking)

    return processed_bookings, start_date_str, end_date_str, customer_id


def daily_report_view(request):
    """
    Display the daily bookings report view.

    Args:
        request: The HTTP request object

    Returns:
        TemplateResponse: The rendered template response
    """
    filtered_bookings, start_date_str, end_date_str, customer_id = get_filtered_daily_bookings(request)
    customers = User.objects.filter(user_type='customer').order_by('username')

    bookings_by_day = {}
    for booking in filtered_bookings:
        # Ensure check_in_date is not None before accessing .date()
        if booking.check_in_date:
            day = booking.check_in_date.date()
            if day not in bookings_by_day:
                bookings_by_day[day] = []
            bookings_by_day[day].append(booking)

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
        'title': _('تقرير الحجوزات اليومي'),
        'bookings_by_day': bookings_by_day,
        'start_date': start_date_str,
        'end_date': end_date_str,
        'customers': customers,
        'selected_customer_id': customer_id,
        'opts': Booking._meta,
        'has_view_permission': True,  # This will be checked at the URL level
        'pdf_export_url': reverse('bookings:daily-report-export-pdf')
    })

    return TemplateResponse(request, 'admin/bookings/booking/daily_bookings_report.html', context)


def export_daily_report_pdf(request):
    """
    Export the daily bookings report as a PDF.

    Args:
        request: The HTTP request object

    Returns:
        HttpResponse: The PDF response
    """
    filtered_bookings, start_date_str, end_date_str, customer_id = get_filtered_daily_bookings(request)

    headers = [
        _("رقم الحجز"), _("الفندق"), _("العميل"), _("الغرفة"), _("تاريخ الوصول"),
        _("تاريخ المغادرة"), _("إجمالي المدفوعات"), _("حالة الحجز"), _("حالة الدفع")
    ]

    data = [[
        b.id, b.hotel.name, b.user.get_full_name() or b.user.username, b.room.name,
        b.check_in_date.strftime('%Y-%m-%d %H:%M') if b.check_in_date else '',
        b.check_out_date.strftime('%Y-%m-%d %H:%M') if b.check_out_date else '',
        f"{b.total_paid:.2f}", b.get_status_display(), b.latest_payment_status_display
    ] for b in filtered_bookings]

    report_title = _('تقرير الحجوزات اليومي')
    if start_date_str == end_date_str:
        report_title += f" - {start_date_str}"
    else:
        report_title += f" ({start_date_str} - {end_date_str})"

    if customer_id:
        try:
            customer = User.objects.get(id=int(customer_id))
            report_title += f" - {_('العميل')}: {customer.get_full_name() or customer.username}"
        except (User.DoesNotExist, ValueError):
            pass

    available_width = landscape(A4)[0] - 60
    col_widths = [
        available_width * 0.08, available_width * 0.15, available_width * 0.15, available_width * 0.12,
        available_width * 0.12, available_width * 0.12, available_width * 0.10, available_width * 0.08,
        available_width * 0.08
    ]

    return generate_pdf_report(report_title, headers, data, col_widths=col_widths)


def export_bookings_report(queryset):
    """
    Generate a PDF report for selected bookings.

    Args:
        queryset: QuerySet of Booking objects

    Returns:
        HttpResponse: The PDF response
    """
    headers = [
        _("اسم الضيف"), _("الفندق"), _("الغرفة"), _("تاريخ الدخول"),
        _("تاريخ الخروج"), _("المبلغ"), _("الحالة")
    ]

    data = []
    for booking in queryset.select_related('hotel', 'room').prefetch_related('guests'):
        guest = booking.guests.first()
        data.append([
            guest.name if guest else "-",
            booking.hotel.name,
            booking.room.name,
            booking.check_in_date.strftime('%Y-%m-%d %H:%M') if booking.check_in_date else '',
            booking.check_out_date.strftime('%Y-%m-%d %H:%M') if booking.check_out_date else '',
            f"{booking.amount:.2f}",
            booking.get_status_display()
        ])

    return generate_pdf_report(_('تقرير_الحجوزات_المحدد'), headers, data)
