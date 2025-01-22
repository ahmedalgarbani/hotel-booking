from django.shortcuts import render
from HotelManagement.models import Hotel
from django.shortcuts import render, get_object_or_404
from payments.models import HotelPaymentMethod

from reviews.models import HotelReview
from rooms.models import RoomType
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
    hotel = get_object_or_404(Hotel, slug=slug)
    hotels = Hotel.objects.filter(is_verified=True).exclude(id=hotel.id)
    reviews = HotelReview.objects.filter(status=True, hotel=hotel)  
    
    ctx = {
        'hotel': hotel,
        'hotels': hotels,
        'reviews': reviews  
    }
    return render(request, 'frontend/home/pages/hotel-single.html', ctx)


def room_search_result(request):

    ctx = {

    }
    return render(request,'frontend/home/pages/room-search-result.html',ctx)

def checkout(request):
    hotel = get_object_or_404(Hotel,id=1)
    paymentsMethods = hotel.payment_methods.all()
  
    ctx = {
        'paymentsMethods':paymentsMethods,
    }
    return render(request,'frontend/home/pages/checkout.html',ctx)


def room_list(request):
    roomTypes = RoomType.objects.filter(is_active = True)
    ctx = {
        'roomTypes':roomTypes,
    }
    return render(request,'frontend/home/pages/room-list.html',ctx)