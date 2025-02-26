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
# def room_search(request):
#     hotel_name, check_in,check_out, room_type_name, adult_number, room_number = get_query_params(request)
#     today = datetime.now().date()
#     hotels_query = get_hotels_query(hotel_name)
#     room_query = filter_room_query(hotels_query, room_type_name, adult_number, room_number, check_in)
#     available_rooms = filter_rooms_by_availability(room_query, check_in, check_out)
#     if not available_rooms:
#         available_rooms = RoomType.objects.all()
#     available_rooms_with_price = get_room_prices(available_rooms.distinct(), today)

    
#     ctx = {
#         'adult_number': adult_number,
#         'room_number': room_number,
#         'rooms': available_rooms_with_price,
#         'check_in_start': check_in.strftime('%m/%d/%Y') if check_in else '',
#         'check_out_start': check_out.strftime('%m/%d/%Y') if check_out else '',
#         'room_type_name': room_type_name,
#         'hotel_name': hotel_name,
#     }

#     return render(request, 'frontend/home/pages/room-search-result.html', ctx)


#تحت التطوير  

def room_detail(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)
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