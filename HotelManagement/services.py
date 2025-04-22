
from datetime import datetime, timedelta
from django.db.models import Q

from rooms.models import Availability, RoomType
from django.db.models import OuterRef, Subquery
from django.db.models import Q
from .models import *

 
def change_date_format(date_str):
    date_obj = datetime.strptime(date_str, "%m/%d/%Y")  
    formatted_date_str = date_obj.strftime("%Y-%m-%d 00:00:00")
    formatted_date = datetime.strptime(formatted_date_str, "%Y-%m-%d 00:00:00")
 
    print(formatted_date) 
    return formatted_date

def parse_check_in_date(check_in_date):
    if check_in_date:
        try:
            check_in_start, check_out_start = check_in_date.split(' - ')
            check_in = datetime.strptime(check_in_start, '%m/%d/%Y') if check_in_start else None
            check_out = datetime.strptime(check_out_start, '%m/%d/%Y') if check_out_start else None
        except ValueError:
            check_in = check_out = None
            print("Invalid date range format")
    else:
        check_in = check_out = None
    return check_in, check_out


def get_query_params(request):
    if request.method == 'GET':
        hotel_name = request.GET.get('hotel_name', '').strip()
        check_date = request.GET.get('check_date', '').strip()
        category_type = request.GET.get('category_type', '').strip()
        try:
            room_number = int(request.GET.get('room_number', 0))
        except ValueError:
            room_number = 0
        
        try:
            adult_number = int(request.GET.get('adult_number', 0))
        except ValueError:
            adult_number = 0

        check_in, check_out = parse_check_in_date(check_date)

    elif request.method == 'POST':
        hotel_name = room_type_name = None
        category_type = request.POST.get('category_type', '').strip()
        check_in = change_date_format(request.POST.get('check_in_start', '').strip())
        check_out = change_date_format(request.POST.get('check_out_start', '').strip())

        try:
            room_number = int(request.POST.get('room_number', 0))
        except ValueError:
            room_number = None
        
        try:
            adult_number = int(request.POST.get('adult_number', 0))
        except ValueError:
            adult_number = None

    return hotel_name, check_in, check_out, adult_number, room_number, category_type



# def get_hotels_query(hotel_name, category_type=None, room_number=None, adult_number=None):
#     hotels_query = Hotel.objects.all()

#     if hotel_name:
#         cities = City.objects.filter(Q(state__icontains=hotel_name))
#         hotels_by_city = Hotel.objects.filter(location__city__in=cities)
#         hotels_by_name = Hotel.objects.filter(name__icontains=hotel_name)
#         hotels_query = (hotels_by_city | hotels_by_name).distinct()

#     if category_type:
#         hotels_query = hotels_query.filter(room_categories__name__icontains=category_type)

#     if room_number:
#         hotels_query = hotels_query.filter(
#             room_availabilities__available_rooms__gte=room_number
#         )

#     if adult_number:
#         hotels_query = hotels_query.filter(
#             room_types__default_capacity__gte=adult_number
#         )

#     if not hotels_query.exists():
#         hotels_query = Hotel.objects.all()
#         error_message = "لا توجد نتائج مطابقة، تم عرض جميع الفنادق المتاحة."
#     else:
#         error_message = ""

#     return hotels_query, error_message
def get_hotels_query(hotel_name, category_type=None, room_number=1, adult_number=None, check_in=None, check_out=None, today=None):
    check_in = datetime.strptime(str(check_in), "%Y-%m-%d").date()
    check_out = datetime.strptime(str(check_out), "%Y-%m-%d %H:%M:%S").date()
    hotels_query = Hotel.objects.all()

    # البحث حسب اسم الفندق أو الموقع
    if hotel_name:
        hotels_by_name = Hotel.objects.filter(name__icontains=hotel_name)
        cities = City.objects.filter(
            Q(state__icontains=hotel_name) | 
            Q(country__icontains=hotel_name)
        )
        locations = Location.objects.filter(city__in=cities)
        hotels_by_location = Hotel.objects.filter(location__in=locations)
        # دمج النتائج وإزالة التكرار
        hotels_query = (hotels_by_name | hotels_by_location).distinct()

    # فلترة حسب فئة الغرفة
    try:
        if category_type:
            hotels_query = hotels_query.filter(
                room_types__category__id=category_type
            ).distinct()
    except Exception as e:
        print(e)
    from django.db.models import Count
    if check_in and check_out and check_in != check_out:
        
        total_days = (check_out - check_in).days + 1
        
        avail_room_types = Availability.objects.filter(
            availability_date__range=[check_in, check_out],
            available_rooms__gte=room_number
        ).values('room_type') \
        .annotate(available_days=Count('id')) \
        .filter(available_days=total_days) \
        .values_list('room_type', flat=True)

        hotels_query = hotels_query.filter(
            room_types__id__in=avail_room_types
        )

    #  حسب عدد الغرف المطلوبة
    if room_number and room_number > 0:
        if check_in and check_out and check_in != check_out:
            avail_room_types = Availability.objects.filter(
                availability_date__range=[check_in, check_out],
                available_rooms__gte=room_number
            ).values_list('room_type', flat=True)
            hotels_query = hotels_query.filter(
                room_types__id__in=avail_room_types
            )
        else:
            # في حالة عدم تحديد فترة تواريخ: نستخدم القيمة الأحدث المتوفرة في RoomType (مثال مبدئي)
            hotels_query = hotels_query.annotate(
                latest_avail=Subquery(
                    RoomType.objects.filter(pk=models.OuterRef('pk')).values('rooms_count')[:1]
                )
            ).filter(latest_avail__gte=room_number)

    # فلترة حسب سعة الغرفة (عدد الأشخاص)
    if adult_number and adult_number > 0:
        hotels_query = hotels_query.filter(
            room_types__default_capacity__gte=adult_number
        ).distinct()

    error_message = ""
    if not hotels_query.exists():
        hotels_query = Hotel.objects.all()
        error_message = "لا توجد نتائج مطابقة، تم عرض جميع الفنادق المتاحة."

    return hotels_query, error_message

def check_room_availability_full(room_type, hotel, check_in, check_out, today_date, required_rooms=1):
    """
    Combines availabi lity validation logic for a specific room type, hotel, and date range.

    Checks:
    - Completeness of data
    - Room type activation
    - Existence of recent availability data
    - Daily availability across the full date range

    Parameters:
        room_type (RoomType): Room type object
        hotel (Hotel): Hotel object
        check_in (date): Check-in date
        check_out (date): Check-out date
        today_date (date): Today's date
        required_rooms (int): Number of rooms requested

    Returns:
        (bool, str): Tuple where bool indicates availability, and str contains the status message.
    """
    if not all([room_type, hotel, check_in, check_out, today_date, required_rooms]):
        return False, "بيانات الحجز غير مكتملة"

    if not room_type.is_active:
        return False, "هذا النوع من الغرف غير متاح للحجز حالياً"

    if check_in < today_date:
        check_in = today_date

    if check_out <= check_in:
        return False, "تاريخ الخروج يجب أن يكون بعد تاريخ الدخول"


    days_count = (check_out - check_in).days
    available_days = Availability.objects.filter(
        room_type=room_type,
        hotel=hotel,
        availability_date__range=(check_in, check_out),
        available_rooms__gte=required_rooms
    ).count()

    if available_days < days_count:
        return False, "عدد الغرف المطلوب غير متوفر لكل الأيام المطلوبة"

    return True, "الغرف متوفرة لكل الفترة المحددة"
