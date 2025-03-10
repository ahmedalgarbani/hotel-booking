from django.shortcuts import render
from .models import Booking, Guest
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
   
def set_guests_check_out_date( request, guest_id):
        guest = Guest.objects.get(pk=guest_id)
        guest.check_out_date = timezone.now()
        guest.save()
        return redirect(request.META.get('HTTP_REFERER', 'admin:index'))
   