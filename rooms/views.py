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


from django.utils import timezone
from datetime import timedelta
from django.db.models import Sum
from django.utils.dateparse import parse_date

def check_room_availability(room_type, check_in_date, check_out_date, room_number):
    """
    Check room type availability for specific dates and number of rooms.
    Returns a tuple (bool, str) where bool indicates availability and str contains any error message.
    """
    # Validate input parameters
    if not all([room_type, check_in_date, check_out_date, room_number]):
        return False, "بيانات الحجز غير مكتملة"
    
    # Calculate number of nights
    number_of_nights = (check_out_date - check_in_date).days
    
    if number_of_nights <= 0:
        return False, "يجب أن يكون تاريخ الخروج بعد تاريخ الدخول"
    
    if number_of_nights > 30:  # Optional: limit maximum stay
        return False, "الحد الأقصى للإقامة هو 30 يوماً"
        
    # Generate date range
    dates_range = [check_in_date + timedelta(days=i) for i in range(number_of_nights)]
    
    # Check availability for each date
    unavailable_dates = []
    for date in dates_range:
        availability = room_type.availabilities.filter(availability_date=date).first()
        if not availability:
            unavailable_dates.append(date.strftime('%Y-%m-%d'))
        elif availability.available_rooms < room_number:
            return False, f"عدد الغرف المطلوب غير متوفر في تاريخ {date.strftime('%Y-%m-%d')}"
    
    if unavailable_dates:
        return False, f"الغرف غير متوفرة في التواريخ التالية: {', '.join(unavailable_dates)}"
            
    return True, "الغرف متوفرة"

#تحت التطوير  

def room_detail(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)
    
    if request.method == 'POST':
        try:
            check_in_str = request.POST.get('check_in_date', '').strip()
            check_out_str = request.POST.get('check_out_date', '').strip()
            room_number = int(request.POST.get('room_number', 1))
            adult_number = int(request.POST.get('adult_number', 1))
            
            if not check_in_str or not check_out_str:
                messages.error(request, "يرجى تحديد تاريخ الدخول والخروج.")
                return redirect('rooms:room_detail', room_id=room_id)
            
            # Try to parse the date in YYYY-MM-DD format
            check_in_date = datetime.strptime(check_in_str, '%Y-%m-%d').date()
            check_out_date = datetime.strptime(check_out_str, '%Y-%m-%d').date()
            
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
            
            # Check room availability
            is_available, message = check_room_availability(room, check_in_date, check_out_date, room_number)
            if not is_available:
                messages.error(request, message)
                return redirect('rooms:room_detail', room_id=room_id)
            
            # Get selected extra services
            extra_services = request.POST.getlist('extra_services')
            
            # Calculate total price
            total_price = float(request.POST.get('total_price', room.base_price))
            
            # Store booking data in session
            request.session['booking_data'] = {
                'room_id': room_id,
                'hotel_id': room.hotel.id,  
                'check_in_date': check_in_str,
                'check_out_date': check_out_str,
                'room_number': room_number,
                'adult_number': adult_number,
                'extra_services': extra_services,
                'total_price': total_price
            }
            
            # Redirect to payment page with hotel_id
            return redirect('payments:checkout', hotel_id=room.hotel.id)
                
        except (ValueError, TypeError) as e:
            print("Date parsing error:", e)
            messages.error(request, "صيغة التاريخ غير صحيحة. الرجاء استخدام التنسيق YYYY-MM-DD")
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
            'is_negative_fee': service.additional_fee < 0
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

    if request.method == 'POST':
        form = ReviewForm(request.POST)
        if form.is_valid():
            # Check if a review already exists for this user, room, and hotel
            existing_review = RoomReview.objects.filter(
                user=request.user,
                room_type=room,
                hotel=room.hotel
            ).first()
            if existing_review:
                messages.error(request, "لقد قمت بالفعل بتقييم هذه الغرفة من قبل.") # Display error message
            else:
                review = form.save(commit=False)
                review.room_type = room
                review.hotel = room.hotel
                review.user = request.user
                review.save()
                messages.success(request, "تمت إضافة مراجعتك بنجاح.") # Optional success message
                return redirect('rooms:room_detail', room_id=room.id)
        else:
            messages.error(request, "يرجى تصحيح الأخطاء في النموذج.") # Display form errors
    else:
        form = ReviewForm()

    context = {
        'room': room,
        'reviews': reviews, # Now 'reviews' is a Page object
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
    }
    return render(request, 'frontend/home/pages/room-details.html', context)