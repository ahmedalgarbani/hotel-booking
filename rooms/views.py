from django.shortcuts import render, get_object_or_404
from .models import RoomType, Availability, RoomPrice, RoomStatus
from datetime import datetime, timedelta
from django.db.models import Q, Min, Max, Sum

def get_room_price(room_type, date):
    """الحصول على السعر النهائي للغرفة في تاريخ معين"""
    # 1. نبحث عن سعر موسمي في RoomPrice أولاً
    seasonal_price = RoomPrice.objects.filter(
        room_type=room_type,
        date_from__lte=date,
        date_to__gte=date
    ).first()
    
    if seasonal_price:
        return seasonal_price.price, room_type.rooms_count, 'seasonal', seasonal_price
    
    # 2. نبحث في جدول التوافر
    availability = Availability.objects.filter(
        room_type=room_type,
        date=date
    ).first()
    
    if availability:
        return availability.price, availability.available_rooms, 'availability', availability
    
    # 3. نستخدم السعر الأساسي
    return room_type.base_price, room_type.rooms_count, 'base', None

def room_search(request):
    hotel_name = request.GET.get('hotel_name', '').strip()
    check_in_date = request.GET.get('check_in', '').strip()
    room_type_name = request.GET.get('room_type', '').strip()
    adults_count = int(request.GET.get('adult_number', 0))
    children_count = int(request.GET.get('child_number', 0))
    
    if check_in_date:
        try:
            check_in_start, check_out_start = check_in_date.split(' - ')
            check_in = datetime.strptime(check_in_start, '%m/%d/%Y').date()
            check_out = datetime.strptime(check_out_start, '%m/%d/%Y').date()
        except ValueError:
            check_in = check_out = datetime.now().date()
    else:
        check_in = check_out = datetime.now().date()

    # البحث عن الغرف المتوفرة
    query = RoomType.objects.filter(
        is_active=True,
        default_capacity__gte=adults_count
    )

    if hotel_name:
        query = query.filter(hotel__name__icontains=hotel_name)
    if room_type_name:
        query = query.filter(name__icontains=room_type_name)

    rooms_data = []
    for room in query:
        # الحصول على السعر وعدد الغرف المتوفرة
        price, available_rooms, price_type, price_obj = get_room_price(room, check_in)
        
        if available_rooms > 0:
            room_data = {
                'room': room,
                'price': price,
                'price_type': price_type,  # نوع السعر (موسمي، توفر، أساسي)
                'price_object': price_obj,  # كائن السعر للحصول على معلومات إضافية
                'available_rooms': available_rooms,
                'total_guests': adults_count + children_count,
                'check_in': check_in,
                'check_out': check_out
            }
            rooms_data.append(room_data)

    ctx = {
        'children_count': children_count,
        'adults_count': adults_count,
        'rooms': rooms_data,
        'check_in_start': check_in_start if check_in_date else '',
        'check_out_start': check_out_start if check_in_date else '',
        'room_type_name': room_type_name,
        'hotel_name': hotel_name,
    }
    return render(request, 'frontend/home/pages/room-search-result.html', ctx)

def room_detail(request, room_id):
    """عرض تفاصيل غرفة واحدة"""
    room = get_object_or_404(RoomType, id=room_id)
    check_date = request.GET.get('date')
    
    try:
        check_date = datetime.strptime(check_date, '%m/%d/%Y').date()
    except (ValueError, TypeError):
        check_date = datetime.now().date()
    
    # الحصول على السعر وعدد الغرف المتوفرة
    price, available_rooms, price_type, price_obj = get_room_price(room, check_date)
    
    room_data = {
        'room': room,
        'price': price,
        'price_type': price_type,  # نوع السعر (موسمي، توفر، أساسي)
        'price_object': price_obj,  # كائن السعر للحصول على معلومات إضافية
        'available_rooms': available_rooms,
        'date': check_date
    }
    
    return render(request, 'frontend/home/pages/room-details.html', {'room_data': room_data})
