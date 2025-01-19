from django.shortcuts import render
from HotelManagement.models import Hotel
from django.shortcuts import render, get_object_or_404

from reviews.models import HotelReview
# Create your views here.
def index(request):
    return render(request,'frontend/home/index.html')

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
