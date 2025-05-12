from django.contrib import messages
from django.shortcuts import get_object_or_404, redirect, render
from django.utils.text import slugify

from HotelManagement.services import check_room_availability_full
from .forms import ReviewForm
from .models import RoomType, Availability
from reviews.models import RoomReview
from datetime import datetime, date
from django.utils import timezone
from datetime import timedelta
from django.db.models import Avg
from .services import *

from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Avg
from django.utils import timezone
from datetime import datetime, timedelta
from .models import RoomType, RoomPrice, RoomImage
from .forms import ReviewForm
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
import uuid
from decimal import Decimal
from services.models import Coupon, RoomTypeService
from django.db import transaction
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

def get_available_date_ranges(room_type, min_rooms=1, days_ahead=60):
    """
    استخراج التواريخ المتاحة للغرفة من جدول التوافر مباشرة
    تاريخ تسجيل الخروج يكون آخر تاريخ متاح متتالي + يوم واحد

    Args:
        room_type: نوع الغرفة
        min_rooms: الحد الأدنى لعدد الغرف المطلوبة
        days_ahead: عدد الأيام المستقبلية للبحث

    Returns:
        قائمة من التواريخ المتاحة، كل تاريخ عبارة عن قاموس يحتوي على تاريخ البداية والنهاية
    """
    today = date.today()
    end_date = today + timedelta(days=days_ahead)

    # الحصول على سجلات التوافر مباشرة من قاعدة البيانات
    availabilities = Availability.objects.filter(
        room_type=room_type,
        availability_date__gte=today,
        availability_date__lte=end_date,
        available_rooms__gte=min_rooms
    ).order_by('availability_date')

    # إذا لم تكن هناك سجلات توافر، إرجاع قائمة فارغة
    if not availabilities:
        return []

    # تحويل سجلات التوافر إلى قائمة بالتواريخ
    available_dates = [avail.availability_date for avail in availabilities]

    # تجميع التواريخ المتتالية في فترات
    date_ranges = []
    start_date = None
    prev_date = None

    for current_date in available_dates:
        # بداية فترة جديدة
        if start_date is None:
            start_date = current_date
            prev_date = current_date
        # استمرار الفترة الحالية
        elif (current_date - prev_date).days == 1:
            prev_date = current_date
        # نهاية فترة وبداية فترة جديدة
        else:
            # تاريخ الخروج هو اليوم التالي لآخر تاريخ متاح في الفترة
            check_out_date = prev_date + timedelta(days=1)

            date_ranges.append({
                'start_date': start_date,
                'end_date': check_out_date,
                'nights': (prev_date - start_date).days + 1  # عدد الليالي
            })

            start_date = current_date
            prev_date = current_date

    # إضافة الفترة الأخيرة
    if start_date is not None:
        # تاريخ الخروج هو اليوم التالي لآخر تاريخ متاح في الفترة
        check_out_date = prev_date + timedelta(days=1)

        date_ranges.append({
            'start_date': start_date,
            'end_date': check_out_date,
            'nights': (prev_date - start_date).days + 1  # عدد الليالي
        })

    return date_ranges



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

    # استخراج صور الغرفة
    image = RoomImage.objects.filter(room_type=room)

    # استخراج تقييمات الغرفة
    reviews_list = RoomReview.objects.filter(room_type=room, status=True).order_by('-created_at')
    if reviews_list.exists():
        average_rating = reviews_list.aggregate(Avg('rating'))['rating__avg']
        average_rating = round(average_rating, 1) if average_rating else 0.0
    else:
        average_rating = 0.0

    # تقسيم التقييمات إلى صفحات
    page = request.GET.get('page')
    paginator = Paginator(reviews_list, 3) # Show 3 reviews per page, adjust as needed
    try:
        reviews = paginator.page(page)
    except PageNotAnInteger:
        reviews = paginator.page(1) # If page is not an integer, deliver first page.
    except EmptyPage:
        reviews = paginator.page(paginator.num_pages) # If page is out of range (e.g. 9999), deliver last page of results.

    # استخراج خدمات الغرفة
    services = room.room_services.filter(room_type=room, is_active=True).order_by('id')
    services_list = [
        {
            'id': service.id,
            'name': service.name,
            'description': service.description,
            'icon': service.icon.url if service.icon else None,
            'additional_fee': service.additional_fee > 0,
            'is_negative_fee': service.additional_fee < 0,
            'additional_price': service.additional_fee
        }
        for service in services
    ]

    # استخراج سعر الغرفة
    today = timezone.now().date()
    room_price = RoomPrice.objects.filter(
        room_type=room,
        hotel=room.hotel,
        date_from__lte=today,
        date_to__gte=today
    ).order_by('-date_from').first()
    price = room_price.price if room_price else room.base_price

    # استخراج تواريخ الحجز من الطلب
    check_in = request.GET.get('check_in')
    check_out = request.GET.get('check_out')
    try:
        check_in_date = datetime.strptime(check_in, '%Y-%m-%d %H:%M') if check_in else timezone.now()
        check_out_date = datetime.strptime(check_out, '%Y-%m-%d %H:%M') if check_out else (timezone.now() + timedelta(days=1))
    except (ValueError, TypeError):
        check_in_date = timezone.now()
        check_out_date = timezone.now() + timedelta(days=1)

    # تحديد عدد الأيام المستقبلية للتحقق
    future_days = 60

    # استخراج التواريخ المتاحة للغرفة
    room_number = int(request.GET.get('room_number', 1))
    available_dates = get_available_date_ranges(room, min_rooms=room_number, days_ahead=future_days)

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
        'image': image,
        'external_rooms': external_rooms,
        'available_dates': available_dates  # إضافة التواريخ المتاحة إلى السياق
    }
    return render(request, 'frontend/home/pages/room-details.html', context)