from django import forms
from django.db.models import Q
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
from django.http import HttpResponse
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
import arabic_reshaper
from bidi.algorithm import get_display
import datetime

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

def generate_pdf_report(title, headers, data, col_widths=None, rtl=False, metadata=None):
    """
    Generates a PDF response for a report using ReportLab.
    Handles Arabic text reshaping and luxury styling.
    """
    response = HttpResponse(content_type='application/pdf')
    safe_title = "".join(c if c.isalnum() else "_" for c in title)
    response['Content-Disposition'] = f'attachment; filename="{safe_title}.pdf"'
    
    # Define luxury colors
    luxury_gold = colors.Color(212/255, 175/255, 55/255)     # #d4af37
    luxury_dark = colors.Color(44/255, 62/255, 80/255)       # #2c3e50
    luxury_light = colors.Color(248/255, 249/255, 250/255)   # #f8f9fa
    luxury_accent = colors.Color(142/255, 68/255, 173/255)   # #8e44ad
    luxury_success = colors.Color(39/255, 174/255, 96/255)   # #27ae60
    
    # Increase top margin to accommodate logo
    doc = SimpleDocTemplate(
        response,
        pagesize=landscape(A4),
        rightMargin=30, leftMargin=30, topMargin=80, bottomMargin=30
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
    
    # Luxury title style
    title_style = ParagraphStyle(
        'CustomTitle', 
        parent=styles['h1'], 
        fontName=base_font_name, 
        fontSize=18, 
        alignment=1, 
        spaceAfter=25,
        textColor=luxury_dark,
        borderColor=luxury_gold,
        borderWidth=1,
        borderPadding=10,
        borderRadius=5,
        backColor=colors.Color(250/255, 250/255, 250/255)
    )
    
    # Set text alignment based on RTL parameter (1=center, 0=left, 2=right)
    text_alignment = 2 if rtl else 0
    
    # Cell styles
    cell_style = ParagraphStyle(
        'CustomCell', 
        parent=styles['Normal'], 
        fontName=base_font_name, 
        fontSize=9, 
        alignment=text_alignment, 
        leading=14
    )
    
    # Header style
    header_style = ParagraphStyle(
        'CustomHeader', 
        parent=cell_style, 
        alignment=1, 
        fontSize=11,
        textColor=colors.white,
        fontName=base_font_name,
        leading=16,
        fontWeight='bold'
    )

    elements = []
    
    # Add a spacer at the top
    elements.append(Spacer(1, 10))
    
    # Add report date
    current_date = timezone.now().strftime('%Y-%m-%d %H:%M')
    date_text = f"تاريخ التقرير: {current_date}"
    date_style = ParagraphStyle('DateStyle', parent=styles['Normal'], fontName=base_font_name, fontSize=8, alignment=2 if rtl else 0, textColor=colors.gray)
    elements.append(Paragraph(get_display(arabic_reshaper.reshape(date_text)), date_style))
    elements.append(Spacer(1, 15))
    
    # Add title with gold underline
    reshaped_title = get_display(arabic_reshaper.reshape(title))
    elements.append(Paragraph(reshaped_title, title_style))
    
    # Add subtitle if provided in metadata
    if metadata and 'subtitle' in metadata:
        subtitle_style = ParagraphStyle(
            'SubtitleStyle', 
            parent=styles['Normal'], 
            fontName=base_font_name, 
            fontSize=12, 
            alignment=1, 
            spaceAfter=15,
            textColor=luxury_dark
        )
        subtitle_text = get_display(arabic_reshaper.reshape(metadata['subtitle']))
        elements.append(Paragraph(subtitle_text, subtitle_style))
    
    # Add statistics if provided in metadata
    if metadata and 'statistics' in metadata and metadata['statistics']:
        stats_style = ParagraphStyle(
            'StatsStyle', 
            parent=styles['Normal'], 
            fontName=base_font_name, 
            fontSize=10, 
            alignment=2 if rtl else 0, 
            spaceAfter=20,
            textColor=luxury_dark,
            backColor=colors.Color(245/255, 245/255, 245/255),
            borderColor=luxury_gold,
            borderWidth=1,
            borderPadding=8,
            borderRadius=4
        )
        
        for stat in metadata['statistics']:
            stat_text = get_display(arabic_reshaper.reshape(stat))
            elements.append(Paragraph(stat_text, stats_style))
            elements.append(Spacer(1, 5))  # Small space between stats
        
        elements.append(Spacer(1, 10))  # Space after statistics

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
        # Reverse the column order if RTL is enabled
        if rtl:
            for i in range(len(formatted_data)):
                formatted_data[i] = formatted_data[i][::-1]
            col_widths = col_widths[::-1]
        
        table = Table(formatted_data, colWidths=col_widths, repeatRows=1)
        table.setStyle(TableStyle([
            # Header styling
            ('BACKGROUND', (0, 0), (-1, 0), luxury_dark),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
            ('FONTNAME', (0, 0), (-1, -1), base_font_name),
            ('FONTSIZE', (0, 0), (-1, 0), 11),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
            ('TOPPADDING', (0, 0), (-1, 0), 10),
            
            # Data rows styling
            ('FONTSIZE', (0, 1), (-1, -1), 9),
            ('BOTTOMPADDING', (0, 1), (-1, -1), 6),
            ('TOPPADDING', (0, 1), (-1, -1), 6),
            
            # Borders and backgrounds
            ('LINEBELOW', (0, 0), (-1, 0), 1.5, luxury_gold),  # Gold line below headers
            ('GRID', (0, 1), (-1, -1), 0.5, colors.lightgrey),
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.Color(248/255, 249/255, 250/255), colors.white]),
            
            # Highlight totals row if it exists (assuming last row might be totals)
            ('BACKGROUND', (0, -1), (-1, -1), colors.Color(240/255, 240/255, 240/255)),
            ('FONTSIZE', (0, -1), (-1, -1), 10),
            ('BOTTOMPADDING', (0, -1), (-1, -1), 8),
            ('TOPPADDING', (0, -1), (-1, -1), 8),
        ]))
        elements.append(table)
    else:
         elements.append(Paragraph(get_display(arabic_reshaper.reshape(_("لا توجد بيانات لعرضها في التقرير."))), styles['Normal']))


    # Add header and footer with page numbers and logo
    def add_page_number(canvas, doc):
        canvas.saveState()
        
        # Add logo at top
        logo_path = 'static/images/logo.png'
        try:
            # Position the logo at the top right corner for RTL, top left for LTR
            logo_width = 120  # Width of the logo in points
            logo_height = 60  # Height of the logo in points
            
            # Calculate position based on RTL setting
            if rtl:
                logo_x = landscape(A4)[0] - 30 - logo_width  # Right aligned for RTL
            else:
                logo_x = 30  # Left aligned for LTR
                
            canvas.drawImage(logo_path, logo_x, landscape(A4)[1] - 50, width=logo_width, height=logo_height, preserveAspectRatio=True)
            
            # Add a gold line under the header area
            canvas.setStrokeColor(luxury_gold)
            canvas.setLineWidth(1)
            canvas.line(30, landscape(A4)[1] - 60, landscape(A4)[0] - 30, landscape(A4)[1] - 60)
        except Exception as e:
            print(f"Warning: Could not add logo. Error: {e}")
        
        # Footer settings
        canvas.setFont(base_font_name, 8)
        canvas.setFillColor(colors.grey)
        
        # Draw gold line at bottom
        canvas.setStrokeColor(luxury_gold)
        canvas.line(30, 20, landscape(A4)[0]-30, 20)
        
        # Add page numbers
        page_num = canvas.getPageNumber()
        text = f"صفحة {page_num}"
        reshaped_text = get_display(arabic_reshaper.reshape(text))
        canvas.drawRightString(landscape(A4)[0]-30, 10, reshaped_text)
        
        # Add system name on left side
        system_name = "نظام إدارة الفنادق"
        reshaped_system = get_display(arabic_reshaper.reshape(system_name))
        canvas.drawString(30, 10, reshaped_system)
        
        canvas.restoreState()
    
    # Build document with page numbers
    doc.build(elements, onFirstPage=add_page_number, onLaterPages=add_page_number)
    return response
