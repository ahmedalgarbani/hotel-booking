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
from django.core.exceptions import ValidationError
# Import models and forms
from bookings.models import Booking, BookingDetail, ExtensionMovement
from bookings.forms import BookingAdminForm, BookingExtensionForm
from rooms.models import Availability
from rooms.services import get_room_price

# Import shared components
from .mixins import HotelManagerAdminMixin

User = get_user_model()

class BookingAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    # Use the custom form if defined in forms.py
    form = BookingAdminForm
    list_display = [
         'id','hotel', 'room', 'check_in_date', 'check_out_date',
        'amount', 'status', 'payment_status_display','show_payment_details_button', 'extend_booking_button',
        'set_checkout_today_toggle'
    ]
    list_filter = ['status', 'hotel', 'check_in_date', 'check_out_date']
    search_fields = ['guests__name', 'hotel__name', 'room__name', 'user__username', 'user__first_name', 'user__last_name']
    readonly_fields = [  'created_at', 'updated_at', 'created_by', 'updated_by', 'deleted_at']

    # تعديل ترتيب الحقول في نموذج الإضافة
    fieldsets = [
        (_('معلومات الحجز الأساسية'), {
            'fields': [
                'room', 'hotel', 'user', 'status', 'rooms_booked',
                ('check_in_date', 'check_out_date'), 'amount', 'account_status'
            ],
            'description': _('اختر الغرفة أولاً وسيتم تعيين الفندق تلقائيًا.')
        }),
        (_('معلومات النظام'), {
            'fields': ['created_at', 'updated_at', 'created_by', 'updated_by', 'deleted_at'],
            'classes': ['collapse']
        }),
    ]

    # إضافة ملفات JavaScript
    class Media:
        js = ('admin/js/booking_form.js',)
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:
            return ('created_at', 'updated_at','created_by', 'updated_by', 'deleted_at','hotel')
        return self.readonly_fields

    change_form_template = 'admin/bookings/booking.html'
    change_list_template = 'admin/bookings/booking/change_list.html'
    def show_payment_details_button(self, obj):
        payment = obj.payments.order_by('-payment_date').first()
        if not obj.pk:

            return ""
        if not payment:
            return format_html(
    '<div style="color: #6c757d; font-style: italic; display: flex; align-items: center;">'
    '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" '
    'class="bi bi-info-circle" viewBox="0 0 16 16" style="margin-right: 5px;">'
    '<path d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>'
    '<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 .876-.252 1.007-.598l.088-.416c.066-.3.122-.507.23-.58.107-.072.268-.1.482-.122l.088-.416c.27-1.284.362-1.493-.64-1.574l-.088-.416.861-.108-.088-.416zm-1.498-.733c-.246 0-.45.178-.45.4s.204.4.45.4.45-.178.45-.4-.204-.4-.45-.4z"/>'
    '</svg>'
    '{}'
    '</div>',
    _("لا توجد تفاصيل للدفعات")
)
        url = reverse('admin:booking_payment_details', args=[obj.pk])
        return format_html(
            '<a class="button btn btn-primary" href="{}">{}</a>',
            url, _("عرض تفاصيل الدفع")
        )

    show_payment_details_button.short_description = _("تفاصيل الدفع")
    show_payment_details_button.allow_tags = True

    def payment_details_view(self, request, booking_id):
        # Verificar si el usuario es un administrador o un gerente de hotel
        user = request.user

        # Obtener la reserva y verificar permisos
        if user.is_superuser or user.user_type == 'admin':
            # Los administradores pueden ver todas las reservas
            booking = get_object_or_404(self.model, pk=booking_id)
        elif user.user_type == 'hotel_manager':
            # Los gerentes de hotel solo pueden ver las reservas de su propio hotel
            if hasattr(user, 'hotel') and user.hotel:
                booking = get_object_or_404(self.model, pk=booking_id, hotel=user.hotel)
            else:
                # Si el gerente no está vinculado a ningún hotel, mostrar error
                self.message_user(request, _("ليس لديك صلاحية للوصول إلى هذا الحجز"), level='error')
                return redirect('admin:bookings_booking_changelist')
        else:
            # Otros usuarios no tienen acceso
            self.message_user(request, _("ليس لديك صلاحية للوصول إلى هذا الحجز"), level='error')
            return redirect('admin:bookings_booking_changelist')

        payment = booking.payments.get(booking=booking)
        return render(request, 'admin/payments/payment_detail.html', {
            'payment': payment,
        })
    def payment_status_display(self, obj):
        payment = obj.payments.order_by('-payment_date').first()
        if not payment:
            return format_html(
    '<div style="color: #6c757d; font-style: italic; display: flex; align-items: center;">'
    '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" '
    'class="bi bi-info-circle" viewBox="0 0 16 16" style="margin-right: 5px;">'
    '<path d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z"/>'
    '<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 .876-.252 1.007-.598l.088-.416c.066-.3.122-.507.23-.58.107-.072.268-.1.482-.122l.088-.416c.27-1.284.362-1.493-.64-1.574l-.088-.416.861-.108-.088-.416zm-1.498-.733c-.246 0-.45.178-.45.4s.204.4.45.4.45-.178.45-.4-.204-.4-.45-.4z"/>'
    '</svg>'
    '{}'
    '</div>',
    _("لا توجد دفعات")
)

        status_colors = {
            0: '#fff3cd',
            1: '#d4edda',
            2: '#f8d7da',
        }
        text_colors = {
            0: '#856404',
            1: '#155724',
            2: '#721c24',
        }
        return format_html(
            '<span style="background-color: {}; color: {}; padding: 3px 8px; border-radius: 12px; font-size: 0.85em; font-weight: 500;">{}</span>',
            status_colors.get(payment.payment_status, '#e2e3e5'),
            text_colors.get(payment.payment_status, '#383d41'),
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
        return format_html(
            '<a class="button btn btn-success" href="{}" onclick="return showExtensionPopup(this.href);">{}</a>',
            url, _("تمديد الحجز")
        )
    extend_booking_button.short_description = _('تمديد الحجز')

    actions = ['change_booking_status', 'export_bookings_report']

    @admin.action(description=_('تغيير حالة الحجوزات المحددة'))
    def change_booking_status(self, request, queryset):
        # Create a custom form for the action
        class StatusChangeForm(forms.Form):
            new_status = forms.ChoiceField(
                choices=Booking.BookingStatus.choices,
                label=_("الحالة الجديدة"),
                required=True
            )

        # If this is a POST request and the form data is valid, process the action
        if 'apply' in request.POST:
            form = StatusChangeForm(request.POST)
            if form.is_valid():
                new_status = form.cleaned_data['new_status']
                updated_count = 0
                payment_updated_count = 0
                try:
                    with transaction.atomic():
                        for booking in queryset:
                            booking.status = new_status
                            booking.save()
                            updated_count += 1
                            payment = booking.payments.order_by('-payment_date').first()
                            if payment:
                                if new_status == Booking.BookingStatus.CONFIRMED and payment.payment_status != '1':
                                    payment.payment_status = '1'; payment.save(); payment_updated_count += 1
                                elif new_status == Booking.BookingStatus.CANCELED and payment.payment_status != '2':
                                    payment.payment_status = '2'; payment.save(); payment_updated_count += 1

                        status_label = dict(Booking.BookingStatus.choices).get(new_status, new_status)
                        success_message = _("تم تغيير حالة %(count)d حجز(ات) إلى '%(status)s'") % {'count': updated_count, 'status': status_label}
                        if payment_updated_count > 0:
                            success_message += " " + (_("وتم تحديث حالة %(payment_count)d دفعة مرتبطة.") % {'payment_count': payment_updated_count})
                        self.message_user(request, success_message)
                except Exception as e:
                    self.message_user(request, _("حدث خطأ أثناء تحديث الحجوزات: {}").format(str(e)), level='error')
                return None

        # If this is a GET request or the form is invalid, show the form
        form = StatusChangeForm()
        context = {
            'title': _('تغيير حالة الحجوزات'),
            'queryset': queryset,
            'form': form,
            'action_checkbox_name': admin.helpers.ACTION_CHECKBOX_NAME,
        }
        return render(request, 'admin/booking_status_change_form.html', context)

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
        # Verificar si el usuario es un gerente de hotel
        user = request.user
        if user.user_type == 'hotel_manager' and hasattr(user, 'hotel') and user.hotel:
            # Filtrar el queryset para incluir solo las reservas del hotel del gerente
            queryset = queryset.filter(hotel=user.hotel)

        # Import the report function from the services module
        from bookings.services.reports import export_bookings_report
        # Pass the queryset to the service function
        return export_bookings_report(queryset)
    export_bookings_report.short_description = _("تصدير تقرير الحجوزات المحددة (PDF)")

    # --- Custom Report Views & URLs ---
    def get_urls(self):
        urls = super().get_urls()
        admin_view = self.admin_site.admin_view if hasattr(self, 'admin_site') else admin.site.admin_view

        custom_urls = [
            path('<path:object_id>/extend/', admin_view(self.extend_booking), name='booking-extend'),
            path(
                '<int:booking_id>/payment-details/',
                self.admin_site.admin_view(self.payment_details_view),
                name='booking_payment_details',
            ),
            path('<int:pk>/set-checkout/', admin_view(self.set_actual_check_out_date_view), name='set_actual_check_out_date'),
        ]
        return custom_urls + urls

    # --- Other Custom Views ---



    def extend_booking(self, request, object_id):
        # Verificar si el usuario es un administrador o un gerente de hotel
        user = request.user

        # Obtener la reserva y verificar permisos
        if user.is_superuser or user.user_type == 'admin':
            # Los administradores pueden ver todas las reservas
            original_booking = get_object_or_404(Booking, pk=object_id)
        elif user.user_type == 'hotel_manager':
            # Los gerentes de hotel solo pueden ver las reservas de su propio hotel
            if hasattr(user, 'hotel') and user.hotel:
                original_booking = get_object_or_404(Booking, pk=object_id, hotel=user.hotel)
            else:
                # Si el gerente no está vinculado a ningún hotel, mostrar error
                return JsonResponse({'success': False, 'message': 'ليس لديك صلاحية للوصول إلى هذا الحجز'})
        else:
            # Otros usuarios no tienen acceso
            return JsonResponse({'success': False, 'message': 'ليس لديك صلاحية للوصول إلى هذا الحجز'})

        if request.method == 'POST':
            form = BookingExtensionForm(request.POST, booking=original_booking)
            if form.is_valid():
                try:
                    from datetime import datetime

                    new_check_out = form.cleaned_data['new_check_out']
                    if isinstance(new_check_out, datetime):
                        new_check_out = new_check_out.date()

                    # Determine original departure date
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
                    additional_price = additional_nights * get_room_price(original_booking.room) * original_booking.rooms_booked
                    new_total = original_booking.amount + additional_price

                    # Create extension object but do not save yet
                    new_extension = ExtensionMovement(
                        booking=original_booking,
                        original_departure=original_departure,
                        new_departure=new_check_out,
                        duration=additional_nights,
                        reason=form.cleaned_data['reason']
                    )

                    # Call full_clean to trigger availability checks
                    new_extension.full_clean()

                    # Save and apply availability changes
                    new_extension.save()

                    return JsonResponse({
                        'success': True,
                        'message': 'تم التمديد بنجاح!',
                        'additional_nights': additional_nights,
                        'additional_price': additional_price,
                        'new_total': new_total,
                        'redirect_url': '/admin/'
                    })
                except ValidationError as e:
                    return JsonResponse({'success': False, 'message': e.messages[0]})
                except Exception as e:
                    return JsonResponse({'success': False, 'message': f'حدث خطأ: {str(e)}'})

            else:
                return JsonResponse({'success': False, 'message': 'التمديد غير صالح، يرجى التحقق من البيانات المدخلة.'})

        else:
            latest_extension = ExtensionMovement.objects.filter(
                booking=original_booking
            ).order_by('-extension_date').first()

            if latest_extension:
                initial_new_check_out = latest_extension.new_departure
            else:
                initial_new_check_out = original_booking.check_out_date

            from datetime import datetime
            if isinstance(initial_new_check_out, datetime):
                initial_new_check_out = initial_new_check_out.date()

            form = BookingExtensionForm(initial={
                'new_check_out': initial_new_check_out,
            }, booking=original_booking)

        additional_nights = 1
        room_price = get_room_price(original_booking.room)
        services = BookingDetail.objects.filter(booking=original_booking)
        total_services_price = sum(service.price for service in services) if services else 0
        initial_price_services = (sum(service.price for service in services) if services else 0) * original_booking.rooms_booked
        additional_price = additional_nights * get_room_price(original_booking.room) * original_booking.rooms_booked + initial_price_services
        new_total = original_booking.amount + additional_price

        context = self.admin_site.each_context(request)
        context.update({
            'form': form,
            'original': original_booking,
            'check_out': initial_new_check_out,
            'additional_nights': additional_nights,
            'additional_price': additional_price,
            'new_total': new_total,
            'opts': self.model._meta,
            "services":services,
            "initial_price_services":initial_price_services,
            'total_services_price':total_services_price,
            'room_price': room_price
        })
        return render(request, 'admin/bookings/booking_extension.html', context)

    def set_actual_check_out_date_view(self, request, pk):
        # Verificar si el usuario es un administrador o un gerente de hotel
        user = request.user

        # Obtener la reserva y verificar permisos
        if user.is_superuser or user.user_type == 'admin':
            # Los administradores pueden ver todas las reservas
            booking = get_object_or_404(Booking, pk=pk)
        elif user.user_type == 'hotel_manager':
            # Los gerentes de hotel solo pueden ver las reservas de su propio hotel
            if hasattr(user, 'hotel') and user.hotel:
                booking = get_object_or_404(Booking, pk=pk, hotel=user.hotel)
            else:
                # Si el gerente no está vinculado a ningún hotel, mostrar error
                self.message_user(request, _("ليس لديك صلاحية للوصول إلى هذا الحجز"), level='error')
                return redirect('admin:bookings_booking_changelist')
        else:
            # Otros usuarios no tienen acceso
            self.message_user(request, _("ليس لديك صلاحية للوصول إلى هذا الحجز"), level='error')
            return redirect('admin:bookings_booking_changelist')

        if booking.actual_check_out_date is None and booking.status != Booking.BookingStatus.CANCELED:
            booking.actual_check_out_date = timezone.now()
            # Optionally update status
            # booking.status = Booking.BookingStatus.CHECKED_OUT
            booking.save()
            self.message_user(request, _("تم تسجيل تاريخ المغادرة الفعلي للحجز رقم {} بنجاح.").format(pk))
        else:
            self.message_user(request, _("لا يمكن تسجيل المغادرة لهذا الحجز."), level='warning')
        return redirect('admin:bookings_booking_changelist')
