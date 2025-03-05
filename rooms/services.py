from django.shortcuts import get_object_or_404, redirect, render
from HotelManagement.models import City, Hotel
from .forms import ReviewForm
from .models import RoomType, RoomPrice, Availability
from datetime import datetime, timedelta
from django.db.models import Q



def change_date_format(date_str):
    date_obj = datetime.strptime(date_str, "%m/%d/%Y")  
    formatted_date_str = date_obj.strftime("%Y-%m-%d 00:00:00")
    formatted_date = datetime.strptime(formatted_date_str, "%Y-%m-%d 00:00:00")
 
    print(formatted_date) 
    return formatted_date




def get_query_params(request):
    if request.method == 'GET':
        hotel_name = request.GET.get('hotel_name', '').strip()
        check_date = request.GET.get('check_date', '').strip()
        room_type_name = request.GET.get('room_type', '').strip()

        try:
            adult_number = int(request.GET.get('adult_number', 0))
        except ValueError:
            adult_number = 0

        try:
            room_number = int(request.GET.get('room_number', 0))
        except ValueError:
            room_number = 0

        check_in,check_out = parse_check_in_date(check_date)


    elif request.method == 'POST':
        hotel_name = room_type_name = None
        check_in =change_date_format(request.POST.get('check_in_start', '').strip())
        check_out = change_date_format(request.POST.get('check_out_start', '').strip())

        try:
            adult_number = int(request.POST.get('adult_number', 0))
        except ValueError:
            adult_number = 0

        try:
            room_number = int(request.POST.get('room_number', 0))
        except ValueError:
            room_number = 0


    return hotel_name, check_in,check_out, room_type_name, adult_number, room_number

def parse_check_in_date(check_in_date):
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
    return    check_in, check_out


def get_hotels_query(hotel_name):
    hotels_query = Hotel.objects.all()
    if hotel_name:
        cities = City.objects.filter(Q(state__icontains=hotel_name) )
        hotels_by_city = Hotel.objects.filter(location__city__in=cities)
        hotels_by_name = Hotel.objects.filter(name__icontains=hotel_name)
        hotels_query = (hotels_by_city | hotels_by_name).distinct()
    return hotels_query


def filter_room_query(hotels_query, room_type_name, adult_number, room_number, check_in):
    today = datetime.now().date()
    room_query = RoomType.objects.filter(hotel__in=hotels_query)

    if room_type_name:
        room_query = room_query.filter(name__icontains=room_type_name)

    if adult_number > 0:
        room_query = room_query.filter(default_capacity__gte=adult_number)

    if room_number > 0:
        target_date = check_in or today
        room_query = room_query.filter(
            availabilities__availability_date=target_date,
            availabilities__available_rooms__gte=room_number,
        ).distinct()

    return room_query


def get_room_prices(available_rooms, today):
    for room in available_rooms:
        room_price = RoomPrice.objects.filter(
            room_type=room,
            hotel=room.hotel,
            date_from__lte=today,
            date_to__gte=today
        ).order_by('-date_from').first()
        room.base_price = room_price.price if room_price else room.base_price
    return available_rooms



def filter_rooms_by_availability(rooms, check_in, check_out):
    if check_in == check_out:
        return rooms

    date_range = [(check_in + timedelta(days=i)).date() for i in range((check_out - check_in).days + 1)]

    available_rooms = rooms.filter(
        availabilities__availability_date__in=date_range,
        availabilities__available_rooms__gte=1
    ).distinct()

    final_rooms = []

    for room in available_rooms:
        availability_dates = room.availabilities.filter(
            availability_date__in=date_range,
            available_rooms__gte=1
        ).values_list('availability_date', flat=True)

        if set(date_range).issubset(set(availability_dates)):
            final_rooms.append(room)

    available_rooms = RoomType.objects.filter(id__in=[room.id for room in final_rooms])
   
    return available_rooms










# ---------------- New Services -------------------


from datetime import timedelta

def check_room_availability(room_type, hotel, room_number):
    """
    Check the latest room availability record for a specific hotel and room type.
    Returns a tuple (bool, str) where bool indicates availability and str contains any error message.
    """
    if not all([room_type, hotel, room_number]):
        return False, "بيانات الحجز غير مكتملة"
    
    if not room_type.is_active:
        return False, "هذا النوع من الغرف غير متاح للحجز حالياً"
    
    latest_availability = room_type.availabilities.filter(
        hotel=hotel
    ).order_by('-created_at').first()
    
    if not latest_availability:
        return False, "لا توجد بيانات توفر حديثة لهذا النوع من الغرف في هذا الفندق"
    
    if not latest_availability.room_status.code == 'AVAILABLE':
        return False, f"الغرف غير متاحة للحجز بسبب {latest_availability.room_status.code}"
    
    if latest_availability.available_rooms < room_number:
        return False, f"عدد الغرف المطلوب غير متوفر. المتوفر حالياً: {latest_availability.available_rooms} غرفة"

    return True, "الغرف متوفرة"
