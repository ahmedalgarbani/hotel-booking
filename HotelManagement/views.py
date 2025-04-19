from datetime import datetime
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.utils.translation import gettext_lazy as _
from django.http import JsonResponse

from HotelManagement.services import get_hotels_query, get_query_params
from customer.models import Favourites
from .models import HotelRequest, Hotel, City, Image
from .forms import HotelRequestForm
import json

def is_admin(user):
    return user.is_superuser


def add_hotel_request(request):
    """عرض نموذج طلب إضافة فندق جديد ومعالجة البيانات المرسلة"""
    if request.method == 'POST':
        form = HotelRequestForm(request.POST, request.FILES)
        if form.is_valid():
            hotel_request = form.save(commit=False)
            
            # التحقق من الدولة والمحافظة
            country = request.POST.get('country', '')
            state = request.POST.get('state', '')
            
            # إذا تم اختيار "إضافة جديد"
            if country == 'new':
                country = request.POST.get('new_country', '')
            if state == 'new':
                state = request.POST.get('new_state', '')
            
            # التحقق من أن القيم غير فارغة
            if not country or not state:
                messages.error(request, _('يرجى اختيار أو إدخال الدولة والمحافظة'))
                return render(request, 'frontend/hotel/add_hotel.html', {'form': form, 'cities': City.objects.values('country', 'state').distinct()})
            
            # حفظ المدينة الجديدة إذا لم تكن موجودة
            city, created = City.objects.get_or_create(
                country=country,
                state=state
            )
            
            hotel_request.country = country
            hotel_request.state = state
            hotel_request.user = request.user
            
            # معالجة الصور الإضافية
            additional_images = []
            if request.FILES.getlist('additional_images'):
                for image in request.FILES.getlist('additional_images'):
                    # حفظ الصورة مباشرة في مجلد الوسائط
                    additional_images.append({
                        'image_path': f'hotels/images/{image.name}'
                    })
                    # حفظ الصورة فعلياً
                    with open(f'media/hotels/images/{image.name}', 'wb+') as destination:
                        for chunk in image.chunks():
                            destination.write(chunk)
                            
            hotel_request.additional_images = json.dumps(additional_images)
            hotel_request.save()
            
            messages.success(request, _('تم إرسال طلب إضافة الفندق بنجاح. سيتم مراجعته من قبل الإدارة.'))
            return redirect('home:index')
    else:
        form = HotelRequestForm()
    
    # جلب جميع المدن الفريدة
    cities = City.objects.values('country', 'state').distinct()
    
    context = {
        'form': form,
        'cities': cities,
        'title': _('طلب إضافة فندق جديد')
    }
    return render(request, 'frontend/hotel/add_hotel.html', context)

@login_required(login_url='/users/login')
@user_passes_test(is_admin)
def hotel_requests_list(request):
    """عرض قائمة طلبات إضافة الفنادق للمشرفين"""
    requests = HotelRequest.objects.all().order_by('-created_at')
    context = {
        'requests': requests,
        'title': _('طلبات إضافة الفنادق')
    }
    return render(request, 'admin/hotel/requests_list.html', context)

@login_required(login_url='/users/login')
@user_passes_test(is_admin)
def approve_hotel_request(request, request_id):
    """الموافقة على طلب إضافة فندق"""
    hotel_request = get_object_or_404(HotelRequest, id=request_id)
    
    try:
        hotel = hotel_request.approve(request.user)
        messages.success(request, _(f'تمت الموافقة على طلب إضافة الفندق {hotel.name} بنجاح'))
    except Exception as e:
        messages.error(request, str(e))
    
    return redirect('hotel:requests_list')

@login_required(login_url='/users/login')
@user_passes_test(is_admin)
def reject_hotel_request(request, request_id):
    """رفض طلب إضافة فندق"""
    hotel_request = get_object_or_404(HotelRequest, id=request_id)
    hotel_request.delete()
    messages.success(request, _('تم رفض طلب إضافة الفندق'))
    return redirect('hotel:requests_list')




from notifications.models import Notifications

def notifications_context(request):
    if request.user.is_authenticated:
        notifications = Notifications.objects.filter(user=request.user, is_active=True).order_by('-send_time')
        unread_notifications_count = notifications.filter(status='0').count()
    else:
        notifications = []
        unread_notifications_count = 0

    return {
        'notifications': notifications,
        'unread_notifications_count': unread_notifications_count,
    }



 
from datetime import datetime
from django.db.models import Case, When, BooleanField

from django.shortcuts import render
from django.db.models import Count, Avg, Case, When, BooleanField
from datetime import datetime
import json

def hotel_search(request):
    def annotate_hotels(queryset, favorite_ids):
        return queryset.annotate(
            review_count=Count('hotel_reviews'),
            average_rating=Avg('hotel_reviews__rating_service'),
            is_favorite=Case(
                When(id__in=favorite_ids, then=True),
                default=False,
                output_field=BooleanField()
            )
        )

    result_list = request.GET.get('result_list')
    favorite_hotel_ids = []

    if request.user.is_authenticated:
        favorite_hotel_ids = list(
            Favourites.objects.filter(user=request.user).values_list('hotel_id', flat=True)
        )

    if result_list:
        try:
            result_list = json.loads(result_list)
            if result_list:
                hotel_ids = [hot['id'] for hot in result_list]
                hotels_query = Hotel.objects.filter(id__in=hotel_ids)
                hotels_query = annotate_hotels(hotels_query, favorite_hotel_ids)

                for hotel in hotels_query:
                    hotel.is_favorite = hotel.id in favorite_hotel_ids

                ctx = {
                    'adult_number': 1,
                    'check_in_start': '',
                    'check_out_start': '',
                    'hotels': hotels_query,
                }
                return render(request, 'frontend/home/pages/hotel-search-result.html', ctx)

        except json.JSONDecodeError:
            pass  

    hotel_name, check_in, check_out, adult_number, room_number, category_type = get_query_params(request)

    today = datetime.now().date()
    hotels_query = Hotel.objects.none()
    error_message = None
    if check_out:
        hotels_query, error_message = get_hotels_query(
            hotel_name, category_type, room_number, adult_number, today, check_out, check_in
        )
    hotels_query = annotate_hotels(hotels_query, favorite_hotel_ids)

    for hotel in hotels_query:
        hotel.is_favorite = hotel.id in favorite_hotel_ids

    ctx = {
        'adult_number': adult_number,
        'check_in_start': check_in.strftime('%m/%d/%Y') if check_in else '',
        'check_out_start': check_out.strftime('%m/%d/%Y') if check_out else '',
        'hotels': hotels_query,
        'error_message': error_message,
    }

    return render(request, 'frontend/home/pages/hotel-search-result.html', ctx)

