from django.shortcuts import get_object_or_404, render

from HotelManagement.models import City, Hotel
from .models import RoomType, RoomPrice, Availability
from datetime import datetime
from django.db.models import Q

def room_search(request):
    hotel_name = request.GET.get('hotel_name', '').strip()
    check_in_date = request.GET.get('check_in', '').strip()
    room_type_name = request.GET.get('room_type', '').strip()
    adults_count = request.GET.get('adult_number', 0)
    children_count = request.GET.get('child_number', 0)
    print(hotel_name)
    city = get_object_or_404(City,Q(state__icontains=hotel_name) )
    print(city)
    print(city)
    print(city)
    print(city.id)
    print(city.id)
    #for check hotel name
    #Ahmad edite
    hotel = Hotel.objects.filter(location__city=city)
    
    if check_in_date:
        try:
            check_in_start, check_out_start = check_in_date.split(' - ')
            check_in = datetime.strptime(check_in_start, '%m/%d/%Y') if check_in_start else None
            check_out = datetime.strptime(check_out_start, '%m/%d/%Y') if check_out_start else None
        except ValueError:
            check_in = check_out = None
            print("Invalid date range format")
    else:
        check_in = check_out = None

    query = RoomType.objects.all()
    if hotel_name:
        query = query.filter(hotel__name__icontains=hotel_name)
    if room_type_name:
        query = query.filter(name__icontains=room_type_name)

    available_rooms = query.distinct()
    today = datetime.now().date()

    for room in available_rooms:
        try:
            availability_price = Availability.objects.filter(
                room_type_id=room.id,
                hotel_id=room.hotel.id,
                date=today
            ).first()
            if availability_price:
                room.base_price = availability_price.price
            else:
                room_prices = RoomPrice.objects.filter(
                    room_type_id=room.id,
                    hotel_id=room.hotel.id,
                    date_from__lte=today,
                    date_to__gte=today
                ).order_by('-date_from')

                if room_prices.exists():
                    latest_price = room_prices.first()
                    room.base_price = latest_price.price
                else:
                    room.base_price = room.base_price
        except Exception as e:
            room.base_price = room.base_price

    ctx = {
        'children_count': children_count,
        'adults_count': adults_count,
        'rooms': RoomType.objects.all(),
        'check_in_start': check_in_start,
        'check_out_start': check_out_start,
        'room_type_name': room_type_name,
        'hotel_name': hotel_name,
    }
    return render(request, 'frontend/home/pages/room-search-result.html', ctx)
