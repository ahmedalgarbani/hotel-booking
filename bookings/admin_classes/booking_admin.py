from django.contrib import admin
from django.urls import path, reverse
from django.utils import timezone
from django.utils.html import format_html
from django.db import transaction
from django.shortcuts import get_object_or_404, redirect, render
from django.http import JsonResponse
from django.utils.translation import gettext_lazy as _
from django.contrib.auth import get_user_model
from django import forms
from datetime import datetime, timedelta

# Import models and forms
from bookings.models import Booking, ExtensionMovement
from bookings.forms import BookingAdminForm, BookingExtensionForm
from rooms.models import Availability
from rooms.services import get_room_price

# Import shared components
from .mixins import HotelManagerAdminMixin, ChangeStatusForm

User = get_user_model()

from django.contrib.admin import ActionForm

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

    # --- PDF Export Action ---
    def export_bookings_report(self, request, queryset):
        # Import the report function from the services module
        from bookings.services.reports import export_bookings_report
        # Pass the queryset to the service function
        return export_bookings_report(queryset)
    export_bookings_report.short_description = _("تصدير تقرير الحجوزات المحددة (PDF)")

    # --- Custom Report Views & URLs ---
    def get_urls(self):
        urls = super().get_urls()
        # Ensure self.admin_site is available, might need to be passed or set if using custom admin site
        admin_view = self.admin_site.admin_view if hasattr(self, 'admin_site') else admin.site.admin_view

        custom_urls = [
            path('<path:object_id>/extend/', admin_view(self.extend_booking), name='booking-extend'),
            path('<int:pk>/set-checkout/', admin_view(self.set_actual_check_out_date_view), name='set_actual_check_out_date'),
        ]
        return custom_urls + urls

    # --- Other Custom Views ---



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

    def set_actual_check_out_date_view(self, request, pk):
         booking = get_object_or_404(Booking, pk=pk)
         if booking.actual_check_out_date is None and booking.status != Booking.BookingStatus.CANCELED:
             booking.actual_check_out_date = timezone.now()
             # Optionally update status
             # booking.status = Booking.BookingStatus.CHECKED_OUT # If you add this status
             booking.save() 
             self.message_user(request, _("تم تسجيل تاريخ المغادرة الفعلي للحجز رقم {} بنجاح.").format(pk))
         else:
             self.message_user(request, _("لا يمكن تسجيل المغادرة لهذا الحجز."), level='warning')
         return redirect('admin:bookings_booking_changelist')
