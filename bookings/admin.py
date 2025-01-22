from django.contrib import admin
from django.db.models import Count
from django.http import HttpResponse
from django.utils import timezone
from django.db.models.functions import TruncHour
import arabic_reshaper
from bidi.algorithm import get_display
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from .models import Booking, BookingStatus, Guest, BookingDetail

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ['get_guest_name', 'hotel', 'room', 'check_in_date', 'check_out_date', 'amount', 'status']
    list_filter = ['status', 'hotel', 'check_in_date', 'check_out_date']
    search_fields = ['guests__name', 'hotel__name', 'room__name']
    actions = ['export_bookings_report', 'export_upcoming_bookings', 'export_cancelled_bookings', 'export_peak_times']
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
           
            return queryset.filter(hotel__manager=request.user)
        return queryset.none()
   
    def get_guest_name(self, obj):
        guest = obj.guests.first()
        return guest.name if guest else "لا يوجد ضيف"
   
    get_guest_name.short_description = "اسم الضيف"

    def generate_pdf(self, title, headers, data):
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="{title}.pdf"'
        
        # إنشاء مستند PDF
        doc = SimpleDocTemplate(
            response,
            pagesize=landscape(A4),
            rightMargin=30,
            leftMargin=30,
            topMargin=30,
            bottomMargin=30
        )

        # تسجيل الخط العربي
        pdfmetrics.registerFont(TTFont('Arabic', 'static/fonts/NotoKufiArabic-Regular.ttf'))

        # إنشاء الأنماط
        styles = getSampleStyleSheet()
        title_style = ParagraphStyle(
            'CustomTitle',
            parent=styles['Heading1'],
            fontName='Arabic',
            fontSize=16,
            alignment=1,
            spaceAfter=30
        )

        # نمط للخلايا
        cell_style = ParagraphStyle(
            'CustomCell',
            parent=styles['Normal'],
            fontName='Arabic',
            fontSize=10,
            alignment=2,  # محاذاة لليمين
            leading=14,
            spaceBefore=5,
            spaceAfter=5
        )

        elements = []
        
        # إضافة العنوان
        title_text = get_display(arabic_reshaper.reshape(title))
        elements.append(Paragraph(title_text, title_style))
        elements.append(Spacer(1, 20))

        # معالجة البيانات
        formatted_data = []
        
        # معالجة العناوين
        header_cells = []
        for header in headers:
            text = get_display(arabic_reshaper.reshape(str(header)))
            header_cells.append(Paragraph(text, cell_style))
        formatted_data.append(header_cells)
        
        # معالجة الصفوف
        for row in data:
            row_cells = []
            for cell in row:
                # عدم معالجة التواريخ والأرقام
                if isinstance(cell, (int, float)) or (isinstance(cell, str) and any(c.isdigit() for c in cell)):
                    text = str(cell)
                else:
                    text = get_display(arabic_reshaper.reshape(str(cell)))
                row_cells.append(Paragraph(text, cell_style))
            formatted_data.append(row_cells)

        # حساب عرض الأعمدة
        available_width = landscape(A4)[0] - doc.leftMargin - doc.rightMargin
        col_widths = [
            available_width * 0.20,  # اسم الضيف
            available_width * 0.15,  # الفندق
            available_width * 0.15,  # الغرفة
            available_width * 0.15,  # تاريخ الدخول
            available_width * 0.15,  # تاريخ الخروج
            available_width * 0.10,  # المبلغ
            available_width * 0.10   # الحالة
        ]

        # إنشاء الجدول
        table = Table(formatted_data, colWidths=col_widths, repeatRows=1)
        table.setStyle(TableStyle([
            ('FONT', (0, 0), (-1, -1), 'Arabic'),
            ('FONTSIZE', (0, 0), (-1, 0), 12),
            ('FONTSIZE', (0, 1), (-1, -1), 10),
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#2d3748')),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
            ('ALIGN', (0, 0), (-1, -1), 'RIGHT'),
            ('GRID', (0, 0), (-1, -1), 1, colors.black),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 10),
            ('TOPPADDING', (0, 0), (-1, -1), 10),
            ('LEFTPADDING', (0, 0), (-1, -1), 8),
            ('RIGHTPADDING', (0, 0), (-1, -1), 8),
            ('BACKGROUND', (0, 1), (-1, -1), colors.white),
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.HexColor('#f7fafc')]),
            ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ]))

        elements.append(table)
        doc.build(elements)
        return response

    def export_bookings_report(self, request, queryset):
        headers = [
            "اسم الضيف",
            "الفندق",
            "الغرفة",
            "تاريخ الدخول",
            "تاريخ الخروج",
            "المبلغ",
            "الحالة"
        ]

        data = []
        for booking in queryset:
            guest = booking.guests.first()
            data.append([
                guest.name if guest else "لا يوجد ضيف",
                str(booking.hotel),
                str(booking.room),
                booking.check_in_date.strftime('%Y-%m-%d %H:%M') if booking.check_in_date else '',
                booking.check_out_date.strftime('%Y-%m-%d %H:%M') if booking.check_out_date else '',
                str(booking.amount),
                str(booking.status)
            ])

        return self.generate_pdf('تقرير_الحجوزات', headers, data)
    export_bookings_report.short_description = "تصدير تقرير الحجوزات"

    # def export_upcoming_bookings(self, request, queryset):
    #     now = timezone.now()
    #     upcoming = queryset.filter(check_in_date__gt=now).order_by('check_in_date')
        
    #     # تحديد عرض الأعمدة للتقرير
    #     available_width = landscape(A4)[0] - 60  # 60 = rightMargin + leftMargin
    #     col_widths = [
    #         available_width * 0.25,  # اسم الضيف
    #         available_width * 0.25,  # الفندق
    #         available_width * 0.25,  # الغرفة
    #         available_width * 0.15,  # تاريخ الدخول
    #         available_width * 0.10   # المبلغ
    #     ]

    #     headers = [
    #         "اسم الضيف",
    #         "الفندق",
    #         "الغرفة",
    #         "تاريخ الدخول",
    #         "المبلغ"
    #     ]

    #     data = []
    #     for booking in upcoming:
    #         guest = booking.guests.first()
    #         data.append([
    #             guest.name if guest else "لا يوجد ضيف",
    #             str(booking.hotel),
    #             str(booking.room),
    #             booking.check_in_date.strftime('%Y-%m-%d %H:%M'),
    #             str(booking.amount)
    #         ])

    #     return self.generate_pdf('تقرير_الحجوزات_القادمة', headers, data)
    # export_upcoming_bookings.short_description = "تصدير تقرير الحجوزات القادمة"

    def export_cancelled_bookings(self, request, queryset):
        cancelled = queryset.filter(status__booking_status_name='ملغي')
        
        # تحديد عرض الأعمدة للتقرير
        available_width = landscape(A4)[0] - 60
        col_widths = [
            available_width * 0.25,  # اسم الضيف
            available_width * 0.25,  # الفندق
            available_width * 0.20,  # الغرفة
            available_width * 0.15,  # تاريخ الإلغاء
            available_width * 0.15   # المبلغ
        ]

        headers = [
            "اسم الضيف",
            "الفندق",
            "الغرفة",
            "تاريخ الإلغاء",
            "المبلغ"
        ]

        data = []
        for booking in cancelled:
            guest = booking.guests.first()
            data.append([
                guest.name if guest else "لا يوجد ضيف",
                str(booking.hotel),
                str(booking.room),
                booking.updated_at.strftime('%Y-%m-%d %H:%M'),
                str(booking.amount)
            ])

        return self.generate_pdf('تقرير_الحجوزات_الملغاة', headers, data)
    export_cancelled_bookings.short_description = "تصدير تقرير الحجوزات الملغاة"

    def export_peak_times(self, request, queryset):
        peak_hours = queryset.annotate(
            hour=TruncHour('check_in_date')
        ).values('hour').annotate(
            count=Count('id')
        ).order_by('-count')[:10]

        # تحديد عرض الأعمدة للتقرير
        available_width = landscape(A4)[0] - 60
        col_widths = [
            available_width * 0.40,  # الوقت
            available_width * 0.30,  # عدد الحجوزات
            available_width * 0.30   # النسبة المئوية
        ]

        headers = [
            "الوقت",
            "عدد الحجوزات",
            "النسبة المئوية"
        ]

        total_bookings = sum(ph['count'] for ph in peak_hours)
        data = []
        for ph in peak_hours:
            percentage = (ph['count'] / total_bookings) * 100 if total_bookings > 0 else 0
            data.append([
                ph['hour'].strftime('%Y-%m-%d %H:00'),
                str(ph['count']),
                f"{percentage:.1f}%"
            ])

        # إنشاء ملخص إحصائي
        summary_data = [
            ["إجمالي الحجوزات:", str(total_bookings), ""],
            ["متوسط الحجوزات في الساعة:", f"{total_bookings/len(peak_hours):.1f}" if peak_hours else "0", ""],
            ["أعلى عدد حجوزات في ساعة:", str(peak_hours[0]['count']) if peak_hours else "0", ""]
        ]

        # إضافة مسافة فارغة بين البيانات والملخص
        data.append(["", "", ""])
        data.extend(summary_data)

        return self.generate_pdf('تقرير_أوقات_الذروة', headers, data)
    export_peak_times.short_description = "تصدير تقرير أوقات الذروة"

@admin.register(BookingStatus)
class BookingStatusAdmin(admin.ModelAdmin):
    list_display = ['booking_status_name', 'status_code']
    search_fields = ['booking_status_name']

@admin.register(Guest)
class GuestAdmin(admin.ModelAdmin):
    list_display = ['name', 'phone_number', 'hotel', 'booking']
    list_filter = ['hotel']
    search_fields = ['name', 'phone_number']

@admin.register(BookingDetail)
class BookingDetailAdmin(admin.ModelAdmin):
    list_display = ['booking', 'service', 'quantity', 'price', 'total']
    list_filter = ['booking__status', 'service']
    search_fields = ['booking__guests__name', 'service__name']
