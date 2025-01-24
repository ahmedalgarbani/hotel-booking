from django.shortcuts import render
from .models import Booking

# Create your views here.

def booking_list(request):
    bookings = Booking.objects.all()
    return render(request, 'bookings/booking_list.html', {'bookings': bookings})
