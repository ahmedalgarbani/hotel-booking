from django.contrib import admin
from django.urls import path, reverse
from django.utils import timezone
from django.utils.html import format_html
from django.db.models import Sum, Count
from django.template.response import TemplateResponse
from django.utils.translation import gettext_lazy as _
from datetime import date, timedelta

# Import models
from payments.models import Payment, HotelPaymentMethod, Currency

# Import shared components if needed (adjust path as necessary)
from bookings.admin_classes.mixins import generate_pdf_report # Assuming this is the helper
from reportlab.lib.pagesizes import A4 # Import A4 for PDF generation

# Use your custom admin site if defined, otherwise use default admin.site
try:
    from api.admin import admin_site
except ImportError:
    print("Warning: Custom admin_site from api.admin not found. Using default admin.site.")
    admin_site = admin.site


class PaymentAdmin(admin.ModelAdmin): # Consider inheriting from HotelManagerAdminMixin if applicable
    list_display = [
        'id', 'booking_link', 'user_link', 'payment_method', 'payment_totalamount',
        'payment_currency', 'payment_status_display', 'payment_date', 'payment_type'
    ]
    list_filter = ['payment_status', 'payment_type', 'payment_method__hotel', 'payment_date']
    search_fields = [
        'booking__id', 'user__username', 'user__first_name', 'user__last_name',
        'payment_method__method_name', 'id'
    ]
    readonly_fields = ['payment_subtotal', 'payment_totalamount', 'payment_currency'] # Make calculated fields read-only
    # Add actions if needed, e.g., export selected payments
    # actions = ['export_payments_report']

    # Link to related booking
    def booking_link(self, obj):
        if obj.booking:
            link = reverse("admin:bookings_booking_change", args=[obj.booking.id])
            return format_html('<a href="{}">{} {}</a>', link, _("حجز رقم"), obj.booking.id)
        return "-"
    booking_link.short_description = _("الحجز")
    booking_link.admin_order_field = 'booking'

    # Link to related user
    def user_link(self, obj):
        if obj.user:
            link = reverse("admin:users_customuser_change", args=[obj.user.id]) # Adjust app_label if needed
            return format_html('<a href="{}">{}</a>', link, obj.user.get_full_name() or obj.user.username)
        return "-"
    user_link.short_description = _("المستخدم")
    user_link.admin_order_field = 'user'

    # Display payment status with color
    def payment_status_display(self, obj):
        return format_html(
            '<span style="color: {};">{}</span>',
            obj.get_status_class, # Use property from model
            obj.get_payment_status_display()
        )
    payment_status_display.short_description = _("حالة الدفع")
    payment_status_display.admin_order_field = 'payment_status'

    # Override changelist_view to add context for the report link
    def changelist_view(self, request, extra_context=None):
        extra_context = extra_context or {}
        # Add the URL for the revenue summary report to the context
        extra_context['revenue_summary_url'] = reverse('admin:payment-revenue-summary')
        return super().changelist_view(request, extra_context=extra_context)

    # --- Custom Report Views & URLs ---
    def get_urls(self):
        urls = super().get_urls()
        admin_view = self.admin_site.admin_view if hasattr(self, 'admin_site') else admin.site.admin_view

        custom_urls = [
            path('revenue-summary/', admin_view(self.revenue_summary_view), name='payment-revenue-summary'),
            # Add path for PDF export
            path('revenue-summary/export-pdf/', admin_view(self.export_revenue_summary_pdf), name='payment-revenue-summary-export-pdf'),
        ]
        return custom_urls + urls

    # Helper method to get filtered data (used by both HTML and PDF views)
    def _get_filtered_revenue_data(self, request):
        today = date.today()
        default_start_date = today - timedelta(days=30)
        start_date_str = request.GET.get('start_date', default_start_date.strftime('%Y-%m-%d'))
        end_date_str = request.GET.get('end_date', today.strftime('%Y-%m-%d'))

        try:
            start_date = date.fromisoformat(start_date_str)
            # Add 1 day to end_date for filtering up to the end of the selected day
            # Ensure we compare with the date part of payment_date if it's DateTimeField
            end_date_exclusive = date.fromisoformat(end_date_str) + timedelta(days=1)
        except ValueError:
            start_date = default_start_date
            end_date_exclusive = today + timedelta(days=1)
            start_date_str = start_date.strftime('%Y-%m-%d')
            end_date_str = today.strftime('%Y-%m-%d') # Use today for display if invalid input

        queryset = self.get_queryset(request) if hasattr(self, 'get_queryset') else Payment.objects.all()

        # Apply date filtering using the correct range
        confirmed_payments = queryset.filter(
            payment_status=1,
            payment_date__gte=start_date, # Greater than or equal to start date (midnight)
            payment_date__lt=end_date_exclusive # Less than the start of the next day
        ).select_related('payment_method', 'payment_method__payment_option', 'payment_method__payment_option__currency')

        total_revenue = confirmed_payments.aggregate(total=Sum('payment_totalamount'))['total'] or 0.00

        # --- Grouping in Python instead of using .values().annotate() - Safer attribute access ---
        revenue_by_method_dict = {}
        for payment in confirmed_payments:
            # Safely get related attributes using try-except
            method_name = "N/A"
            currency_name = "N/A"
            currency_symbol = ""
            try:
                # Access attributes sequentially to catch potential None values earlier
                payment_option = payment.payment_method.payment_option
                method_name = payment_option.method_name
                currency = payment_option.currency
                currency_name = currency.currency_name
                currency_symbol = currency.currency_symbol
            except AttributeError:
                # Handle cases where payment_method, payment_option, or currency might be None
                # or don't have the expected attributes.
                print(f"Warning: Incomplete payment relationship for Payment ID {payment.id}")
                pass # Keep default "N/A" or "" values

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
        # --- End of Python grouping ---

        # Return the list and the date strings used for display/links
        return total_revenue, revenue_by_method_list, start_date_str, end_date_str

    def revenue_summary_view(self, request):
        # Use the refactored helper method to get data and display dates
        total_revenue, revenue_by_method, start_date_str, end_date_str = self._get_filtered_revenue_data(request)

        # --- Context ---
        context = self.admin_site.each_context(request)
        context.update({
            'title': _('ملخص الإيرادات'),
            'total_revenue': total_revenue,
            'revenue_by_method': revenue_by_method, # Use the list from helper
            'start_date': start_date_str, # Use date string from helper
            'end_date': end_date_str,     # Use date string from helper
            'opts': self.model._meta,
            'has_view_permission': self.has_view_permission(request),
            # Add PDF export URL to context
            'pdf_export_url': reverse('admin:payment-revenue-summary-export-pdf')
        })

        # --- Template ---
        # Ensure this template path is correct
        return TemplateResponse(request, 'admin/payments/payment/revenue_summary_report.html', context)


    # PDF export function
    def export_revenue_summary_pdf(self, request):
        # Use the refactored helper method
        total_revenue, revenue_by_method, start_date_str, end_date_str = self._get_filtered_revenue_data(request)

        # Use Arabic strings directly within gettext_lazy
        headers = [
            _("طريقة الدفع"), _("عدد المدفوعات"), _("إجمالي الإيرادات"), _("العملة")
        ]
        # Use the correct keys based on the list structure created in the helper
        data = [[
            item['payment_method__payment_option__method_name'],
            item['method_count'],
            f"{item['method_total']:.2f}", # Format as currency string
            item['payment_method__payment_option__currency__currency_name'] # Use currency name
        ] for item in revenue_by_method]

        # Add total row
        data.append([
            _("الإجمالي"), "", f"{total_revenue:.2f}", "" # Translate "Total"
        ])

        report_title = _('تقرير ملخص الإيرادات') # Translate title as well
        report_title += f" ({start_date_str} - {end_date_str})"

        # Define column widths (adjust as needed)
        available_width = A4[0] - 60 # A4 width minus margins
        col_widths = [
            available_width * 0.35, available_width * 0.20, available_width * 0.25, available_width * 0.20
        ]

        return generate_pdf_report(report_title, headers, data, col_widths=col_widths)

# Note: Registration happens in payments/admin.py
# admin_site.register(Payment, PaymentAdmin)
