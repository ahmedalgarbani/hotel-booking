from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Sum
from datetime import date, timedelta
from reportlab.lib.pagesizes import A4

from payments.models import Payment
from bookings.admin_classes.mixins import generate_pdf_report


def get_filtered_revenue_data(request):
    """
    Get filtered payment data for revenue summary report.

    Args:
        request: The HTTP request object

    Returns:
        tuple: (total_revenue, revenue_by_method_list, start_date_str, end_date_str)
    """
    today = date.today()
    default_start_date = today - timedelta(days=30)
    start_date_str = request.GET.get('start_date', default_start_date.strftime('%Y-%m-%d'))
    end_date_str = request.GET.get('end_date', today.strftime('%Y-%m-%d'))

    try:
        start_date = date.fromisoformat(start_date_str)
        end_date = date.fromisoformat(end_date_str)
        # Add one day to end_date to include the entire end date in the range
        end_date_exclusive = end_date + timedelta(days=1)
    except ValueError:
        # Handle invalid date format
        start_date = default_start_date
        end_date = today
        end_date_exclusive = end_date + timedelta(days=1)
        start_date_str = start_date.strftime('%Y-%m-%d')
        end_date_str = end_date.strftime('%Y-%m-%d')

    # Get queryset based on user permissions
    queryset = Payment.objects.all()

    # Apply user permissions filtering if needed
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                queryset = queryset.filter(payment_method__hotel__manager=request.user)
            elif request.user.user_type == 'hotel_staff':
                queryset = queryset.filter(payment_method__hotel__manager=request.user.chield)

    # Apply date filtering using the correct range
    confirmed_payments = queryset.filter(
        payment_status=1,
        payment_date__gte=start_date,  # Greater than or equal to start date (midnight)
        payment_date__lt=end_date_exclusive  # Less than the start of the next day
    ).select_related('payment_method', 'payment_method__payment_option', 'payment_method__payment_option__currency')

    total_revenue = confirmed_payments.aggregate(total=Sum('payment_totalamount'))['total'] or 0.00

    # Group by payment method and currency
    revenue_by_method_dict = {}
    for payment in confirmed_payments:
        # Default values
        method_name = _("غير معروف")
        currency_name = _("غير معروف")
        currency_symbol = ""

        # Try to get the actual values
        try:
            if payment.payment_method and payment.payment_method.payment_option:
                method_name = payment.payment_method.payment_option.method_name
                if payment.payment_method.payment_option.currency:
                    currency_name = payment.payment_method.payment_option.currency.currency_name
                    currency_symbol = payment.payment_method.payment_option.currency.currency_symbol
        except Exception:
            # Handle any potential errors in the relationship chain
            print(f"Warning: Incomplete payment relationship for Payment ID {payment.id}")
            pass  # Keep default "N/A" or "" values

        # Use a tuple of the retrieved values as the key
        group_key = (method_name, currency_name, currency_symbol)

        if group_key not in revenue_by_method_dict:
            revenue_by_method_dict[group_key] = {'method_total': 0, 'method_count': 0}

        revenue_by_method_dict[group_key]['method_total'] += payment.payment_totalamount
        revenue_by_method_dict[group_key]['method_count'] += 1

    # Convert the dictionary to a list of dictionaries for the template/PDF
    revenue_by_method_list = []
    for key, value in revenue_by_method_dict.items():
        revenue_by_method_list.append({
            # Use the actual values from the key tuple for consistency
            'payment_method__payment_option__method_name': key[0],
            'payment_method__payment_option__currency__currency_name': key[1],
            'payment_method__payment_option__currency__currency_symbol': key[2],
            'method_total': value['method_total'],
            'method_count': value['method_count']
        })

    # Sort the list (optional, but good for consistency)
    revenue_by_method_list.sort(key=lambda x: x['method_total'], reverse=True)

    # Return the list and the date strings used for display/links
    return total_revenue, revenue_by_method_list, start_date_str, end_date_str


def revenue_summary_view(request):
    """
    Display the revenue summary report view.

    Args:
        request: The HTTP request object

    Returns:
        TemplateResponse: The rendered template response
    """
    total_revenue, revenue_by_method, start_date_str, end_date_str = get_filtered_revenue_data(request)

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
        'title': _('ملخص الإيرادات'),
        'total_revenue': total_revenue,
        'revenue_by_method': revenue_by_method,  # Use the list from helper
        'start_date': start_date_str,  # Use date string from helper
        'end_date': end_date_str,      # Use date string from helper
        'opts': Payment._meta,
        'has_view_permission': True,  # This will be checked at the URL level
        # Add PDF export URL to context
        'pdf_export_url': reverse('payments:revenue-summary-export-pdf')
    })

    # --- Template ---
    # Make sure this template path is correct
    return TemplateResponse(request, 'admin/payments/payment/revenue_summary_report.html', context)


def export_revenue_summary_pdf(request):
    """
    Export the revenue summary report as a PDF.

    Args:
        request: The HTTP request object

    Returns:
        HttpResponse: The PDF response
    """
    # Use the refactored helper method
    total_revenue, revenue_by_method, start_date_str, end_date_str = get_filtered_revenue_data(request)

    # Use Arabic strings directly within gettext_lazy
    headers = [
        _("طريقة الدفع"), _("عدد المدفوعات"), _("إجمالي الإيرادات"), _("العملة")
    ]
    # Use the correct keys based on the list structure created in the helper
    data = [[
        item['payment_method__payment_option__method_name'],
        item['method_count'],
        f"{item['method_total']:.2f}",  # Format as currency string
        item['payment_method__payment_option__currency__currency_name']  # Use currency name
    ] for item in revenue_by_method]

    # Add total row
    data.append([
        _("الإجمالي"), "", f"{total_revenue:.2f}", ""  # Translate "Total"
    ])

    report_title = _('تقرير ملخص الإيرادات')  # Translate title as well
    report_title += f" ({start_date_str} - {end_date_str})"

    # Define column widths (adjust as needed)
    available_width = A4[0] - 60  # A4 width minus margins
    col_widths = [
        available_width * 0.35, available_width * 0.20, available_width * 0.25, available_width * 0.20
    ]

    return generate_pdf_report(report_title, headers, data, col_widths=col_widths)
