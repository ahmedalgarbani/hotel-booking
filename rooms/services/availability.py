from datetime import timedelta
from django.db.models import Q
from rooms.models import RoomType, Availability

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

def filter_rooms_by_availability(rooms, check_in, check_out):
    """
    Filter room types by availability for the given date range.
    """
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
