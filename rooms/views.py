from django.shortcuts import get_object_or_404, redirect, render
from .forms import ReviewForm
from .models import RoomType
from datetime import datetime
from django.utils import timezone
from datetime import timedelta
from .services import *


def room_search(request):
    hotel_name, check_in,check_out, room_type_name, adult_number, room_number = get_query_params(request)
    today = datetime.now().date()
    hotels_query = get_hotels_query(hotel_name)
    room_query = filter_room_query(hotels_query, room_type_name, adult_number, room_number, check_in)
    available_rooms = filter_rooms_by_availability(room_query, check_in, check_out)
    if not available_rooms:
        available_rooms = RoomType.objects.all()
    available_rooms_with_price = get_room_prices(available_rooms.distinct(), today)

    
    ctx = {
        'adult_number': adult_number,
        'room_number': room_number,
        'rooms': available_rooms_with_price,
        'check_in_start': check_in.strftime('%m/%d/%Y') if check_in else '',
        'check_out_start': check_out.strftime('%m/%d/%Y') if check_out else '',
        'room_type_name': room_type_name,
        'hotel_name': hotel_name,
    }

    return render(request, 'frontend/home/pages/room-search-result.html', ctx)


#تحت التطوير  
def room_detail(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)
    reviews = room.reviews.all()
    
    # استرجاع تواريخ تسجيل الدخول والخروج من الـ GET parameters
    check_in = request.GET.get('check_in')
    check_out = request.GET.get('check_out')
    
    # تحويل التواريخ إلى التنسيق المناسب
    try:
        check_in_date = datetime.strptime(check_in, '%Y-%m-%d %H:%M') if check_in else timezone.now()
        check_out_date = datetime.strptime(check_out, '%Y-%m-%d %H:%M') if check_out else (timezone.now() + timedelta(days=1))
    except (ValueError, TypeError):
        check_in_date = timezone.now()
        check_out_date = timezone.now() + timedelta(days=1)
    
    if request.method == 'POST':
        form = ReviewForm(request.POST)
        if form.is_valid():
            review = form.save(commit=False)
            review.room_type = room
            review.hotel = room.hotel  
            review.user = request.user
            review.save()
            return redirect('rooms:room_detail', room_id=room.id)
    else:
        form = ReviewForm()

    context = {
        'room': room,
        'reviews': reviews,
        'form': form,
        'stars': range(1, 6),
        'check_in': check_in_date.strftime('%Y-%m-%d %H:%M'),
        'check_out': check_out_date.strftime('%Y-%m-%d %H:%M'),
        'check_in_display': check_in_date.strftime('%d/%m/%Y %I:%M %p'),
        'check_out_display': check_out_date.strftime('%d/%m/%Y %I:%M %p')
    }
    return render(request, 'frontend/home/pages/room-details.html', context)
