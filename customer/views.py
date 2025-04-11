from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render, redirect
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, EmptyPage
from HotelManagement.models import Hotel
from bookings.models import Booking
from customer.models import Favourites  
from notifications.models import Notifications
from reviews.models import HotelReview, RoomReview
from django.contrib import messages
from users.models import CustomUser
from .forms import UserProfileForm
from django.core.exceptions import ValidationError
from django.utils import timezone
from django.views.decorators.http import require_POST
from payments.models import Payment
from django.db.models import Sum




@login_required(login_url='/users/login')
def user_dashboard_index(request):
    user = request.user  

    # الإشعارات
    notifications = Notifications.objects.filter(
        user=user, 
        is_active=True, 
        status='0'
    ).order_by('-send_time')[:10]
    
    # الحجوزات الحديثة (أحدث 5 حجوزات)
    recent_bookings = Booking.objects.filter(
        user=user
    ).select_related('hotel').order_by('-created_at')[:5]
    
    # الدفعات الحديثة (أحدث 5 دفعات)
    recent_payments = Payment.objects.filter(
        user=user
    ).select_related('booking').order_by('-payment_date')[:5]
    
    unread_notifications_count = notifications.count()
    booking_count = Booking.objects.filter(user=user).count()
    wishlist_count = Favourites.objects.filter(user=user).count()
    total_payments = Payment.objects.filter(
        user=user, 
        payment_status=1
    ).aggregate(total=Sum('payment_totalamount'))['total'] or 0
    
    reviews_count = HotelReview.objects.filter(user=user).count() + RoomReview.objects.filter(user=user).count()

    user_orders = Payment.objects.filter(user=user).select_related('booking').order_by('-payment_date')[:5]


    return render(request, 'admin/user_dashboard/index.html', {
        'user': user,
        'notifications': notifications,
        'recent_bookings': recent_bookings,
        'recent_payments': recent_payments,
        'unread_notifications_count': unread_notifications_count,
        'booking_count': booking_count,
        'wishlist_count': wishlist_count,
        'total_payments': total_payments,
        'reviews_count': reviews_count,
        'user_orders': user_orders,
    })


@require_POST
@login_required
def mark_all_notifications_as_read(request):
    Notifications.objects.filter(user=request.user, status='0', is_active=True).update(status='1')
    return JsonResponse({'success': True})


@login_required(login_url='/users/login')
def user_dashboard_bookings(request):
    bookings = Booking.objects.filter(user=request.user).order_by('-check_in_date')

    page_number = request.GET.get('page', 1)  

    try:
        page_number = int(page_number)
        if page_number < 1:
            page_number = 1  
    except (ValueError, TypeError):
        page_number = 1 

    paginator = Paginator(bookings, 10) 

    try:
        page_obj = paginator.page(page_number)
    except EmptyPage:
        page_obj = paginator.page(paginator.num_pages)

    bookings_with_location = []
    for booking in page_obj:
        hotel_location = booking.hotel.location.address  
        city_name = booking.hotel.location.city 
        bookings_with_location.append({
            'booking': booking,
            'hotel_location': hotel_location,
            'city_name': city_name, 
        })

    return render(request, 'admin/user_dashboard/pages/user-bookings.html', {
        'bookings_with_location': bookings_with_location,
        'page_obj': page_obj
    })



@login_required(login_url='/users/login')
def user_dashboard_settings(request):
    user = request.user
    form = UserProfileForm(instance=user)
    return render(request, 'admin/user_dashboard/pages/user-dashboard-settings.html', {'form': form, 'user': user})


@login_required(login_url='/users/login')
def user_profile_dashboard_settings(request):
    user = request.user
    if request.method == "POST":
        form = UserProfileForm(request.POST, request.FILES, instance=user)
        if form.is_valid():
            form.save()  
            return redirect('customer:user_dashboard_settings')  
    else:
        form = UserProfileForm(instance=user)
    
    return render(request, 'admin/user_dashboard/pages/user-dashboard-settings.html', {'form': form, 'user': user})




@login_required(login_url='/users/login')
def user_dashboard_settings_password(request):
    if request.method == 'POST':
        current_password = request.POST.get('current_password')
        new_password = request.POST.get('new_password')
        newPasswordConfirm = request.POST.get('new_password_confirm')
        
        user = request.user

        if not user.check_password(current_password):
            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'error': 'كلمة المرور الحالية غير صحيحة.'}, status=400)
            else:
                messages.error(request, 'كلمة المرور الحالية غير صحيحة.')
                return redirect('customer:user_dashboard_settings')
            
        if not newPasswordConfirm == new_password:
            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'error': 'كلمة المرور غير متطابقه.'}, status=400)
            else:
                messages.error(request, 'كلمة المرور غير متطابقه.')
                return redirect('customer:user_dashboard_settings')

        try:
            user.set_password(newPasswordConfirm)
            user.save()
            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'success': 'تم تغيير كلمة المرور بنجاح.'})
            else:
                messages.success(request, 'تم تغيير كلمة المرور بنجاح.')
                return redirect('customer:user_dashboard_settings')
        except ValidationError as e:
            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'error': f'حدث خطأ: {e}'}, status=400)
            else:
                messages.error(request, f'حدث خطأ: {e}')
                return redirect('customer:user_dashboard_settings')

    return render(request, 'admin/user_dashboard/pages/user-dashboard-settings.html')



@login_required(login_url='/users/login')
def user_dashboard_settings_email(request):
    if request.method == 'POST':
        current_email = request.POST.get('current_email')
        new_email = request.POST.get('new_email')
        confirm_email = request.POST.get('confirm_email')

        user = request.user

        # التحقق من أن البريد الحالي صحيح
        if user.email != current_email:
            messages.error(request, 'البريد الإلكتروني الحالي غير صحيح.')
            return redirect('customer:user_dashboard_settings')

        # التحقق من أن البريدين الجدد متطابقين
        if new_email != confirm_email:
            messages.error(request, 'البريد الإلكتروني الجديدين غير متطابقين.')
            return redirect('customer:user_dashboard_settings')

        # التحقق من أن البريد الجديد غير مشابه للبريد الحالي
        if new_email == current_email:
            messages.error(request, 'البريد الإلكتروني الجديد يجب أن يكون مختلفاً عن البريد الإلكتروني الحالي.')
            return redirect('customer:user_dashboard_settings')

        # تحديث البريد الإلكتروني
        try:
            user.email = new_email
            user.save()
            messages.success(request, 'تم تغيير البريد الإلكتروني بنجاح.')
        except ValidationError as e:
            messages.error(request, f'حدث خطأ: {e}')
        return redirect('customer:user_dashboard_settings')

    return render(request, 'admin/user_dashboard/pages/user-dashboard-settings.html')




@login_required(login_url='/users/login')
def user_dashboard_wishlist(request):
    # جلب الفنادق المفضلة للمستخدم
    favourites = Favourites.objects.filter(user=request.user).select_related('hotel')

    # تمرير البيانات إلى القالب
    ctx = {
        'favourites': favourites
    }
    return render(request, 'admin/user_dashboard/pages/user-dashboard-wishlist.html', ctx)



@login_required(login_url='/users/login')
def user_dashboard_reviews(request):
    # جلب المراجعات من قاعدة البيانات
    hotel_reviews = HotelReview.objects.all()  # جلب جميع مراجعات الفنادق
    room_reviews = RoomReview.objects.all()  # جلب جميع مراجعات الغرف

    # تمرير قائمة النجوم بناءً على التقييم
    for review in hotel_reviews:
        review.stars = [1] * review.rating_service  

    for review in room_reviews:
        review.stars = [1] * review.rating 

    return render(request, 'admin/user_dashboard/pages/user-dashboard-reviews.html', {
        'hotel_reviews': hotel_reviews,
        'room_reviews': room_reviews,
    })



@login_required(login_url='/users/login')
def user_dashboard_profile(request):
    user = request.user  

    return render(request, 'admin/user_dashboard/pages/user-dashboard-profile.html', {'user': user})

import json


def add_to_favorites(request):
    if not request.user.is_authenticated:
            return JsonResponse({'status': 'error', 'message': 'plz login first'})
    try:
        data = json.loads(request.body)  
        hotel_id = data.get('hotel_id')  

        if not hotel_id:
            return JsonResponse({'status': 'error', 'message': 'No hotel ID provided'})

        hotel = get_object_or_404(Hotel, id=hotel_id)

        favorite_entry = Favourites.objects.filter(user=request.user, hotel=hotel).first()

        if favorite_entry:
            favorite_entry.delete()
            return JsonResponse({'status': 'success', 'message': 'hotel removed from favorites'})
        else:
            Favourites.objects.create(user=request.user, hotel=hotel)
            return JsonResponse({'status': 'success', 'message': 'hotel added to favorites'})

    except json.JSONDecodeError:
        return JsonResponse({'status': 'error', 'message': 'Invalid JSON format'})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)})



from django.shortcuts import get_object_or_404, redirect
from django.http import JsonResponse
from .models import Favourites

def remove_favourite(request, favourite_id):
    favourite = get_object_or_404(Favourites, id=favourite_id)

    if favourite.user == request.user:
        favourite.delete()
    else:
        pass

    # إعادة نفس الصفحة بعد الحذف
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':  # تحقق من طلب Ajax
        return JsonResponse({'success': True})
    else:
        return redirect(request.META.get('HTTP_REFERER'))  # العودة إلى نفس الصفحة



def cancel_booking(request, booking_id):
    booking = get_object_or_404(Booking, id=booking_id, user=request.user)

    if booking.status in ['0', '1']:
        if booking.check_in_date:
            time_diff = booking.check_in_date - timezone.now()
            if time_diff.total_seconds() > 86400: 
                booking.status = '2' 
                booking.save()  
                messages.success(request, "تم إلغاء الحجز بنجاح.")
            else:
                messages.warning(request, "لا يمكن إلغاء الحجز قبل أقل من 24 ساعة من تاريخ الدخول.")
        else:
            messages.warning(request, "تاريخ تسجيل الدخول غير متوفر لهذا الحجز.")
    else:
        messages.warning(request, "لا يمكن إلغاء هذا الحجز.")  

    return redirect('customer:user_dashboard_bookings') 


from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, redirect
from django.contrib import messages
from payments.models import Payment

@login_required
def cancel_payment(request, payment_id):
    payment = get_object_or_404(Payment, id=payment_id, user=request.user)

    if payment.payment_status == 0:  # إذا كانت قيد الانتظار
        payment.payment_status = 2   # 2 = ملغاة
        payment.save()
        messages.success(request, "تم إلغاء الدفع بنجاح.")
    else:
        messages.warning(request, "لا يمكن إلغاء هذا الدفع.")

    return redirect('customer:user_dashboard_index')  # أو أي صفحة مناسبة
