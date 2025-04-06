from django.shortcuts import render
from HotelManagement.models import Hotel
from django.shortcuts import render, get_object_or_404
from blog.models import Post
from customer.models import Favourites
from home.forms import ContactForm
from home.models import *
from payments.models import HotelPaymentMethod
from django.db.models import Avg, Count,Q,OuterRef, Subquery, Max,F
from django.db import models
from reviews.models import HotelReview
from rooms.models import Availability, Category, RoomImage, RoomPrice, RoomType
from datetime import datetime
from django.db.models import Q, Count, Avg,Min
from django.shortcuts import get_object_or_404, render
from services.models import Coupon, HotelService
from .models import TeamMember, Partner, Testimonial
from .models import PricingPlan
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger 
from django.shortcuts import render, redirect
from django.core.mail import send_mail
from .models import ContactMessage

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

def price(request):

    context = {
    }

   
   
    return render(request,'frontend/home/pages/pricing.html' ,context)

def price(request):
    pricing_plans = PricingPlan.objects.filter(is_active=True)[:3]
    
    context = {
        'pricing_plans': pricing_plans,
    }

   
   
    return render(request,'frontend/home/pages/pricing.html' ,context)

def contact(request):

    context = {
    }

   
   
    return render(request,'frontend/home/pages/contact.html' ,context)

def service(request):

    context = {
    }

   
   
    return render(request,'frontend/home/pages/services.html' ,context)







def pricing(request):
    pricing_plans = PricingPlan.objects.filter(is_active=True)
    context = {
        'pricing_plans': pricing_plans,
    }
    return render(request, 'frontend/home/pages/pricing.html', context)





from django.db.models import Count, Q, Case, When, BooleanField

def hotels(request):
    # Get search parameters
    search_query = request.GET.get('search', '')
    isHotelsPage = request.GET.get('hotels', 'False')
    rooms = request.GET.get('rooms', '')
    persons = request.GET.get('persons', '')
    max_persons = request.GET.get('max_persons', '')
    min_price = request.GET.get('min_price', '')
    max_price = request.GET.get('max_price', '')
    ratings = request.GET.getlist('rating')  
    services = request.GET.getlist('services')  
    
    all_services = HotelService.objects.filter(is_active=True).values('id', 'name').distinct().order_by('name')
    all_services = list({service['name']: service for service in all_services}.values())

    hotels = Hotel.objects.filter(is_verified=True)

    # Filter hotels based on rooms and capacity
    if rooms and persons and max_persons:
        try:
            rooms = int(rooms)
            persons = int(persons)
            max_persons = int(max_persons)
            hotels = hotels.filter(
                room_types__is_active=True,
                room_types__rooms_count__gte=rooms,
                room_types__default_capacity__gte=persons,
                room_types__max_capacity__gte=max_persons
            ).distinct()
        except ValueError:
            pass  

    # Filter by price range
    if min_price or max_price:  
        try:
            if min_price:
                min_price = float(min_price)
                hotels = hotels.filter(room_types__base_price__gte=min_price)
            if max_price:
                max_price = float(max_price)
                hotels = hotels.filter(room_types__base_price__lte=max_price)
            hotels = hotels.distinct()
        except ValueError:
            pass  

    # Filter by ratings
    if ratings:
        try:
            ratings = [int(r) for r in ratings]
            hotels = hotels.filter(hotel_reviews__rating_service__in=ratings).distinct()
        except ValueError:
            pass
            
    # Filter by services
    if services:
        try:
            services = [int(s) for s in services]
            hotels = hotels.filter(hotel_services__id__in=services).distinct()
            hotels = hotels.annotate(
                matched_services=Count('hotel_services', filter=Q(hotel_services__id__in=services))
            )
        except ValueError:
            pass 

    if search_query:
        hotels = hotels.filter(
            Q(name__icontains=search_query) |
            Q(location__address__icontains=search_query) |
            Q(location__city__state__icontains=search_query)
        )

    if request.user.is_authenticated:
        favorite_hotel_ids = Favourites.objects.filter(user=request.user).values_list('hotel_id', flat=True)
        hotels = hotels.annotate(
            is_favorite=Case(
                When(id__in=favorite_hotel_ids, then=True),
                default=False,
                output_field=BooleanField()
            )
        )
    else:
        hotels = hotels.annotate(is_favorite=False)
  
    ctx = {
        'hotels': hotels,
        'search_query': search_query,
        'rooms': rooms,
        'persons': persons,
        'max_persons': max_persons,
        'min_price': min_price,
        'max_price': max_price,
        'ratings': ratings or [],  
        'all_services': all_services,  
        'selected_services': services or [],  
    }

    if isHotelsPage == '_':
        return render(request, 'frontend/home/pages/hotel-search-result.html', ctx)
    return render(request, 'frontend/home/pages/hotel-sidebar.html', ctx)



from django.db.models import Count, Avg, Q, F, Subquery, OuterRef

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
    coupon = Coupon.objects.filter(hotel=hotel).order_by('-created_at').first()

    external_hotels = Hotel.objects.exclude(id=hotel.id)[:6]
    reviews = HotelReview.objects.filter(status=True)

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

    if request.user.is_authenticated:
        favorite_hotel_ids = Favourites.objects.filter(user=request.user).values_list('hotel_id', flat=True)
        external_hotels = external_hotels.annotate(
            is_favorite=Case(
                When(id__in=favorite_hotel_ids, then=True),
                default=False,
                output_field=BooleanField()
            )
        )
    

    ctx = {
        'hotel': hotel,
        'coupon': coupon,
        'available_room_types': available_room_types,
        'hotel_services': hotel_services,
        'reviews': reviews,
        'external_hotels': external_hotels,  
    }

    return render(request, 'frontend/home/pages/hotel-single.html', ctx)




def room_search_result(request):

    ctx = {

    }
    return render(request,'frontend/home/pages/room-search-result.html',ctx)




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






def contact(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            name = form.cleaned_data['name']
            email = form.cleaned_data['email']
            message = form.cleaned_data['message']
            
            # حفظ الرسالة في قاعدة البيانات
            ContactMessage.objects.create(name=name, email=email, message=message)
            
            # إرسال البريد الإلكتروني
            send_mail(
                f'New contact form submission from {name}',
                message,
                email,
                ['ahme@gmail.com'],  # استبدل هذا بعنوان بريدك الإلكتروني
            )
            
            return redirect('thank_you')
    else:
        try:
            setting = Setting.objects.latest('id')
        except Setting.DoesNotExist:
            setting = None  

        socialMediaLink = SocialMediaLink.objects.filter(status=True)

        form = ContactForm()
        ctx = {
            'form': form,
            'setting': setting,
            'socialMediaLink': socialMediaLink,
        }

    return render(request, 'frontend/home/pages/contact.html', ctx)

def thank_you(request):
    return render(request, 'frontend/home/pages/thank_you.html')



def privacy_policy(request):
    privacyPolicy = PrivacyPolicy.objects.first()

    ctx = {
        'privacyPolicy': privacyPolicy
    }
    return render(request, 'frontend/home/pages/privacy-policy.html', ctx)


def payment_policy(request):
    paymentPolicy = PaymenPolicy.objects.first()

    ctx = {
        'paymentPolicy': paymentPolicy
    }
    return render(request, 'frontend/home/pages/payment-policy.html', ctx)

def terms_condition(request):
    termsCondition = TermsConditions.objects.first()

    ctx = {
        'termsCondition': termsCondition
    }
    return render(request, 'frontend/home/pages/term-condition.html', ctx)
