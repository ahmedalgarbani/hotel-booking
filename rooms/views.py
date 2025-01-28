from django.shortcuts import get_object_or_404, redirect, render
from .forms import ReviewForm
from .models import RoomType
from datetime import datetime
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
        'stars': range(1, 6) #تجريبي
    }
    return render(request, 'frontend/home/pages/room-details.html', context)


