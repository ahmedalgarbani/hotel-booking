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
from rooms.services import get_room_price

# Import shared components
from .mixins import HotelManagerAdminMixin, ChangeStatusForm

User = get_user_model()

class BookingAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    # Use the custom form if defined in forms.py
    form = BookingAdminForm
    action_form = ChangeStatusForm # Re-enabled after fixing inheritance
    list_display = [
        'hotel', 'id', 'room', 'check_in_date', 'check_out_date',
        'amount', 'status', 'payment_status_display', 'extend_booking_button',
        'set_checkout_today_toggle'
    ]
    list_filter = ['status', 'hotel', 'check_in_date', 'check_out_date']
    search_fields = ['guests__name', 'hotel__name', 'room__name', 'user__username', 'user__first_name', 'user__last_name']
    # Keep only relevant actions for this specific admin class if desired
    actions = ['change_booking_status', 'export_bookings_report']

    change_form_template = 'admin/bookings/booking.html' # Keep if customized
    change_list_template = 'admin/bookings/booking/change_list.html' # Keep custom template reference

    def payment_status_display(self, obj):
        payment = obj.payments.order_by('-payment_date').first()
        if not payment:
            return format_html('<span style="color: gray;">{}</span>', _("لا توجد دفعات"))
        status_colors = {0: 'orange', 1: 'green', 2: 'red'}
        return format_html(
            '<span style="color: {};">{}</span>',
            status_colors.get(payment.payment_status, 'black'),
            payment.get_payment_status_display()
        )
    payment_status_display.short_description = _("حالة الدفع")
    payment_status_display.admin_order_field = 'payments__payment_status'

    def set_checkout_today_toggle(self, obj):
        if obj.actual_check_out_date is not None or obj.status == Booking.BookingStatus.CANCELED:
            return format_html('<span style="color:green; font-weight:bold;">✔ {}</span>', _("تم تسجيل الخروج"))
        try:
            # Assuming URL name is defined within the admin site's namespace
            url = reverse('admin:set_actual_check_out_date', args=[obj.pk])
        except Exception as e:
             print(f"Error reversing URL 'admin:set_actual_check_out_date': {e}")
             return _("خطأ في الرابط")
        return format_html(
            '<a class="button btn btn-warning" href="{}">{}</a>',
            url, _("تسجيل الخروج")
        )
    set_checkout_today_toggle.short_description = _('تسجيل الخروج الفعلي')

    def extend_booking_button(self, obj):
        current_date = timezone.now().date()
        # Ensure check_out_date is compared as date
        checkout_date_part = obj.check_out_date.date() if isinstance(obj.check_out_date, datetime) else obj.check_out_date

        if not checkout_date_part or checkout_date_part < current_date or obj.actual_check_out_date is not None or obj.status == Booking.BookingStatus.CANCELED:
            return format_html('<span style="color:red; font-weight:bold;">✘ {}</span>', _("غير قابل للتمديد"))
        url = reverse('admin:booking-extend', args=[obj.pk])
        # Ensure the popup function exists in your admin JS
        return format_html(
            '<a class="button btn btn-success" href="{}" onclick="return showExtensionPopup(this.href);">{}</a>',
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
                    booking.status = new_status
                    booking.save() # Triggers signals/overridden save
                    updated_count += 1
                    payment = booking.payments.order_by('-payment_date').first()
                    if payment:
                        if new_status == Booking.BookingStatus.CONFIRMED and payment.payment_status != 1:
                            payment.payment_status = 1; payment.save(); payment_updated_count += 1
                        elif new_status == Booking.BookingStatus.CANCELED and payment.payment_status != 2:
                            payment.payment_status = 2; payment.save(); payment_updated_count += 1

                status_label = dict(Booking.BookingStatus.choices).get(new_status, new_status)
                success_message = _("تم تغيير حالة %(count)d حجز(ات) إلى '%(status)s'") % {'count': updated_count, 'status': status_label}
                if payment_updated_count > 0:
                    success_message += " " + (_("وتم تحديث حالة %(payment_count)d دفعة مرتبطة.") % {'payment_count': payment_updated_count})
                self.message_user(request, success_message)
        except Exception as e:
            self.message_user(request, _("حدث خطأ أثناء تحديث الحجوزات: {}").format(str(e)), level='error')

    def changelist_view(self, request, extra_context=None):
        extra_context = extra_context or {}
        extra_context['daily_report_url'] = reverse('bookings:daily-report')
        extra_context['status_choices'] = Booking.BookingStatus.choices
        return super().changelist_view(request, extra_context=extra_context)

    def get_guest_name(self, obj):
        guest = obj.guests.first()
        return guest.name if guest else _("لا يوجد ضيف")
    get_guest_name.short_description = _("اسم الضيف")

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
                    new_check_out = form.cleaned_data['new_check_out']
                    latest_extension = ExtensionMovement.objects.filter(booking=original_booking).order_by('-extension_date').first()
                    original_departure = latest_extension.new_departure if latest_extension else original_booking.check_out_date.date()
                    additional_nights = (new_check_out - original_departure).days
                    if additional_nights <= 0: raise forms.ValidationError(_("تاريخ المغادرة الجديد يجب أن يكون بعد تاريخ المغادرة الحالي."))

                    additional_price = additional_nights * get_room_price(original_booking.room) * original_booking.rooms_booked
                    # Decide how to handle amount update - maybe add to a separate field or payment record?
                    # new_total = original_booking.amount + additional_price

                    with transaction.atomic():
                        ExtensionMovement.objects.create(
                            booking=original_booking, original_departure=original_departure,
                            new_departure=new_check_out, duration=additional_nights,
                            reason=form.cleaned_data['reason']
                        )
                        # Update booking's checkout date
                        # Combine date with original time if available, otherwise use midnight
                        original_time = original_booking.check_out_date.time() if original_booking.check_out_date else datetime.min.time()
                        original_booking.check_out_date = datetime.combine(new_check_out, original_time)
                        original_booking.save()
                        # Consider creating a new Payment record for the extension cost here

                    return JsonResponse({'success': True, 'message': _('تم التمديد بنجاح!'), 'redirect_url': reverse('admin:bookings_booking_changelist')})
                except forms.ValidationError as ve:
                     return JsonResponse({'success': False, 'message': ', '.join(ve.messages)})
                except Exception as e:
                    # Log the exception e for debugging
                    print(f"Error during booking extension: {e}")
                    return JsonResponse({'success': False, 'message': _('حدث خطأ أثناء التمديد.')})
            else:
                 errors = form.errors.as_json()
                 return JsonResponse({'success': False, 'message': _('بيانات التمديد غير صالحة.'), 'errors': errors})
        else: # GET request
             latest_extension = ExtensionMovement.objects.filter(booking=original_booking).order_by('-extension_date').first()
             current_checkout_date = latest_extension.new_departure if latest_extension else original_booking.check_out_date.date()
             initial_new_check_out = current_checkout_date + timedelta(days=1)

             form = BookingExtensionForm(initial={'new_check_out': initial_new_check_out}, booking=original_booking)

             # Calculate preview values
             additional_nights = 1
             room_price = get_room_price(original_booking.room)
             additional_price = additional_nights * room_price * original_booking.rooms_booked
             # new_total = original_booking.amount + additional_price # Preview only

             context = self.admin_site.each_context(request)
             context.update({
                 'form': form, 'original': original_booking,
                 'check_out': initial_new_check_out,
                 'additional_nights': additional_nights, 'additional_price': additional_price,
                 # 'new_total': new_total,
                 'opts': self.model._meta, 'room_price': room_price,
                 'is_popup': True, # Important for admin popups
             })
             return render(request, 'admin/bookings/booking_extension.html', context)

    def set_actual_check_out_date_view(self, request, pk):
         booking = get_object_or_404(Booking, pk=pk)
         # Add permission checks if needed: e.g., if request.user.has_perm(...)
         if booking.actual_check_out_date is None and booking.status != Booking.BookingStatus.CANCELED:
             booking.actual_check_out_date = timezone.now()
             # Optionally update status
             # booking.status = Booking.BookingStatus.CHECKED_OUT # If you add this status
             booking.save() # Triggers availability update via save method
             self.message_user(request, _("تم تسجيل تاريخ المغادرة الفعلي للحجز رقم {} بنجاح.").format(pk))
         else:
             self.message_user(request, _("لا يمكن تسجيل المغادرة لهذا الحجز."), level='warning')
         return redirect('admin:bookings_booking_changelist')
