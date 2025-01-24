from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.decorators import login_required, user_passes_test
from django.utils.translation import gettext_lazy as _
from django.http import JsonResponse
from .models import HotelRequest, Hotel, City, Image
from .forms import HotelRequestForm
import json

def is_admin(user):
    return user.is_superuser

@login_required
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
            hotel_request.save()
            
            # معالجة الصور الإضافية
            additional_images = []
            if request.FILES.getlist('additional_images'):
                for image in request.FILES.getlist('additional_images'):
                    additional_images.append({
                        'image_path': image.name
                    })
            hotel_request.additional_images = additional_images
            hotel_request.save()
            
            messages.success(request, _('تم إرسال طلب إضافة الفندق بنجاح. سيتم مراجعته من قبل الإدارة.'))
            return redirect('home:index')
    else:
        form = HotelRequestForm()
    
    # جلب جميع المدن الفريقة
    cities = City.objects.values('country', 'state').distinct()
    
    context = {
        'form': form,
        'cities': cities,
        'title': _('طلب إضافة فندق جديد')
    }
    return render(request, 'frontend/hotel/add_hotel.html', context)

@login_required
@user_passes_test(is_admin)
def hotel_requests_list(request):
    """عرض قائمة طلبات إضافة الفنادق للمشرفين"""
    requests = HotelRequest.objects.all().order_by('-created_at')
    context = {
        'requests': requests,
        'title': _('طلبات إضافة الفنادق')
    }
    return render(request, 'admin/hotel/requests_list.html', context)

@login_required
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

@login_required
@user_passes_test(is_admin)
def reject_hotel_request(request, request_id):
    """رفض طلب إضافة فندق"""
    hotel_request = get_object_or_404(HotelRequest, id=request_id)
    hotel_request.delete()
    messages.success(request, _('تم رفض طلب إضافة الفندق'))
    return redirect('hotel:requests_list')