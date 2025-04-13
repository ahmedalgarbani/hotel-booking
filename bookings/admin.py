from datetime import datetime, timedelta
from pyexpat.errors import messages
from django.contrib import admin
from django.db.models import Count
from django.http import HttpResponse, JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import path,reverse
from django.utils import timezone
from django.db.models.functions import TruncHour
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
from .models import Booking, Guest, BookingDetail
from HotelManagement.models import Hotel
from rooms.models import RoomType
from django.db.models import Q, Sum
from rooms.services import get_room_price
from .models import Booking, ExtensionMovement, Guest, BookingDetail
from django import forms
from django.contrib.admin.helpers import ActionForm
from django.utils.html import format_html
from django.db import transaction



class AutoUserTrackMixin:
    def save_model(self, request, obj, form, change):
        if not obj.pk: 
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)

class HotelManagerAdminMixin:

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.user_type == 'hotel_manager':
            qs = qs.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return qs.filter(hotel__manager=request.user.chield)
        return qs

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if not request.user.is_superuser:
            if db_field.name == "hotel":
                kwargs["queryset"] = Hotel.objects.filter(Q(manager=request.user) | Q(manager=request.user.chield))
            elif db_field.name == "room":
                kwargs["queryset"] = RoomType.objects.filter(Q(hotel__manager=request.user) | Q(hotel__manager=request.user.chield))
            elif db_field.name == "room_status":
                kwargs["queryset"] = RoomStatus.objects.filter(Q(hotel__manager=request.user) | Q(hotel__manager=request.user.chield))
            elif db_field.name == "parent_booking":
                kwargs["queryset"] = Booking.objects.filter(Q(hotel__manager=request.user) | Q(hotel__manager=request.user.chield))
            # elif db_field.name == "room_price":
            #     kwargs["queryset"] = RoomPrice.objects.filter(Q(hotel__manager=request.user) | Q(hotel__manager=request.user.chield))
            # elif db_field.name == "room_image":
            #     kwargs["queryset"] = RoomImage.objects.filter(Q(hotel__manager=request.user) | Q(hotel__manager=request.user.chield))
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

    # def get_form(self, request, obj=None, **kwargs):
    #     form = super().get_form(request, obj, **kwargs)
    #     if not request.user.is_superuser:
    #         if obj:  # If the object exists (i.e., we are editing it)
    #             if 'created_by' in form.base_fields:
    #                 form.base_fields['created_by'].widget.attrs['readonly'] = True
    #         if 'updated_by' in form.base_fields:
    #             form.base_fields['updated_by'].widget.attrs['readonly'] = True
    #             form.base_fields['updated_by'].required = False
    #     return form

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            
            form.base_fields['hotel'].queryset = Hotel.objects.filter(manager=request.user)
            form.base_fields['hotel'].initial = Hotel.objects.filter(manager=request.user).first()
            form.base_fields['hotel'].widget.attrs['readonly'] = True
            form.base_fields['hotel'].required = False
            
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user
                form.base_fields['updated_by'].widget.attrs['disabled'] = True
                form.base_fields['updated_by'].required = False
            
            if 'created_by' in form.base_fields:
                
                form.base_fields['created_by'].widget.attrs['disabled'] = True
                form.base_fields['created_by'].initial = request.user
                form.base_fields['created_by'].required = False
        return form

    def get_readonly_fields(self, request, obj=None):
        if obj:  # If the object exists (i.e., we are editing it)
            return self.readonly_fields + ('created_by', 'updated_by')
        return self.readonly_fields


class ChangeStatusForm(ActionForm):  
    new_status = forms.ChoiceField(
        choices=[('', '-- اختر الحالة --')] + list(Booking.BookingStatus.choices),
        required=False,
        label="الحالة الجديدة"
    )



class BookingAdmin(HotelManagerAdminMixin,admin.ModelAdmin):
    # form = BookingAdminForm
    action_form = ChangeStatusForm  
    list_display = [
        'hotel', 'id', 'room', 'check_in_date', 'check_out_date', 
        'amount', 'status', 'payment_status', 'extend_booking_button',
        'set_checkout_today_toggle'
    ]
    list_filter = ['status', 'hotel', 'check_in_date', 'check_out_date']
    search_fields = ['guests__name', 'hotel__name', 'room__name']
    actions = ['change_booking_status', 'export_bookings_report', 'export_upcoming_bookings', 'export_cancelled_bookings', 'export_peak_times']
    readonly_fields = ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
    
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(user=request.user)
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(user=request.user.chield)
        return queryset.none()
    

    def set_checkout_today_toggle(self, obj):
        if obj.actual_check_out_date is not None or obj.status == Booking.BookingStatus.CANCELED:
            return format_html('<span style="color:green; font-weight:bold;">✔ تم تسجيل خروج المستخدم</span>')
        url = reverse('bookings:set_actual_check_out_date', args=[obj.pk])        
        return format_html(
            f'<a class="button btn btn-warning" href="{url}">سجيل الخروج</a>'
        )
    

    def extend_booking_button(self, obj):
        current_date = timezone.now()  

        if current_date > obj.check_out_date or obj.actual_check_out_date is not None or obj.status == Booking.BookingStatus.CANCELED:
            return format_html('<span style="color:red; font-weight:bold;">✔ غير قابل للتمديد</span>')

        url = reverse('admin:booking-extend', args=[obj.pk])
        return format_html(
            '<a class="button btn btn-success form-control" href="{0}" onclick="return showExtensionPopup(this.href);">تمديد الحجز</a>',
            url
        )

    
    set_checkout_today_toggle.short_description = 'تسجيل الخروج الفعلي'
    extend_booking_button.short_description = 'تمديد الحجز'

    def payment_status(self, obj):
        payment = obj.payments.last()
        if not payment:
            return format_html('<span style="color: red;">لم يتم إنشاء دفعة</span>')
        status_colors = {
            0: 'orange',  # معلق
            1: 'green',   # مكتمل
            2: 'red'      # ملغي
        }
        return format_html(
            '<span style="color: {};">{}</span>',
            status_colors.get(payment.payment_status, 'black'),
            payment.get_payment_status_display()
        )
    payment_status.short_description = "حالة الدفع"
    payment_status.allow_tags = True

    @admin.action(description='تغيير حالة الحجوزات المحددة')
    def change_booking_status(self, request, queryset):
        new_status = request.POST.get('new_status')
        if new_status == '':
            self.message_user(request, "لم يتم اختيار حالة جديدة.", level='warning')
            return
        
        if new_status:
            try:
                with transaction.atomic():
                    for booking in queryset:
                        previous_status = booking.status
                        booking.status = new_status
                        booking.save()

                        # عند تأكيد الحجز
                        if new_status == Booking.BookingStatus.CONFIRMED:
                            # تحديث حالة الدفع الموجود
                            payment = booking.payments.first()  # نفترض أن كل حجز له دفعة واحدة
                            if payment:
                                payment.payment_status = 1  # تم الدفع
                                payment.save()

                        # عند إلغاء الحجز
                        elif new_status == Booking.BookingStatus.CANCELED:
                            payment = booking.payments.first()
                            if payment:
                                payment.payment_status = 2  # مرفوض
                                payment.save()

                    status_label = dict(Booking.BookingStatus.choices).get(new_status)
                    success_message = f"تم تغيير حالة {queryset.count()} حجز(ات) إلى '{status_label}'"
                    if new_status in [Booking.BookingStatus.CONFIRMED, Booking.BookingStatus.CANCELED]:
                        success_message += " وتم تحديث حالات الدفع المرتبطة"
                    self.message_user(request, success_message)

            except Exception as e:
                self.message_user(request, f"حدث خطأ أثناء تحديث الحجوزات: {str(e)}", level='error')

    def changelist_view(self, request, extra_context=None):
        extra_context = extra_context or {}
        extra_context['status_choices'] = Booking.BookingStatus.choices
        return super().changelist_view(request, extra_context=extra_context)


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

    change_form_template = 'admin/bookings/booking.html'
    
    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                '<path:object_id>/extend/',
                self.admin_site.admin_view(self.extend_booking),
                name='booking-extend',
            ),
        ]
        return custom_urls + urls




    def extend_booking(self, request, object_id):
        original_booking = get_object_or_404(Booking, pk=object_id)
        
        if request.method == 'POST':
            form = BookingExtensionForm(request.POST, booking=original_booking)
            if form.is_valid():
                try:
                    from datetime import datetime  

                    new_check_out = form.cleaned_data['new_check_out']

                    if isinstance(new_check_out, datetime):
                        new_check_out = new_check_out.date()

                    latest_extension = ExtensionMovement.objects.filter(
                        booking=original_booking
                    ).order_by('-extension_date').first()

                    if latest_extension:
                        original_departure = latest_extension.new_departure  
                    else:
                        original_departure = original_booking.check_out_date.date() 

                    if isinstance(original_departure, datetime):
                        original_departure = original_departure.date()

                    additional_nights = (new_check_out - original_departure).days
                    additional_price = additional_nights * get_room_price(original_booking.room)
                    new_total = original_booking.amount + additional_price  

                    new_extension = ExtensionMovement(
                        booking=original_booking,
                        original_departure=original_departure,
                        new_departure=new_check_out,
                        duration=additional_nights,
                        reason=form.cleaned_data['reason']
                    )
                    new_extension.save()

                    today = timezone.now().date()
                    latest_availability = Availability.objects.filter(
                        hotel=original_booking.hotel,
                        room_type=original_booking.room
                    ).order_by('-created_at').first()

                    current_available = latest_availability.available_rooms if latest_availability else original_booking.room.rooms_count

                    availability, created = Availability.objects.update_or_create(
                        hotel=original_booking.hotel,
                        room_type=original_booking.room,
                        availability_date=today,
                        room_status = RoomStatus.objects.get(id=3),
                        defaults={
                            "available_rooms": max(0, current_available + original_booking.rooms_booked),
                            "notes": f"تم التحديث بسبب تمديد الحجز #{new_extension.movement_number}",
                        }
                    )

                    return JsonResponse({
                        'success': True,
                        'message': 'تم التمديد بنجاح!',
                        'additional_nights': additional_nights,
                        'additional_price': additional_price,
                        'new_total': new_total,
                        'redirect_url': '/admin/'  
                    })

                except Exception as e:
                    return JsonResponse({'success': False, 'message': f'حدث خطأ: {str(e)}'})

            else:
                return JsonResponse({'success': False, 'message': 'التمديد غير صالح، يرجى التحقق من البيانات المدخلة.'})

        else:
            latest_extension = ExtensionMovement.objects.filter(
                booking=original_booking
            ).order_by('-extension_date').first()

            if latest_extension:
                initial_new_check_out = latest_extension.new_departure + timedelta(days=1)
            else:
                initial_new_check_out = original_booking.check_out_date + timedelta(days=1)

            form = BookingExtensionForm(initial={
                'new_check_out': initial_new_check_out,
            }, booking=original_booking)

        additional_nights = 1 
        additional_price = additional_nights * get_room_price(original_booking.room) * original_booking.rooms_booked
        print(original_booking.rooms_booked)
        new_total = original_booking.amount + additional_price 
        print(additional_price)

        context = self.admin_site.each_context(request)
        room_price = get_room_price(original_booking.room)  
        context.update({
            'form': form,
            'original': original_booking,
            'check_out':initial_new_check_out,
            'additional_nights': additional_nights,
            'additional_price': additional_price,
            'new_total': new_total,
            'opts': self.model._meta,
            'room_price': room_price
        })

        return render(request, 'admin/bookings/booking_extension.html', context)

class GuestAdmin(HotelManagerAdminMixin,admin.ModelAdmin):
    list_display = ['name', 'phone_number', 'hotel', 'booking','set_checkout_today_toggle']
    list_filter = ['hotel']
    search_fields = ['name', 'phone_number']

    def set_checkout_today_toggle(self, obj):
        
        url = reverse('bookings:set_guests_check_out_date', args=[obj.pk])        
        return format_html(
            f'<a class="button btn btn-warning" href="{url}">سجيل الخروج</a>'
        )
    set_checkout_today_toggle.short_description = 'تسجيل الخروج'

    



class BookingDetailAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ['booking', 'quantity', 'price', 'total']
    list_filter = ['booking__status', ]
    search_fields = ['booking__guests__name', 'RoomTypeService__name']
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(Q(user=request.user) | Q(sender=request.user))
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(user=request.user.chield)
        return queryset.none()



class ExtensionMovementAdmin(admin.ModelAdmin):
    list_display = (
        'movement_number', 
        'booking', 
        'original_departure', 
        'new_departure', 
        'extension_date', 
        'duration', 
        'reason',
        'payment_button'
    )
    list_filter = ('extension_date', 'reason', 'extension_year')
    search_fields = ('booking__id', 'movement_number')
    readonly_fields = ('extension_year', 'duration')
    date_hierarchy = 'extension_date'

    fieldsets = (
        ("معلومات التمديد", {
            'fields': (
                'booking',
                'original_departure',
                'new_departure',
                'extension_date',
                'duration',
                'reason'
            )
        }),
        ("تفاصيل الدفع", {
            'fields': ('payment_receipt',)
        }),
    )

    def payment_button(self, obj):

            if  obj.booking.actual_check_out_date is not None:
                return format_html('<span style="color:red; font-weight:bold;">✔ غير قابل للتعديل</span>')
            
            if  obj.payment_receipt is not None:
                return format_html('<span style="color:yellow; font-weight:bold;">✔ تم الدفع</span>')

            url = reverse('bookings:booking_extend_payment', args=[obj.booking.id,obj.pk])
            return format_html(
                '<a class="button btn btn-success " href="{0}" onclick="return showExtensionPopup(this.href);">دفع الفاتورة</a>',
                url
            )

    
    # def payment_receipt(self, obj):
    #     payment_url = reverse('booking:payment_bill', args=[obj.booking.id])
    #     return format_html(
    #         '<a class="button" href="{}">فاتورة الدفع</a>',
    #         payment_url
    #     )
    payment_button.short_description = 'فاتورة الدفع'
    payment_button.allow_tags = True










from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from .models import Booking, BookingHistory

class BookingHistoryInline(admin.TabularInline):
    model = BookingHistory
    extra = 0
    readonly_fields = ('history_date', 'hotel', 'user', 'room', 'check_in_date', 
                      'check_out_date', 'actual_check_out_date', 'amount', 
                      'status', 'account_status', 'rooms_booked', 'parent_booking')
    can_delete = False
    max_num = 10
    ordering = ('-history_date',)
    
    def has_add_permission(self, request, obj=None):
        return False


class BookingHistoryAdmin(admin.ModelAdmin):
    list_display = (
        'booking', 
        'history_date', 
        'changed_by', 
        'previous_status', 
        'new_status'
    )
    list_filter = ('new_status', 'history_date', 'hotel')
    search_fields = (
        'booking__id', 
        'hotel__name', 
        'changed_by__username'
    )
    ordering = ('-history_date',)

from api.admin import admin_site


# Booking------
admin_site.register(Booking,BookingAdmin)
admin_site.register(BookingHistory,BookingHistoryAdmin)
admin_site.register(Guest,GuestAdmin)
admin_site.register(BookingDetail,BookingDetailAdmin)
admin_site.register(ExtensionMovement,ExtensionMovementAdmin)