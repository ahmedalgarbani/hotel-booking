from django.shortcuts import render
from HotelManagement.models import Hotel
from django.shortcuts import render, get_object_or_404
from blog.models import Post
from home.models import *
from payments.models import HotelPaymentMethod
from django.db.models import Avg, Count,Q,OuterRef, Subquery, Max,F
from django.db import models
from reviews.models import HotelReview
from rooms.models import Availability, Category, RoomImage, RoomPrice, RoomType
from datetime import datetime
from django.db.models import Q, Count, Avg,Min
from django.shortcuts import get_object_or_404, render
from services.models import HotelService
from .models import TeamMember, Partner, Testimonial
# Create your views here.

def index(request):
    for key in list(request.session.keys()):
        if not key.startswith("_"): 
            del request.session[key]
    
    roomTypes = RoomType.objects.filter(is_active=True)
    blogs = Post.objects.filter(is_published=True)[:3]
    infoBox = InfoBox.objects.filter(show_at_home=True)[:4]
    roomTypeHome = RoomTypeHome.objects.filter(show_at_home=True)[:2]
    categories = Category.objects.all()
    try:
        setting = Setting.objects.latest('id')
    except Setting.DoesNotExist:
        setting = None  # or provide a default value
    
    try:
        heroSlider = HeroSlider.objects.filter(is_active=True).latest('id')
    except HeroSlider.DoesNotExist:
        heroSlider = None  # or provide a default value
    
    socialMediaLink = SocialMediaLink.objects.filter(status=True)
    hotels = Hotel.objects.filter(is_verified=True).annotate(
        review_count=Count('hotel_reviews'),
        average_rating=Avg('hotel_reviews__rating_service')
    )[:5]
    
    ctx = {
        'roomTypes': roomTypes,
        'blogs': blogs,
        'infoBox': infoBox,
        'roomTypeHome': roomTypeHome,
        'categories':categories,
        'hotels': hotels,
        'setting': setting,
        'socialMediaLink': socialMediaLink,
        'heroSlider': heroSlider
    }
    return render(request, 'frontend/home/index.html', ctx)

def about(request):
    team_members = TeamMember.objects.all()
    partners = Partner.objects.all()
    testimonials = Testimonial.objects.all()

    context = {
        'team_members': team_members,
        'partners': partners,
        'testimonials': testimonials,
    }

   
   
    return render(request,'frontend/home/pages/about.html' ,context)






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
    external_hotels = Hotel.objects.exclude(id=hotel.id)[:6]
    reviews = HotelReview.objects.filter(status = True)

    today = datetime.now().date()

    available_room_types = Availability.objects.filter(
        hotel=hotel,
        available_rooms__gt=0,
    ).select_related('room_type')

    # Subquery to get the latest 'created_at' per room_type
    latest_availability = Availability.objects.filter(
        hotel=hotel,
        room_type=OuterRef('room_type'),
        available_rooms__gt=0,
    ).order_by('-created_at')

    # Annotate each availability record with the latest one for each room type
    available_room_types = available_room_types.annotate(
        latest_record=Subquery(latest_availability.values('created_at')[:1])
    ).filter(
        created_at=F('latest_record')
    )

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
        'reviews':reviews ,
        'external_hotels':external_hotels
    }

    return render(request, 'frontend/home/pages/hotel-single.html', ctx)



def room_search_result(request):

    ctx = {

    }
    return render(request,'frontend/home/pages/room-search-result.html',ctx)


from django.core.paginator import Paginator

def room_list(request):
    categories = Category.objects.prefetch_related('room_types').all()
    all_rooms = RoomType.objects.filter(is_active=True).select_related('category', 'hotel')
    paginator = Paginator(all_rooms, 10)  
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'categories': categories,
        'page_obj': page_obj,
        'paginator': paginator,
    }
    return render(request, 'frontend/home/pages/room-list.html', context)