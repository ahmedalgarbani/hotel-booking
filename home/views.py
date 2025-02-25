from django.shortcuts import render
from HotelManagement.models import Hotel
from django.shortcuts import render, get_object_or_404
from payments.models import HotelPaymentMethod
from django.db.models import Avg, Count,Q
from django.db import models
from reviews.models import HotelReview
from rooms.models import Availability, RoomImage, RoomPrice, RoomType
from datetime import datetime
from django.db.models import Q, Count, Avg
from django.shortcuts import get_object_or_404, render

# Create your views here.
def index(request):
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
    availability = Availability.objects.filter(hotel=hotel, available_rooms__gt=0)
    hotels = Hotel.objects.filter(is_verified=True).exclude(id=hotel.id)
    reviews = HotelReview.objects.filter(status=True, hotel=hotel)
    room_images = RoomImage.objects.filter(hotel=hotel).order_by('-is_main', 'room_type')

    for available_room in availability:
        try:
            availability_price = Availability.objects.filter(
                room_type_id=available_room.room_type.id,
                hotel_id=hotel.id,
                date=today
            ).first()
            if availability_price:
                available_room.price = availability_price.price
            else:
                room_prices = RoomPrice.objects.filter(
                    room_type_id=available_room.room_type.id,
                    hotel_id=hotel.id,
                    date_from__lte=today,
                    date_to__gte=today
                ).order_by('-date_from')

                if room_prices.exists():
                    available_room.price = room_prices.first().price
                else:
                    available_room.price = available_room.room_type.base_price
        except Exception as e:
            available_room.price = available_room.room_type.base_price
    print(available_room.price)
    ctx = {
        'hotel': hotel,
        'hotels': hotels,
        'reviews': reviews,
        'review_count': hotel.review_count,
        'avg_rating_service': hotel.avg_rating_service,
        'avg_rating_location': hotel.avg_rating_location,
        'avg_rating_value_for_money': hotel.avg_rating_value_for_money,
        'avg_rating_cleanliness': hotel.avg_rating_cleanliness,
        'availability': availability,
        'room_images': room_images,
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