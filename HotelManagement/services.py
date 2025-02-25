from HotelManagement.models import City, Hotel
from datetime import datetime
from django.db.models import Q




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
    return    check_in, check_out


def get_query_params(request):
    if request.method == 'GET':
        hotel_name = request.GET.get('hotel_name', '').strip()
        check_date = request.GET.get('check_date', '').strip()

        try:
            adult_number = int(request.GET.get('adult_number', 0))
        except ValueError:
            adult_number = 0

       

        check_in,check_out = parse_check_in_date(check_date)


    elif request.method == 'POST':
        hotel_name = room_type_name = None
        check_in =change_date_format(request.POST.get('check_in_start', '').strip())
        check_out = change_date_format(request.POST.get('check_out_start', '').strip())

        try:
            adult_number = int(request.POST.get('adult_number', 0))
        except ValueError:
            adult_number = 0

      


    return hotel_name, check_in,check_out, adult_number


def get_hotels_query(hotel_name):
    hotels_query = Hotel.objects.all()
    if hotel_name:
        cities = City.objects.filter(Q(state__icontains=hotel_name) )
        hotels_by_city = Hotel.objects.filter(location__city__in=cities)
        hotels_by_name = Hotel.objects.filter(name__icontains=hotel_name)
        hotels_query = (hotels_by_city | hotels_by_name).distinct()
    return hotels_query