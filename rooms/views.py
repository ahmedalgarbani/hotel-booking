from django.shortcuts import render
from .models import RoomType, Availability
from datetime import datetime, timedelta
from django.db.models import Q, Min, Max, Sum

def room_search(request):
    hotel_name = request.GET.get('hotel_name', '').strip()
    check_in_date = request.GET.get('check_in', '').strip()
    room_type_name = request.GET.get('room_type', '').strip()
    adults_count = int(request.GET.get('adult_number', 0))
    children_count = int(request.GET.get('child_number', 0))
    
    # تحويل التواريخ
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
        is_active=True,  # فقط الغرف النشطة
        default_capacity__gte=adults_count,  # تناسب عدد الضيوف
        availabilities__date=check_in,  # لديها سجل توفر في التاريخ المطلوب
        availabilities__available_rooms__gt=0,  # متوفر منها غرف
        availabilities__room_status__is_available=True  # حالتها متاحة للحجز
    )

    if hotel_name:
        query = query.filter(hotel__name__icontains=hotel_name)
    if room_type_name:
        query = query.filter(name__icontains=room_type_name)

    # نجلب الغرف مع معلومات التوفر
    available_rooms = query.prefetch_related('availabilities').distinct()
    
    rooms_data = []
    for room in available_rooms:
        # نجلب سجل التوفر لليوم المطلوب
        availability = room.availabilities.filter(
            date=check_in
        ).first()
        
        if availability:
            room_data = {
                'room': room,
                'price': availability.price,
                'available_rooms': availability.available_rooms,
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
