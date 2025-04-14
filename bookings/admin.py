from datetime import datetime, timedelta, date
from pyexpat.errors import messages
from django.contrib import admin
from django.db.models import Count, Q, Sum
from django.db.models.functions import TruncDay, TruncHour
from django.http import HttpResponse, JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import path, reverse
from django.utils import timezone
import arabic_reshaper
from bidi.algorithm import get_display
from django.utils.translation import gettext_lazy as _
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from django.utils import timezone
from bookings.forms import BookingAdminForm, BookingExtensionForm
from rooms.models import Availability, RoomStatus
from .models import Booking, BookingHistory, Guest, BookingDetail
from HotelManagement.models import Hotel
from rooms.models import RoomType
from django.db.models import Q, Sum
from rooms.services import get_room_price
from .models import Booking, ExtensionMovement, Guest, BookingDetail
from django import forms
from django.contrib.admin.helpers import ActionForm
from django.utils.html import format_html
from django.db import transaction
from django.template.response import TemplateResponse
from django.contrib.auth import get_user_model
User = get_user_model()

class AutoUserTrackMixin:
    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)

class HotelManagerAdminMixin:

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        user = request.user
        if user.is_superuser or user.user_type == 'admin':
             return qs # Superuser/admin sees all
        elif user.user_type == 'hotel_manager':
             # Manager sees bookings for their hotel only
             if hasattr(user, 'hotel_set') and user.hotel_set.exists():
                 return qs.filter(hotel=user.hotel_set.first())
             else:
                 return qs.none() # Manager not linked to a hotel
        elif user.user_type == 'hotel_staff':
             # Staff sees bookings for their manager's hotel
             # Assuming 'chield' on the manager points to staff is incorrect.
             # Assuming staff user has a ForeignKey 'assigned_hotel' or similar
             if hasattr(user, 'assigned_hotel'): # Replace 'assigned_hotel' with your actual field
                 return qs.filter(hotel=user.assigned_hotel)
             # Fallback: Check if staff is linked via a manager's 'chield' field (less ideal)
             elif hasattr(user, 'manager_attr') and hasattr(user.manager_attr, 'hotel_set') and user.manager_attr.hotel_set.exists(): # Replace 'manager_attr'
                 return qs.filter(hotel=user.manager_attr.hotel_set.first())
             else:
                 return qs.none() # Staff not linked correctly
        return qs.none() # Default deny


    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        user = request.user
        if not user.is_superuser and user.user_type != 'admin':
            hotel_query = Q()
            if user.user_type == 'hotel_manager':
                 if hasattr(user, 'hotel_set') and user.hotel_set.exists():
                     hotel_query = Q(pk=user.hotel_set.first().pk)
            elif user.user_type == 'hotel_staff':
                 if hasattr(user, 'assigned_hotel'): # Replace 'assigned_hotel'
                     hotel_query = Q(pk=user.assigned_hotel.pk)
                 elif hasattr(user, 'manager_attr') and hasattr(user.manager_attr, 'hotel_set') and user.manager_attr.hotel_set.exists(): # Replace 'manager_attr'
                     hotel_query = Q(pk=user.manager_attr.hotel_set.first().pk)

            if db_field.name == "hotel":
                kwargs["queryset"] = Hotel.objects.filter(hotel_query)
            elif db_field.name == "room":
                # Filter rooms based on the allowed hotel(s)
                allowed_hotels = Hotel.objects.filter(hotel_query)
                kwargs["queryset"] = RoomType.objects.filter(hotel__in=allowed_hotels)
            elif db_field.name == "room_status":
                 allowed_hotels = Hotel.objects.filter(hotel_query)
                 kwargs["queryset"] = RoomStatus.objects.filter(hotel__in=allowed_hotels)
            elif db_field.name == "parent_booking":
                 allowed_hotels = Hotel.objects.filter(hotel_query)
                 kwargs["queryset"] = Booking.objects.filter(hotel__in=allowed_hotels)

        return super().formfield_for_foreignkey(db_field, request, **kwargs)


    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        user = request.user
        if not user.is_superuser and user.user_type != 'admin':
            # Pre-fill and disable hotel field for managers/staff
            if 'hotel' in form.base_fields:
                 hotel_qs = Hotel.objects.none()
                 if user.user_type == 'hotel_manager':
                     if hasattr(user, 'hotel_set') and user.hotel_set.exists():
                         hotel_qs = Hotel.objects.filter(pk=user.hotel_set.first().pk)
                 elif user.user_type == 'hotel_staff':
                     if hasattr(user, 'assigned_hotel'): # Replace 'assigned_hotel'
                         hotel_qs = Hotel.objects.filter(pk=user.assigned_hotel.pk)
                     elif hasattr(user, 'manager_attr') and hasattr(user.manager_attr, 'hotel_set') and user.manager_attr.hotel_set.exists(): # Replace 'manager_attr'
                          hotel_qs = Hotel.objects.filter(pk=user.manager_attr.hotel_set.first().pk)

                 if hotel_qs.exists():
                     form.base_fields['hotel'].queryset = hotel_qs
                     form.base_fields['hotel'].initial = hotel_qs.first()
                     form.base_fields['hotel'].widget.attrs['disabled'] = True # Use disabled instead of readonly
                     form.base_fields['hotel'].required = False # No need to require if disabled

            # Disable created_by/updated_by fields
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user
                form.base_fields['updated_by'].widget.attrs['disabled'] = True
                form.base_fields['updated_by'].required = False
            if 'created_by' in form.base_fields:
                # Only disable if editing, allow setting on creation if needed (though save_model handles it)
                if obj:
                     form.base_fields['created_by'].widget.attrs['disabled'] = True
                form.base_fields['created_by'].required = False # save_model sets this

        return form

    def get_readonly_fields(self, request, obj=None):
        # Standard readonly fields
        readonly = list(super().get_readonly_fields(request, obj))
        # Add tracking fields if editing
        if obj:
            readonly.extend(['created_at', 'updated_at', 'created_by', 'updated_by', 'deleted_at'])
        # Prevent non-superusers from editing hotel if set
        if obj and not request.user.is_superuser and request.user.user_type != 'admin':
             if 'hotel' not in readonly:
                 readonly.append('hotel')
        return tuple(readonly)


class ChangeStatusForm(ActionForm):
    new_status = forms.ChoiceField(
        choices=[('', '-- اختر الحالة --')] + list(Booking.BookingStatus.choices),
        required=False,
        label="الحالة الجديدة"
    )

class BookingAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    form = BookingAdminForm # Use the custom form if defined
    action_form = ChangeStatusForm
    list_display = [
        'hotel', 'id', 'room', 'check_in_date', 'check_out_date',
        'amount', 'status', 'payment_status_display', 'extend_booking_button', # Changed payment_status to display method
        'set_checkout_today_toggle'
    ]
    list_filter = ['status', 'hotel', 'check_in_date', 'check_out_date']
    search_fields = ['guests__name', 'hotel__name', 'room__name', 'user__username', 'user__first_name', 'user__last_name'] # Added user search
    actions = ['change_booking_status', 'export_bookings_report', 'export_upcoming_bookings', 'export_cancelled_bookings', 'export_peak_times']
    # readonly_fields are handled by get_readonly_fields now

    change_form_template = 'admin/bookings/booking.html'
    change_list_template = 'admin/bookings/booking/change_list.html'

    def payment_status_display(self, obj): # Renamed from payment_status to avoid conflict
        payment = obj.payments.order_by('-payment_date').first() # Get latest payment
        if not payment:
            return format_html('<span style="color: gray;">{}</span>', _("لا توجد دفعات"))
        status_colors = {
            0: 'orange',  # قيد الانتظار
            1: 'green',   # تم الدفع
            2: 'red'      # مرفوض
        }
        return format_html(
            '<span style="color: {};">{}</span>',
            status_colors.get(payment.payment_status, 'black'),
            payment.get_payment_status_display()
        )
    payment_status_display.short_description = _("حالة الدفع")
    payment_status_display.admin_order_field = 'payments__payment_status' # Allow sorting if needed

    def set_checkout_today_toggle(self, obj):
        if obj.actual_check_out_date is not None or obj.status == Booking.BookingStatus.CANCELED:
            return format_html('<span style="color:green; font-weight:bold;">✔ {}</span>', _("تم تسجيل الخروج"))
        # Ensure the URL name is correct (check bookings/urls.py if needed)
        try:
            url = reverse('admin:set_actual_check_out_date', args=[obj.pk]) # Assuming URL is in admin namespace now
        except:
             # Fallback or log error if URL resolution fails
             return _("خطأ في الرابط")
        return format_html(
            '<a class="button btn btn-warning" href="{}">{}</a>',
            url, _("تسجيل الخروج")
        )
    set_checkout_today_toggle.short_description = _('تسجيل الخروج الفعلي')

    def extend_booking_button(self, obj):
        current_date = timezone.now().date() # Compare dates only

        # Check if checkout date is in the past or booking is cancelled/checked out
        if obj.check_out_date.date() < current_date or obj.actual_check_out_date is not None or obj.status == Booking.BookingStatus.CANCELED:
            return format_html('<span style="color:red; font-weight:bold;">✘ {}</span>', _("غير قابل للتمديد"))

        url = reverse('admin:booking-extend', args=[obj.pk])
        return format_html(
            '<a class="button btn btn-success" href="{}" onclick="return showExtensionPopup(this.href);">{}</a>', # Removed form-control class
            url, _("تمديد الحجز")
        )
    extend_booking_button.short_description = _('تمديد الحجز')


    @admin.action(description=_('تغيير حالة الحجوزات المحددة'))
    def change_booking_status(self, request, queryset):
        new_status = request.POST.get('new_status')
        if not new_status:
            self.message_user(request, _("لم يتم اختيار حالة جديدة."), level='warning')
            return

        updated_count = 0
        payment_updated_count = 0
        try:
            with transaction.atomic():
                for booking in queryset:
                    # Add logic here to check if status change is allowed (e.g., cannot confirm a cancelled booking)
                    booking.status = new_status
                    booking.save() # This should trigger signals if any
                    updated_count += 1

                    # Update associated payment status based on booking status change
                    payment = booking.payments.order_by('-payment_date').first()
                    if payment:
                        if new_status == Booking.BookingStatus.CONFIRMED and payment.payment_status != 1:
                            payment.payment_status = 1 # تم الدفع
                            payment.save()
                            payment_updated_count += 1
                        elif new_status == Booking.BookingStatus.CANCELED and payment.payment_status != 2:
                            payment.payment_status = 2 # مرفوض
                            payment.save()
                            payment_updated_count += 1

                status_label = dict(Booking.BookingStatus.choices).get(new_status, new_status)
                success_message = _("تم تغيير حالة %(count)d حجز(ات) إلى '%(status)s'") % {'count': updated_count, 'status': status_label}
                if payment_updated_count > 0:
                    success_message += " " + (_("وتم تحديث حالة %(payment_count)d دفعة مرتبطة.") % {'payment_count': payment_updated_count})
                self.message_user(request, success_message)

        except Exception as e:
            self.message_user(request, _("حدث خطأ أثناء تحديث الحجوزات: {}").format(str(e)), level='error')

    def changelist_view(self, request, extra_context=None):
        extra_context = extra_context or {}
        # Pass URL for daily report to the template context
        extra_context['daily_report_url'] = reverse('admin:booking-daily-report')
        # Pass status choices for the action dropdown
        extra_context['status_choices'] = Booking.BookingStatus.choices
        return super().changelist_view(request, extra_context=extra_context)

    def get_guest_name(self, obj):
        # Display primary guest or count
        guest = obj.guests.first()
        return guest.name if guest else _("لا يوجد ضيف")
    get_guest_name.short_description = _("اسم الضيف")

    # --- PDF Generation Helper ---
    def generate_pdf(self, title, headers, data, col_widths=None):
        response = HttpResponse(content_type='application/pdf')
        # Use URL-safe title for filename
        safe_title = "".join(c if c.isalnum() else "_" for c in title)
        response['Content-Disposition'] = f'attachment; filename="{safe_title}.pdf"'

        doc = SimpleDocTemplate(
            response,
            pagesize=landscape(A4),
            rightMargin=30, leftMargin=30, topMargin=50, bottomMargin=30 # Increased top margin for title
        )

        # Register Arabic font (ensure the path is correct)
        try:
            pdfmetrics.registerFont(TTFont('Arabic', 'static/fonts/NotoKufiArabic-Regular.ttf'))
            base_font_name = 'Arabic'
        except:
            base_font_name = 'Helvetica' # Fallback font
            print("Warning: Arabic font not found. Using Helvetica.")


        styles = getSampleStyleSheet()
        # Custom title style
        title_style = ParagraphStyle(
            'CustomTitle',
            parent=styles['h1'], # Use h1 as base
            fontName=base_font_name,
            fontSize=16,
            alignment=1, # Center alignment = 1 (TA_CENTER)
            spaceAfter=20 # Space after title
        )
        # Custom cell style with right alignment for Arabic
        cell_style = ParagraphStyle(
            'CustomCell',
            parent=styles['Normal'],
            fontName=base_font_name,
            fontSize=9, # Slightly smaller font for more data
            alignment=2, # Right alignment = 2 (TA_RIGHT)
            leading=12 # Line spacing
        )
        # Header cell style
        header_style = ParagraphStyle(
             'CustomHeader',
             parent=cell_style,
             alignment=1, # Center alignment for headers
             fontSize=10
        )

        elements = []

        # Add Title
        reshaped_title = get_display(arabic_reshaper.reshape(title))
        elements.append(Paragraph(reshaped_title, title_style))
        # elements.append(Spacer(1, 10)) # Removed extra spacer

        # Prepare data for the table with Paragraph objects for wrapping and styling
        formatted_data = []
        # Headers
        header_row = [Paragraph(get_display(arabic_reshaper.reshape(str(h))), header_style) for h in headers]
        formatted_data.append(header_row)
        # Data rows
        for row in data:
            row_cells = []
            for cell_value in row:
                # Reshape and apply style, handle None values
                text = str(cell_value) if cell_value is not None else ''
                reshaped_text = get_display(arabic_reshaper.reshape(text))
                row_cells.append(Paragraph(reshaped_text, cell_style))
            formatted_data.append(row_cells)

        # Calculate default column widths if not provided
        if not col_widths:
            num_cols = len(headers)
            available_width = landscape(A4)[0] - doc.leftMargin - doc.rightMargin
            col_widths = [available_width / num_cols] * num_cols

        # Create Table
        table = Table(formatted_data, colWidths=col_widths, repeatRows=1) # Repeat header row
        table.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.white), # Darker header
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.HexColor('#043')),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'), # Center align all cells initially
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'), # Middle vertical align
            ('FONTNAME', (0, 0), (-1, -1), base_font_name), # Apply font to all
            ('FONTSIZE', (0, 0), (-1, 0), 10), # Header font size
            ('BOTTOMPADDING', (0, 0), (-1, 0), 8), # Header padding
            ('FONTSIZE', (0, 1), (-1, -1), 9), # Data font size
            ('BOTTOMPADDING', (0, 1), (-1, -1), 5), # Data padding
            ('TOPPADDING', (0, 1), (-1, -1), 5), # Data padding
            ('GRID', (0, 0), (-1, -1), 0.5, colors.grey), # Grid lines
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.whitesmoke, colors.white]), # Alternating row colors
            # Override alignment for data cells if needed (Paragraph style handles it now)
            # ('ALIGN', (0, 1), (-1, -1), 'RIGHT'),
        ]))

        elements.append(table)
        doc.build(elements)
        return response

    # --- PDF Export Actions ---
    def export_bookings_report(self, request, queryset):
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
        return self.generate_pdf(_('تقرير_الحجوزات_المحدد'), headers, data)
    export_bookings_report.short_description = _("تصدير تقرير الحجوزات المحددة (PDF)")

    # --- Custom Report Views & URLs ---
    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                '<path:object_id>/extend/',
                self.admin_site.admin_view(self.extend_booking),
                name='booking-extend',
            ),
            path(
                'daily-report/',
                self.admin_site.admin_view(self.daily_report_view),
                name='booking-daily-report',
            ),
            path(
                'daily-report/export-pdf/',
                self.admin_site.admin_view(self.export_daily_report_pdf),
                name='booking-daily-report-export-pdf',
            ),
             # Add URL for setting checkout date if not already defined elsewhere
             path(
                 '<int:pk>/set-checkout/',
                 self.admin_site.admin_view(self.set_actual_check_out_date_view), # Assuming view method exists
                 name='set_actual_check_out_date' # Match the reverse used in set_checkout_today_toggle
             ),
        ]
        return custom_urls + urls

    def _get_filtered_daily_bookings(self, request):
        """Helper function to get filtered bookings based on request GET params."""
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
            # Correct end_date_str for display when defaulting
            end_date_str = (end_date - timedelta(days=1)).strftime('%Y-%m-%d')

        queryset = self.get_queryset(request) # Applies manager/staff filtering
        filters = Q(check_in_date__gte=start_date) & Q(check_in_date__lt=end_date)

        if customer_id and customer_id.isdigit():
            filters &= Q(user_id=int(customer_id))
        else:
            customer_id = '' # Ensure it's a string for context

        filtered_bookings_qs = queryset.filter(
            filters
        ).select_related('hotel', 'user', 'room').prefetch_related(
            'payments' # Prefetch payments to optimize getting latest status/sum
        ).annotate(
            total_paid=Sum('payments__payment_totalamount') # Calculate sum using DB aggregation
        ).order_by('check_in_date') # Order for report consistency

        # Process in Python to get latest payment status (difficult to annotate reliably)
        processed_bookings = []
        for booking in filtered_bookings_qs:
            latest_payment = booking.payments.order_by('-payment_date').first()
            booking.latest_payment_status_display = latest_payment.get_payment_status_display() if latest_payment else _("لا توجد دفعات")
            # Use the annotated total_paid, handle None if no payments exist
            booking.total_paid = booking.total_paid or 0.00
            processed_bookings.append(booking)

        return processed_bookings, start_date_str, end_date_str, customer_id

    def daily_report_view(self, request):
        """Displays the daily bookings report page with filters."""
        filtered_bookings, start_date_str, end_date_str, customer_id = self._get_filtered_daily_bookings(request)

        # Get customers for the dropdown filter
        customers = User.objects.filter(user_type='customer').order_by('username')

        # Group bookings by day for template display
        bookings_by_day = {}
        for booking in filtered_bookings:
            day = booking.check_in_date.date()
            if day not in bookings_by_day:
                bookings_by_day[day] = []
            bookings_by_day[day].append(booking)

        context = self.admin_site.each_context(request)
        context.update({
            'title': _('تقرير الحجوزات اليومي'),
            'bookings_by_day': bookings_by_day,
            'start_date': start_date_str,
            'end_date': end_date_str,
            'customers': customers,
            'selected_customer_id': customer_id, # Pass as string
            'opts': self.model._meta,
            'has_view_permission': self.has_view_permission(request),
            # Add URL for PDF export form action
            'pdf_export_url': reverse('admin:booking-daily-report-export-pdf')
        })
        return TemplateResponse(request, 'admin/bookings/booking/daily_bookings_report.html', context)

    def export_daily_report_pdf(self, request):
        """Exports the filtered daily bookings report to PDF."""
        filtered_bookings, start_date_str, end_date_str, customer_id = self._get_filtered_daily_bookings(request)

        headers = [
            _("رقم الحجز"), _("الفندق"), _("العميل"), _("الغرفة"),
            _("تاريخ الوصول"), _("تاريخ المغادرة"), _("إجمالي المدفوعات"),
            _("حالة الحجز"), _("حالة الدفع")
        ]

        data = []
        for booking in filtered_bookings:
            data.append([
                booking.id,
                booking.hotel.name,
                booking.user.get_full_name() or booking.user.username,
                booking.room.name,
                booking.check_in_date.strftime('%Y-%m-%d %H:%M') if booking.check_in_date else '',
                booking.check_out_date.strftime('%Y-%m-%d %H:%M') if booking.check_out_date else '',
                f"{booking.total_paid:.2f}", # Format decimal for display
                booking.get_status_display(),
                booking.latest_payment_status_display # Already processed in helper
            ])

        report_title = _('تقرير الحجوزات اليومي')
        if start_date_str == end_date_str:
             report_title += f" - {start_date_str}"
        else:
             report_title += f" ({start_date_str} - {end_date_str})"

        if customer_id:
            try:
                customer = User.objects.get(id=int(customer_id)) # Convert ID back to int
                report_title += f" - {_('العميل')}: {customer.get_full_name() or customer.username}"
            except (User.DoesNotExist, ValueError):
                pass # Ignore if customer not found or ID is invalid

        # Define column widths for the PDF report
        available_width = landscape(A4)[0] - 60 # Margins: 30 left + 30 right
        col_widths = [
            available_width * 0.08,  # رقم الحجز
            available_width * 0.15,  # الفندق
            available_width * 0.15,  # العميل
            available_width * 0.12,  # الغرفة
            available_width * 0.12,  # تاريخ الوصول
            available_width * 0.12,  # تاريخ المغادرة
            available_width * 0.10,  # إجمالي المدفوعات
            available_width * 0.08,  # حالة الحجز
            available_width * 0.08   # حالة الدفع
        ]

        # Generate the PDF using the helper method with specified column widths
        return self.generate_pdf(report_title, headers, data, col_widths=col_widths)

    # --- Other Custom Views (Extend, Checkout) ---
    def extend_booking(self, request, object_id):
        # (Keep existing extend_booking logic)
        # ... (ensure this logic is still correct and complete) ...
        original_booking = get_object_or_404(Booking, pk=object_id)

        if request.method == 'POST':
            form = BookingExtensionForm(request.POST, booking=original_booking)
            if form.is_valid():
                try:
                    # ... (rest of the POST logic from previous version) ...
                    new_check_out = form.cleaned_data['new_check_out']
                    # ... (calculate additional nights, price, save ExtensionMovement, update Availability) ...
                    # Make sure get_room_price is correctly imported/defined
                    # Make sure RoomStatus.objects.get(id=3) is correct

                    return JsonResponse({
                        'success': True,
                        'message': _('تم التمديد بنجاح!'),
                        # 'additional_nights': additional_nights,
                        # 'additional_price': additional_price,
                        # 'new_total': new_total,
                        'redirect_url': reverse('admin:bookings_booking_changelist') # Redirect back to list
                    })
                except Exception as e:
                    # Log the exception e for debugging
                    return JsonResponse({'success': False, 'message': _('حدث خطأ: {}').format(str(e))})
            else:
                 # Pass form errors back if possible
                 errors = form.errors.as_json()
                 return JsonResponse({'success': False, 'message': _('التمديد غير صالح، يرجى التحقق من البيانات المدخلة.'), 'errors': errors})
        else:
            # (Keep existing GET logic from previous version)
            # ... (calculate initial form values, context) ...
             latest_extension = ExtensionMovement.objects.filter(
                 booking=original_booking
             ).order_by('-extension_date').first()

             if latest_extension:
                 initial_new_check_out = latest_extension.new_departure + timedelta(days=1)
             else:
                 initial_new_check_out = original_booking.check_out_date.date() + timedelta(days=1) # Use date part

             form = BookingExtensionForm(initial={
                 'new_check_out': initial_new_check_out,
             }, booking=original_booking)

             # Calculate preview values (ensure logic is sound)
             additional_nights = 1
             room_price = get_room_price(original_booking.room) # Ensure this function exists and works
             additional_price = additional_nights * room_price * original_booking.rooms_booked
             new_total = original_booking.amount + additional_price

             context = self.admin_site.each_context(request)
             context.update({
                 'form': form,
                 'original': original_booking,
                 'check_out': initial_new_check_out, # Pass the calculated initial date
                 'additional_nights': additional_nights,
                 'additional_price': additional_price,
                 'new_total': new_total,
                 'opts': self.model._meta,
                 'room_price': room_price,
                 'is_popup': True, # Indicate this is for a popup
             })
             return render(request, 'admin/bookings/booking_extension.html', context)

    def set_actual_check_out_date_view(self, request, pk):
         # Add logic to set actual_check_out_date for the booking with id=pk
         # Remember to handle permissions and potential errors
         booking = get_object_or_404(Booking, pk=pk)
         # Check permissions if necessary
         if booking.actual_check_out_date is None and booking.status != Booking.BookingStatus.CANCELED:
             booking.actual_check_out_date = timezone.now()
             # Optionally change booking status to 'Checked Out' if you have such a status
             booking.save() # This should trigger availability update via save method
             self.message_user(request, _("تم تسجيل تاريخ المغادرة الفعلي للحجز رقم {} بنجاح.").format(pk))
         else:
             self.message_user(request, _("لا يمكن تسجيل المغادرة لهذا الحجز (قد يكون ملغيًا أو تم تسجيل الخروج بالفعل)."), level='warning')
         return redirect('admin:bookings_booking_changelist')


# --- Register Admin Classes ---
class GuestAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['name', 'phone_number', 'hotel', 'booking'] # Removed checkout toggle for simplicity, add back if needed
    list_filter = ['hotel']
    search_fields = ['name', 'phone_number', 'booking__id']
    # Add other configurations as needed

class BookingDetailAdmin(AutoUserTrackMixin, admin.ModelAdmin):
    list_display = ['booking', 'service', 'quantity', 'price', 'total'] # Added service
    list_filter = ['booking__status', 'service']
    search_fields = ['booking__id', 'service__name']
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at', 'total') # Make total readonly
    # Add other configurations as needed

class ExtensionMovementAdmin(admin.ModelAdmin):
    list_display = (
        'movement_number', 'booking', 'original_departure', 'new_departure',
        'extension_date', 'duration', 'reason', 'payment_button'
    )
    list_filter = ('extension_date', 'reason')
    search_fields = ('booking__id', 'movement_number')
    readonly_fields = ('extension_year', 'duration', 'movement_number', 'extension_date') # Make more fields readonly
    date_hierarchy = 'extension_date'
    # Add other configurations as needed

    def payment_button(self, obj):
        # (Keep existing payment_button logic)
        # ...
        if obj.booking.actual_check_out_date is not None:
            return format_html('<span style="color:red; font-weight:bold;">✔ {}</span>', _("غير قابل للتعديل"))
        if obj.payment_receipt is not None:
             # Maybe link to the payment receipt?
             # payment_url = reverse('admin:payments_payment_change', args=[obj.payment_receipt.pk])
             # return format_html('<a href="{}"><span style="color:green; font-weight:bold;">✔ {}</span></a>', payment_url, _("تم الدفع"))
             return format_html('<span style="color:green; font-weight:bold;">✔ {}</span>', _("تم الدفع"))

        # Ensure URL name is correct
        try:
             # Assuming a URL name like 'booking_extend_payment' exists, possibly in bookings/urls.py or admin URLs
             url = reverse('admin:booking_extend_payment', args=[obj.booking.id, obj.pk]) # Adjust namespace if needed
        except:
             return _("خطأ في رابط الدفع")
        return format_html(
            '<a class="button btn btn-success" href="{}" onclick="return showExtensionPopup(this.href);">{}</a>',
            url, _("دفع الفاتورة")
        )
    payment_button.short_description = _('فاتورة الدفع')


class BookingHistoryAdmin(admin.ModelAdmin):
    list_display = (
        'booking', 'history_date', 'changed_by', 'previous_status', 'new_status'
    )
    list_filter = ('new_status', 'history_date', 'booking__hotel') # Filter by hotel via booking
    search_fields = (
        'booking__id', 'booking__hotel__name', 'changed_by__username'
    )
    ordering = ('-history_date',)
    readonly_fields = [f.name for f in BookingHistory._meta.fields] # Make all fields readonly

    def has_add_permission(self, request):
        return False
    def has_change_permission(self, request, obj=None):
        return False # Prevent changes through admin
    def has_delete_permission(self, request, obj=None):
        return False # Prevent deletion through admin


# Use your custom admin site if defined, otherwise use default admin.site
try:
    from api.admin import admin_site
except ImportError:
    admin_site = admin.site

admin_site.register(Booking, BookingAdmin)
admin_site.register(Guest, GuestAdmin)
admin_site.register(BookingDetail, BookingDetailAdmin)
admin_site.register(ExtensionMovement, ExtensionMovementAdmin)
admin_site.register(BookingHistory, BookingHistoryAdmin)
