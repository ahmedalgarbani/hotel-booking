from django.contrib import messages
from django.shortcuts import get_object_or_404, redirect, render
from django.utils.text import slugify
from .forms import ReviewForm
from .models import RoomType
from reviews.models import RoomReview
from datetime import datetime
from django.utils import timezone
from datetime import timedelta
from django.db.models import Avg
from .services import *

from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Avg
from django.utils import timezone
from datetime import datetime, timedelta
from .models import RoomType, RoomPrice,RoomImage# Make sure to import RoomReview
from .forms import ReviewForm
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger # Import Paginator and exceptions
import uuid  
from decimal import Decimal
from services.models import Coupon, RoomTypeService
    

from django.utils import timezone
from datetime import timedelta
from django.db.models import Sum
from django.utils.dateparse import parse_date
from decimal import Decimal
from services.models import RoomTypeService
# def check_room_availability(room_type, check_in_date, check_out_date, room_number):
#     """
#     Check room type availability for specific dates and number of rooms.
#     Returns a tuple (bool, str) where bool indicates availability and str contains any error message.
#     """
#     # Validate input parameters
#     if not all([room_type, check_in_date, check_out_date, room_number]):
#         return False, "بيانات الحجز غير مكتملة"
    
#     # Check if room type is active
#     if not room_type.is_active:
#         return False, "هذا النوع من الغرف غير متاح للحجز حالياً"
    
#     # Calculate number of nights
#     number_of_nights = (check_out_date - check_in_date).days
    
#     if number_of_nights <= 0:
#         return False, "يجب أن يكون تاريخ الخروج بعد تاريخ الدخول"
    
#     if number_of_nights > 30:  # Optional: limit maximum stay
#         return False, "الحد الأقصى للإقامة هو 30 يوماً"
        
#     # Generate date range
#     dates_range = [check_in_date + timedelta(days=i) for i in range(number_of_nights)]
    
#     # Check availability for each date
#     unavailable_dates = []
#     for date in dates_range:
#         # Get availability for this date
#         availability = room_type.availabilities.filter(
#             availability_date=date
#         ).select_related('room_status').first()
        
#         if not availability:
#             unavailable_dates.append(date.strftime('%Y-%m-%d'))
#         else:
#             # Check if room status allows booking
#             if not availability.room_status.is_available:
#                 return False, f"الغرف غير متاحة للحجز في تاريخ {date.strftime('%Y-%m-%d')} بسبب {availability.room_status.name}"
            
#             # Check if enough rooms are available
#             if availability.available_rooms < room_number:
#                 return False, f"عدد الغرف المطلوب غير متوفر في تاريخ {date.strftime('%Y-%m-%d')}. المتوفر: {availability.available_rooms} غرفة"
    
#     if unavailable_dates:
#         return False, f"الغرف غير متوفرة في التواريخ التالية: {', '.join(unavailable_dates)}"
            
#     return True, "الغرف متوفرة"

#تحت التطوير  

def calculate_total_price(room, check_in_date, check_out_date, room_number, extra_services):
    """
    Calculate total price for the room booking including extra services.
    
    Args:
        room: RoomType instance
        check_in_date: datetime.date
        check_out_date: datetime.date
        room_number: int
        extra_services: list of service IDs
    
    Returns:
        Decimal: total price
    """
 
    
    # Calculate number of nights
    number_of_nights = (check_out_date - check_in_date).days
    
    # Get room price for each date
    total_price = Decimal('0')
    for i in range(number_of_nights):
        current_date = check_in_date + timedelta(days=i)
        # Check if there's a special price for this date
        price_obj = room.prices.filter(
            date_from__lte=current_date,
            date_to__gte=current_date
        ).order_by('-is_special_offer').first()
        
        # Use special price if available, otherwise use base price
        if price_obj:
            daily_price = Decimal(str(price_obj.price))
        else:
            daily_price = Decimal(str(room.base_price))
        total_price += daily_price
    
    # Multiply by number of rooms
    total_price *= Decimal(str(room_number))
    
    # Add extra services
    if extra_services:
        services = RoomTypeService.objects.filter(id__in=extra_services)
        for service in services:
            # Add service price for each room and each night
            service_price = Decimal(str(service.additional_fee))
            service_total = service_price * Decimal(str(room_number)) * Decimal(str(number_of_nights))
            total_price += service_total
    
    return total_price

def room_detail(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)
    external_rooms = RoomType.objects.exclude(id=room_id)[:6]
    
    if request.method == 'POST':
        try:
            # Get and validate form data
            check_in_str = request.POST.get('check_in_date', '').strip()
            check_out_str = request.POST.get('check_out_date', '').strip()
            
            try:
                room_number = int(request.POST.get('room_number', 1))
                adult_number = int(request.POST.get('adult_number', 1))
            except ValueError:
                messages.error(request, "يجب أن يكون عدد الغرف وعدد الأشخاص أرقاماً صحيحة.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            extra_services = request.POST.getlist('extra_services')
            
            if not check_in_str or not check_out_str:
                messages.error(request, "يرجى تحديد تاريخ الدخول والخروج.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            try:
                # Parse dates
                check_in_date = datetime.strptime(check_in_str, '%Y-%m-%d').date()
                check_out_date = datetime.strptime(check_out_str, '%Y-%m-%d').date()
            except ValueError:
                messages.error(request, "صيغة التاريخ غير صحيحة. يجب أن تكون بالشكل YYYY-MM-DD.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            # Validate dates
            today = timezone.now().date()
            if check_in_date < today:
                messages.error(request, "لا يمكن اختيار تاريخ دخول في الماضي.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            if check_out_date <= check_in_date:
                messages.error(request, "يجب أن يكون تاريخ الخروج بعد تاريخ الدخول.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            # Validate room number and adult number
            if room_number < 1:
                messages.error(request, "يجب أن يكون عدد الغرف 1 على الأقل.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            if adult_number > room.max_capacity:
                messages.error(request, f"السعة القصوى لهذا النوع من الغرف هي {room.max_capacity} أشخاص.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            is_available, message = check_room_availability(room, room.hotel, room_number)
         
            if not is_available:
                messages.error(request, message)
                return redirect('rooms:room_detail', room_id=room_id)
            
            try:
                # Calculate total price
                total_price = calculate_total_price(room, check_in_date, check_out_date, room_number, extra_services)
            except Exception as e:
                messages.error(request, f"حدث خطأ في حساب السعر: {str(e)}")
                return redirect('rooms:room_detail', room_id=room_id)
            
            # Store booking data in session
            request.session['booking_data'] = {
                'room_id': room_id,
                'hotel_id': room.hotel.id,
                'check_in_date': check_in_str,
                'check_out_date': check_out_str,
                'room_number': room_number,
                'adult_number': adult_number,
                'extra_services': extra_services,
                'total_price': str(total_price)
            }
            
            # Redirect to checkout
            return redirect('payments:process_booking', room_id=room.id)
            
        except Exception as e:
            print(f"Error in room_detail: {str(e)}")  # Add logging
            messages.error(request, f"حدث خطأ في معالجة البيانات: {str(e)}")
            return redirect('rooms:room_detail', room_id=room_id)
    
    image=RoomImage.objects.filter(room_type=room)
    reviews_list = RoomReview.objects.filter(room_type=room, status=True).order_by('-created_at') # Fetch only active reviews and order them
    if reviews_list.exists():
        average_rating = reviews_list.aggregate(Avg('rating'))['rating__avg']
        average_rating = round(average_rating, 1) if average_rating else 0.0 # Handle case where average_rating is None
    else:
        average_rating = 0.0 # Default to 0 if no reviews

    # Pagination for reviews
    page = request.GET.get('page')
    paginator = Paginator(reviews_list, 3) # Show 3 reviews per page, adjust as needed
    try:
        reviews = paginator.page(page)
    except PageNotAnInteger:
        reviews = paginator.page(1) # If page is not an integer, deliver first page.
    except EmptyPage:
        reviews = paginator.page(paginator.num_pages) # If page is out of range (e.g. 9999), deliver last page of results.


    services = room.room_services.filter(room_type=room, is_active=True).order_by('id')

    services_list = [
        {
            'id': service.id,
            'name': service.name,
            'description': service.description,
            'icon': service.icon.url if service.icon else None,
            'additional_fee': service.additional_fee > 0,
            'is_negative_fee': service.additional_fee < 0,
            'additional_price':service.additional_fee
            
        }
        for service in services
    ]

    today = timezone.now().date()

    room_price = RoomPrice.objects.filter(
        room_type=room,
        hotel=room.hotel,
        date_from__lte=today,
        date_to__gte=today
    ).order_by('-date_from').first()

    price = room_price.price if room_price else room.base_price

    check_in = request.GET.get('check_in')
    check_out = request.GET.get('check_out')

    try:
        check_in_date = datetime.strptime(check_in, '%Y-%m-%d %H:%M') if check_in else timezone.now()
        check_out_date = datetime.strptime(check_out, '%Y-%m-%d %H:%M') if check_out else (timezone.now() + timedelta(days=1))
    except (ValueError, TypeError):
        check_in_date = timezone.now()
        check_out_date = timezone.now() + timedelta(days=1)

    
    form = ReviewForm()

    context = {
        'room': room,
        'reviews': reviews, 
        'services': services_list,
        'price': price,
        'form': form,
        'stars': range(1, 6),
        'check_in': check_in_date.strftime('%Y-%m-%d %H:%M'),
        'check_out': check_out_date.strftime('%Y-%m-%d %H:%M'),
        'check_in_display': check_in_date.strftime('%d/%m/%Y %I:%M %p'),
        'check_out_display': check_out_date.strftime('%d/%m/%Y %I:%M %p'),
        'average_rating': average_rating,
        'image':image,
        'external_rooms':external_rooms
    }
    return render(request, 'frontend/home/pages/room-details.html', context)