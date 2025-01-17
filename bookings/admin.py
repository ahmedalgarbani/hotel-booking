from django.contrib import admin
from django.db.models import Count, Sum
from django.http import HttpResponse
from django.utils import timezone
from django.template.loader import render_to_string
import arabic_reshaper
from bidi.algorithm import get_display
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from django.db.models.functions import TruncHour
from django.db.models import Q
from datetime import timedelta
from .models import Booking, BookingStatus, Guest, BookingDetail

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ['get_guest_name', 'hotel', 'room', 'check_in_date', 'check_out_date', 'amount', 'status']
    list_filter = ['status', 'hotel', 'check_in_date', 'check_out_date']
    search_fields = ['guests__name', 'hotel__name', 'room__name']
    actions = ['export_bookings_report', 'export_upcoming_bookings', 'export_cancelled_bookings', 'export_peak_times']

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

        # إنشاء نمط للعنوان
        styles = getSampleStyleSheet()
        title_style = ParagraphStyle(
            'CustomTitle',
            parent=styles['Heading1'],
            fontName='Arabic',
            fontSize=16,
            alignment=1,
            spaceAfter=30
        )

        elements = []
        
        # إضافة العنوان
        elements.append(Paragraph(get_display(arabic_reshaper.reshape(title)), title_style))
        elements.append(Spacer(1, 20))

        # إنشاء الجدول
        table = Table([headers] + data)
        table.setStyle(TableStyle([
            ('FONT', (0, 0), (-1, -1), 'Arabic'),
            ('FONTSIZE', (0, 0), (-1, 0), 14),
            ('FONTSIZE', (0, 1), (-1, -1), 12),
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#2d3748')),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('GRID', (0, 0), (-1, -1), 1, colors.black),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
            ('BACKGROUND', (0, 1), (-1, -1), colors.white),
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.HexColor('#f7fafc')]),
            ('LEFTPADDING', (0, 0), (-1, -1), 10),
            ('RIGHTPADDING', (0, 0), (-1, -1), 10),
        ]))

        elements.append(table)
        doc.build(elements)
        return response

    def export_bookings_report(self, request, queryset):
        headers = [
            get_display(arabic_reshaper.reshape('اسم الضيف')),
            get_display(arabic_reshaper.reshape('الفندق')),
            get_display(arabic_reshaper.reshape('الغرفة')),
            get_display(arabic_reshaper.reshape('تاريخ الدخول')),
            get_display(arabic_reshaper.reshape('تاريخ الخروج')),
            get_display(arabic_reshaper.reshape('المبلغ')),
            get_display(arabic_reshaper.reshape('الحالة'))
        ]

        data = []
        for booking in queryset:
            guest = booking.guests.first()
            data.append([
                get_display(arabic_reshaper.reshape(guest.name if guest else "لا يوجد ضيف")),
                get_display(arabic_reshaper.reshape(str(booking.hotel))),
                get_display(arabic_reshaper.reshape(str(booking.room))),
                booking.check_in_date.strftime('%Y-%m-%d %H:%M') if booking.check_in_date else '',
                booking.check_out_date.strftime('%Y-%m-%d %H:%M') if booking.check_out_date else '',
                str(booking.amount),
                get_display(arabic_reshaper.reshape(str(booking.status)))
            ])

        return self.generate_pdf('تقرير_الحجوزات', headers, data)
    export_bookings_report.short_description = "تصدير تقرير الحجوزات"

    def export_upcoming_bookings(self, request, queryset):
        now = timezone.now()
        upcoming = queryset.filter(check_in_date__gt=now).order_by('check_in_date')
        
        headers = [
            get_display(arabic_reshaper.reshape('اسم الضيف')),
            get_display(arabic_reshaper.reshape('الفندق')),
            get_display(arabic_reshaper.reshape('الغرفة')),
            get_display(arabic_reshaper.reshape('تاريخ الدخول')),
            get_display(arabic_reshaper.reshape('المبلغ'))
        ]

        data = []
        for booking in upcoming:
            guest = booking.guests.first()
            data.append([
                get_display(arabic_reshaper.reshape(guest.name if guest else "لا يوجد ضيف")),
                get_display(arabic_reshaper.reshape(str(booking.hotel))),
                get_display(arabic_reshaper.reshape(str(booking.room))),
                booking.check_in_date.strftime('%Y-%m-%d %H:%M'),
                str(booking.amount)
            ])

        return self.generate_pdf('تقرير_الحجوزات_القادمة', headers, data)
    export_upcoming_bookings.short_description = "تصدير تقرير الحجوزات القادمة"

    def export_cancelled_bookings(self, request, queryset):
        cancelled = queryset.filter(status__booking_status_name='ملغي')
        
        headers = [
            get_display(arabic_reshaper.reshape('اسم الضيف')),
            get_display(arabic_reshaper.reshape('الفندق')),
            get_display(arabic_reshaper.reshape('الغرفة')),
            get_display(arabic_reshaper.reshape('تاريخ الإلغاء')),
            get_display(arabic_reshaper.reshape('المبلغ'))
        ]

        data = []
        for booking in cancelled:
            guest = booking.guests.first()
            data.append([
                get_display(arabic_reshaper.reshape(guest.name if guest else "لا يوجد ضيف")),
                get_display(arabic_reshaper.reshape(str(booking.hotel))),
                get_display(arabic_reshaper.reshape(str(booking.room))),
                booking.updated_at.strftime('%Y-%m-%d %H:%M'),
                str(booking.amount)
            ])

        return self.generate_pdf('تقرير_الحجوزات_الملغاة', headers, data)
    export_cancelled_bookings.short_description = "تصدير تقرير الحجوزات الملغاة"

    def export_peak_times(self, request, queryset):
        # تحليل أوقات الذروة بناءً على ساعات تسجيل الدخول
        peak_hours = queryset.annotate(
            hour=TruncHour('check_in_date')
        ).values('hour').annotate(
            count=Count('id')
        ).order_by('-count')[:10]  # أعلى 10 ساعات ذروة

        headers = [
            get_display(arabic_reshaper.reshape('الوقت')),
            get_display(arabic_reshaper.reshape('عدد الحجوزات')),
            get_display(arabic_reshaper.reshape('النسبة المئوية'))
        ]

        total_bookings = sum(ph['count'] for ph in peak_hours)
        data = []
        for ph in peak_hours:
            percentage = (ph['count'] / total_bookings) * 100
            data.append([
                ph['hour'].strftime('%Y-%m-%d %H:00'),
                str(ph['count']),
                f"{percentage:.1f}%"
            ])

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
