from django import forms
from django.db.models import Q
from django.utils.translation import gettext_lazy as _
from django.http import HttpResponse
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
import arabic_reshaper
from bidi.algorithm import get_display

# Import models needed by mixins and forms (adjust paths if necessary)
from HotelManagement.models import Hotel
from rooms.models import RoomType
from bookings.models import Booking
from users.models import CustomUser # Import Booking for ChangeStatusForm choices

# --- Mixins ---

class AutoUserTrackMixin:
    """Automatically sets created_by and updated_by fields."""
    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)

class HotelManagerAdminMixin:
    """
    Mixin to filter querysets and form fields based on user type (hotel_manager, hotel_staff).
    Requires careful setup of user model relationships (e.g., 'hotel_set', 'assigned_hotel').
    """
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        user = request.user
        if user.is_superuser or user.user_type == 'admin':
             return qs
        elif user.user_type == 'hotel_manager':
             # Check if the user is linked to a hotel via the OneToOneField reverse relation ('hotel')
             if hasattr(user, 'hotel') and user.hotel:
                 return qs.filter(hotel=user.hotel)
             else:
                 # If the manager is not linked to any hotel, show no bookings
                 return qs.none()
        elif user.user_type == 'hotel_staff':
             # Adjust logic based on how staff are linked to hotels
             if hasattr(user, 'assigned_hotel'): # Example: Direct link
                 return qs.filter(hotel=user.assigned_hotel)
             # Add other potential linking logic here if needed
             else:
                 return qs.none()
        return qs.none()

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        user = request.user
        if not user.is_superuser and user.user_type != 'admin':
            hotel_query = Q()
            # Determine the hotel(s) the user manages or is assigned to
            if user.user_type == 'hotel_manager':
                 if hasattr(user, 'hotel_set') and user.hotel_set.exists():
                     hotel_query = Q(pk=user.hotel_set.first().pk)
            elif user.user_type == 'hotel_staff':
                 if hasattr(user, 'assigned_hotel'):
                     hotel_query = Q(pk=user.assigned_hotel.pk)
                 # Add other linking logic if needed

            # Filter relevant fields based on the determined hotel(s)
            if hotel_query: # Only filter if a hotel context is found
                allowed_hotels = Hotel.objects.filter(hotel_query)
                if db_field.name == "hotel":
                    kwargs["queryset"] = allowed_hotels
                elif db_field.name == "room":
                    kwargs["queryset"] = RoomType.objects.filter(hotel__in=allowed_hotels)
                elif db_field.name == "user":
                    kwargs["queryset"] = CustomUser.objects.filter(hotel__in=allowed_hotels)
                elif db_field.name == "parent_booking":
                    kwargs["queryset"] = Booking.objects.filter(hotel__in=allowed_hotels)
                # Add other fields like 'guest', 'bookingdetail' if they need filtering by hotel

        return super().formfield_for_foreignkey(db_field, request, **kwargs)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        user = request.user
        # Auto-select and disable hotel field for non-admins
        if not user.is_superuser and user.user_type != 'admin':
            if 'hotel' in form.base_fields:
                 hotel_qs = Hotel.objects.none()
                 # Determine user's hotel
                 if user.user_type == 'hotel_manager':
                     if hasattr(user, 'hotel_set') and user.hotel_set.exists():
                         hotel_qs = Hotel.objects.filter(pk=user.hotel_set.first().pk)
                 elif user.user_type == 'hotel_staff':
                     if hasattr(user, 'assigned_hotel'):
                         hotel_qs = Hotel.objects.filter(pk=user.assigned_hotel.pk)
                     # Add other linking logic if needed

                 if hotel_qs.exists():
                     form.base_fields['hotel'].queryset = hotel_qs
                     form.base_fields['hotel'].initial = hotel_qs.first()
                     form.base_fields['hotel'].widget.attrs['disabled'] = True
                     form.base_fields['hotel'].required = False

            # Disable tracking fields
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user # Pre-fill current user
                form.base_fields['updated_by'].widget.attrs['disabled'] = True
                form.base_fields['updated_by'].required = False
            if 'created_by' in form.base_fields:
                if obj: # Disable only when editing
                     form.base_fields['created_by'].widget.attrs['disabled'] = True
                form.base_fields['created_by'].required = False

        return form

    def get_readonly_fields(self, request, obj=None):
        readonly = list(super().get_readonly_fields(request, obj))
        if obj:
            readonly.extend(['created_at', 'updated_at', 'created_by', 'updated_by', 'deleted_at'])
        # Prevent non-superusers from editing hotel field after creation
        if obj and not request.user.is_superuser and request.user.user_type != 'admin':
             if 'hotel' not in readonly:
                 readonly.append('hotel')
        return tuple(readonly)

from django.contrib.admin.helpers import ActionForm # Import ActionForm

# --- Action Forms ---

class ChangeStatusForm(ActionForm): # Inherit from ActionForm
    new_status = forms.ChoiceField(
        choices=[('', '-- اختر الحالة --')] + list(Booking.BookingStatus.choices),
        required=True, # Action forms usually require a selection
        label=_("الحالة الجديدة")
    )
    # If ActionForm provides specific features you need, inherit from it instead
    # from django.contrib.admin.helpers import ActionForm
    # class ChangeStatusForm(ActionForm): ...


# --- PDF Generation Helper Function ---

def generate_pdf_report(title, headers, data, col_widths=None):
    """
    Generates a PDF response for a report using ReportLab.
    Handles Arabic text reshaping and basic styling.
    """
    response = HttpResponse(content_type='application/pdf')
    safe_title = "".join(c if c.isalnum() else "_" for c in title)
    response['Content-Disposition'] = f'attachment; filename="{safe_title}.pdf"'

    doc = SimpleDocTemplate(
        response,
        pagesize=landscape(A4),
        rightMargin=30, leftMargin=30, topMargin=50, bottomMargin=30
    )

    # Register Arabic font
    try:
        # Ensure the font path is correct relative to your project structure
        # It's often better to define this path in settings.py
        font_path = 'static/fonts/NotoKufiArabic-Regular.ttf'
        pdfmetrics.registerFont(TTFont('Arabic', font_path))
        base_font_name = 'Arabic'
    except Exception as e:
        print(f"Warning: Could not register Arabic font at {font_path}. Error: {e}. Using Helvetica.")
        base_font_name = 'Helvetica' # Fallback

    styles = getSampleStyleSheet()
    title_style = ParagraphStyle('CustomTitle', parent=styles['h1'], fontName=base_font_name, fontSize=16, alignment=1, spaceAfter=20)
    cell_style = ParagraphStyle('CustomCell', parent=styles['Normal'], fontName=base_font_name, fontSize=9, alignment=2, leading=12) # Right align data
    header_style = ParagraphStyle('CustomHeader', parent=cell_style, alignment=1, fontSize=10) # Center align headers

    elements = []
    reshaped_title = get_display(arabic_reshaper.reshape(title))
    elements.append(Paragraph(reshaped_title, title_style))

    # Prepare data with Paragraph objects
    formatted_data = []
    header_row = [Paragraph(get_display(arabic_reshaper.reshape(str(h))), header_style) for h in headers]
    formatted_data.append(header_row)
    for row in data:
        row_cells = [Paragraph(get_display(arabic_reshaper.reshape(str(cell_value) if cell_value is not None else '')), cell_style) for cell_value in row]
        formatted_data.append(row_cells)

    # Calculate default column widths if not provided
    if not col_widths:
        num_cols = len(headers)
        available_width = landscape(A4)[0] - doc.leftMargin - doc.rightMargin
        if num_cols > 0:
            col_widths = [available_width / num_cols] * num_cols
        else:
            col_widths = [] # Avoid division by zero

    # Create and style the table
    if formatted_data and col_widths: # Ensure there's data and widths
        table = Table(formatted_data, colWidths=col_widths, repeatRows=1)
        table.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.white),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
            ('FONTNAME', (0, 0), (-1, -1), base_font_name),
            ('FONTSIZE', (0, 0), (-1, 0), 10),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 8),
            ('FONTSIZE', (0, 1), (-1, -1), 9),
            ('BOTTOMPADDING', (0, 1), (-1, -1), 5),
            ('TOPPADDING', (0, 1), (-1, -1), 5),
            ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.whitesmoke, colors.white]),
        ]))
        elements.append(table)
    else:
         elements.append(Paragraph(get_display(arabic_reshaper.reshape(_("لا توجد بيانات لعرضها في التقرير."))), styles['Normal']))


    doc.build(elements)
    return response
