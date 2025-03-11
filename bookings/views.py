from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render
from payments.models import Currency, HotelPaymentMethod, Payment, PaymentOption
from .models import Booking, ExtensionMovement, Guest
from django.utils import timezone
from pyexpat.errors import messages
from django.shortcuts import render, redirect
# Create your views here.

def booking_list(request):
    bookings = Booking.objects.all()
    return render(request, 'bookings/booking_list.html', {'bookings': bookings})


def set_actual_check_out_date( request, booking_id):
        booking = Booking.objects.get(pk=booking_id)
        booking.actual_check_out_date = timezone.now()
        booking.save()
        return redirect(request.META.get('HTTP_REFERER', 'admin:index'))
   
def set_guests_check_out_date(request, guest_id):
    guest = Guest.objects.get(pk=guest_id)
    guest.check_out_date = timezone.now()
    guest.save()
    return redirect(request.META.get('HTTP_REFERER', 'admin:index'))


from django.core.files.storage import FileSystemStorage
from django.utils.translation import gettext as _


def booking_extend_payment(request, booking_id, extension_id):
    booking = get_object_or_404(Booking, pk=booking_id)
    extension = get_object_or_404(ExtensionMovement, pk=extension_id)
    currencies = Currency.objects.all()  
    payment_status = Payment.payment_choice
    payment_methods = HotelPaymentMethod.objects.filter(is_active=True, hotel=booking.hotel)
    payment_types = Payment.payment_types_choice

    if request.method == "POST":
        try:
            payment_type = request.POST.get("payment_type")
            payment_status = request.POST.get("payment_status")
            payment_method = request.POST.get("payment_method")
            currency_id = request.POST.get("currency")
            payment_notes = request.POST.get("payment_notes")
            discount_amount =float(int(request.POST.get("discount_amount", 0)))

            base_total = float(booking.amount)
            total_amount = base_total - discount_amount

            transfer_image = request.FILES.get("transfer_image")
            transfer_image_url = None
            if transfer_image:
                fs = FileSystemStorage()
                filename = fs.save(transfer_image.name, transfer_image)
                transfer_image_url = fs.url(filename)

            payment = Payment.objects.create(
                booking=booking,
                payment_status=payment_status,
                payment_currency=get_object_or_404(Currency, id=currency_id).currency_symbol,
                payment_discount=discount_amount,
                payment_totalamount=total_amount,
                payment_type=payment_type,
                transfer_image=transfer_image_url,
                payment_date=timezone.now(),
                payment_subtotal=0,
                payment_note=payment_notes,
                payment_method=get_object_or_404(HotelPaymentMethod,id=payment_method),
            )

            extension.payment_receipt = payment
            extension.save()

            return JsonResponse({
                'success': True,
                'redirect_url': f'/admin/bookings/extensionmovement'
            })

        except Exception as e:
            
            return JsonResponse({'success': False, 'message': str(e)})

    ctx = {
        'currency': currencies,
        'booking': booking,
        'payment_status': payment_status,
        'payment_methods': payment_methods,
        'payment_types': payment_types,
        'extension': extension,
    }
    return render(request, 'admin/bookings/payment.html', ctx)

  