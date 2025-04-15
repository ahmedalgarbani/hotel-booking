from django.utils import timezone
from django.shortcuts import get_object_or_404
from rooms.models import RoomPrice, RoomType
from datetime import timedelta

def get_room_price(room):
    """
    Retrieves the room price for today's date. 
    If no specific price is found, it falls back to the room type's base price.
    """
    today = timezone.now().date()

    # Check for a RoomPrice entry where today's date is within the defined range
    room_price_entry = RoomPrice.objects.filter(
        room_type=room,
        hotel=room.hotel,
        date_from__lte=today,
        date_to__gte=today
    ).first()

    if room_price_entry:
        return room_price_entry.price

    # Fallback to room type's base price if no RoomPrice found
    room_type = get_object_or_404(RoomType, id=room.id)
    return room_type.base_price

def calculate_total_cost(room, check_in_date, check_out_date, room_number):
    """
    Calculate the total cost for a room booking.
    """
    total_cost = 0.0
    last_room_price = None  # Track last room price

    delta = check_out_date - check_in_date
    num_days = delta.days

    for i in range(num_days):
        current_date = check_in_date + timedelta(days=i)
        room_price = RoomPrice.objects.filter(
            room_type=room,
            date_from__lte=current_date,
            date_to__gte=current_date
        ).first()
        
        if room_price:
            total_cost += float(room_price.price) * room_number
            last_room_price = room_price.price  # Store last price
        else:
            total_cost += float(room.base_price) * room_number
            last_room_price = room.base_price  # Default to base price

    return total_cost, last_room_price  # Ensure second value is not None
