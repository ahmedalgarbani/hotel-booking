from django.shortcuts import render
from HotelManagement.models import Hotel
from django.shortcuts import render, get_object_or_404
from payments.models import HotelPaymentMethod
from django.db.models import Avg, Count,Q
from django.db import models
from reviews.models import HotelReview
from rooms.models import Availability, RoomImage, RoomPrice, RoomType
from datetime import datetime
from django.db.models import Q, Count, Avg,Min
from django.shortcuts import get_object_or_404, render

from services.models import HotelService

# Create your views here.
def index(request):
    request.session.flush() 
    roomTypes = RoomType.objects.filter(is_active = True)
    ctx = {
        'roomTypes':roomTypes
    }
    return render(request,'frontend/home/index.html',ctx)

def about(request):
    return render(request,'frontend/home/pages/about.html')

def hotels(request):
    hotels = Hotel.objects.filter(is_verified=True)
    ctx = {
        'hotels':hotels,
    }
    return render(request,'frontend/home/pages/hotel-sidebar.html',ctx)



def hotel_detail(request, slug):
    hotel = get_object_or_404(
        Hotel.objects.annotate(
            review_count=Count('hotel_reviews', filter=Q(hotel_reviews__status=True)),
            avg_rating_service=Avg('hotel_reviews__rating_service', filter=Q(hotel_reviews__status=True)),
            avg_rating_location=Avg('hotel_reviews__rating_location', filter=Q(hotel_reviews__status=True)),
            avg_rating_value_for_money=Avg('hotel_reviews__rating_value_for_money', filter=Q(hotel_reviews__status=True)),
            avg_rating_cleanliness=Avg('hotel_reviews__rating_cleanliness', filter=Q(hotel_reviews__status=True))
        ),
        slug=slug
    )

    today = datetime.now().date()

    available_room_types = Availability.objects.filter(
        hotel=hotel,
        available_rooms__gt=0,
        availability_date=today
    ).select_related('room_type').distinct()

    for available_room in available_room_types:
        room_price = RoomPrice.objects.filter(
            room_type=available_room.room_type,
            hotel=hotel,
            date_from__lte=today,
            date_to__gte=today
        ).order_by('-date_from').first()
        available_room.services = available_room.room_type.room_services.filter(is_active=True).order_by('id')[:4]

        if room_price:
            available_room.price = room_price.price 
        else:
            available_room.price = available_room.room_type.base_price  

    hotel_services = HotelService.objects.filter(hotel=hotel, is_active=True)
    ctx = {
        'hotel': hotel,
        'available_room_types': available_room_types,
        'hotel_services': hotel_services,  
    }

    return render(request, 'frontend/home/pages/hotel-single.html', ctx)


def room_search_result(request):

    ctx = {

    }
    return render(request,'frontend/home/pages/room-search-result.html',ctx)


def room_list(request):
    roomTypes = RoomType.objects.filter(is_active = True)
    ctx = {
        'roomTypes':roomTypes,
    }
    return render(request,'frontend/home/pages/room-list.html',ctx)