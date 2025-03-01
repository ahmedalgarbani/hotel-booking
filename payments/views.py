from django.shortcuts import get_object_or_404, render, redirect
from rooms.models import RoomType
from HotelManagement.models import Hotel
from .models import Payment, HotelPaymentMethod
from bookings.models import Booking, BookingStatus
from django.contrib import messages
from django.utils import timezone
from datetime import datetime, timedelta
from ShoppingCart.models import ShoppingCart, ShoppingCartItem

# Create your views here.

def user_dashboard_index(request):
    return render(request,'admin/user_dashboard/index.html')

def user_dashboard_bookings(request):
    return render(request,'admin/user_dashboard/pages/user-bookings.html')
def user_dashboard_settings(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-settings.html')
def user_dashboard_wishlist(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-wishlist.html')
def user_dashboard_reviews(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-reviews.html')
def user_dashboard_profile(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-profile.html')

# hotel -------------
def hotel_manager_dashboard_index(request):
    return render(request,'admin/hotel_manager_dashboard/index.html')
def admin_dashboard_booking(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-booking.html')
def admin_payments(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-payments.html')
def admin_invoice(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-invoice.html')
def admin_dashboard_wishlist(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-wishlist.html')
def admin_dashboard_users(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-users.html')
def admin_dashboard_user_detail(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-user-detail.html')
def admin_dashboard_settings(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-settings.html')
def admin_dashboard_reviews(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-reviews.html')
def admin_dashboard_orders(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-orders.html')
def admin_dashboard_orders_detail(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-orders-details.html')
def admin_currency_list(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-currency-list.html')


#خطوة ثاني بعد مناقشة المشرف اضافة السلة 
def cart(request,room_id):
    room = get_object_or_404(RoomType, id=room_id)
    return render(request,'frontend/home/pages/checkout.html',{'room_type':room})




#ارسال الى صفحة الدفع بيانات الغرفة 
def checkout(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)
    payment_methods = HotelPaymentMethod.objects.filter(hotel=room.hotel)
    
    # استرجاع تواريخ تسجيل الدخول والخروج من الـ GET parameters
    check_in = request.GET.get('check_in_date')
    check_out = request.GET.get('check_out_date')
    
    # تحويل التواريخ إلى التنسيق المناسب
    try:
        check_in_date = datetime.strptime(check_in, '%Y-%m-%d %H:%M') if check_in else timezone.now()
        check_out_date = datetime.strptime(check_out, '%Y-%m-%d %H:%M') if check_out else (timezone.now() + timedelta(days=1))
    except (ValueError, TypeError):
        check_in_date = timezone.now()
        check_out_date = timezone.now() + timedelta(days=1)
    
    context = {
        'room': room,
        'paymentsMethods': payment_methods,
        'check_in': check_in_date.strftime('%Y-%m-%d %H:%M'),
        'check_out': check_out_date.strftime('%Y-%m-%d %H:%M'),
        'check_in_display': check_in_date.strftime('%d/%m/%Y %I:%M %p'),
        'check_out_display': check_out_date.strftime('%d/%m/%Y %I:%M %p')
    }
    return render(request, 'frontend/home/pages/checkout.html', context)

def confirm_payment(request, room_id):
    if request.method == 'POST':
        room = get_object_or_404(RoomType, id=room_id)
        payment_method_id = request.POST.get('payment_method')
        payment_method = get_object_or_404(HotelPaymentMethod, id=payment_method_id)
        
        # تحويل التواريخ إلى التنسيق المناسب
        check_in_date = request.POST.get('check_in_date')
        check_out_date = request.POST.get('check_out_date')
        
        # Get pending status
        pending_status = BookingStatus.objects.get(status_code=0)
        
        try:
            # Create booking first
            booking = Booking.objects.create(
                room=room,
                hotel=room.hotel,
                user=request.user,
                check_in_date=check_in_date,
                check_out_date=check_out_date,
                amount=room.base_price,
                status=pending_status
            )
            
            # Create payment record
            payment = Payment.objects.create(
                payment_method=payment_method,
                payment_status=0,  # قيد الانتظار
                payment_date=timezone.now(),
                payment_subtotal=room.base_price,
                payment_totalamount=room.base_price + 5,  # Adding tax
                payment_currency=payment_method.payment_option.currency.currency_symbol,
                booking=booking,
                payment_type='e_pay' if payment_method.payment_option.method_name != 'نقدي' else 'cash'
            )
            
            messages.success(request, 'تم إنشاء الحجز وبانتظار تأكيد الدفع')
            return render(request, 'frontend/home/pages/payment-complete.html', {
                'payment': payment,
                'booking': booking,
                'room': room
            })
        except Exception as e:
            messages.error(request, f'حدث خطأ أثناء إنشاء الحجز: {str(e)}')
            return redirect('payments:checkout', room_id=room_id)
    
    return redirect('payments:checkout', room_id=room_id)

def hotel_checkout(request, hotel_id):
    # Get the hotel
    hotel = get_object_or_404(Hotel, id=hotel_id)
    
    # Get booking data from session if it exists (direct booking)
    booking_data = request.session.get('booking_data')
    
    if booking_data:
        # Direct booking
        room = get_object_or_404(RoomType, id=booking_data['room_id'])
        payment_methods = HotelPaymentMethod.objects.filter(hotel=hotel, is_active=True)
        
        context = {
            'hotel': hotel,
            'room': room,
            'booking_data': booking_data,
            'payment_methods': payment_methods,
            'total_price': booking_data['total_price'],
            'is_direct_booking': True
        }
    else:
        # Cart booking
        cart = get_object_or_404(ShoppingCart, user=request.user, deleted_at__isnull=True)
        cart_items = cart.items.filter(deleted_at__isnull=True, room_type__hotel_id=hotel_id)
        
        if not cart_items.exists():
            messages.error(request, 'لا توجد غرف في سلة التسوق لهذا الفندق')
            return redirect('ShoppingCart:cart')
        
        payment_methods = HotelPaymentMethod.objects.filter(hotel=hotel, is_active=True)
        total_price = sum(item.Total_price for item in cart_items)
        
        context = {
            'hotel': hotel,
            'cart_items': cart_items,
            'payment_methods': payment_methods,
            'total_price': total_price,
            'is_direct_booking': False
        }
    
    return render(request, 'frontend/home/pages/checkout.html', context)


def hotel_confirm_payment(request, hotel_id):
    if request.method == 'POST':
        # Get the user's cart items for this hotel
        cart = get_object_or_404(ShoppingCart, user=request.user, deleted_at__isnull=True)
        cart_items = cart.items.filter(
            deleted_at__isnull=True,
            room_type__hotel_id=hotel_id
        )
        
        if not cart_items.exists():
            messages.error(request, 'لا توجد غرف في سلة التسوق لهذا الفندق')
            return redirect('ShoppingCart:cart')
        
        payment_method_id = request.POST.get('payment_method')
        payment_method = get_object_or_404(HotelPaymentMethod, id=payment_method_id)
        
        try:
            # Get pending status
            pending_status = BookingStatus.objects.get(status_code=0)
            
            # Create bookings for each room
            for item in cart_items:
                booking = Booking.objects.create(
                    room=item.room_type,
                    hotel=item.room_type.hotel,
                    user=request.user,
                    check_in_date=item.check_in_date,
                    check_out_date=item.check_out_date,
                    amount=item.Total_price,
                    status=pending_status
                )
                
                # Create payment record
                Payment.objects.create(
                    booking=booking,
                    payment_method=payment_method,
                    payment_status=0,  # Pending
                    payment_totalamount=item.Total_price
                )
                
                # Remove item from cart
                item.soft_delete()
            
            messages.success(request, 'تم إنشاء الحجز بنجاح وفي انتظار تأكيد الدفع')
            return redirect('payments:user_dashboard_bookings')
            
        except Exception as e:
            messages.error(request, f'حدث خطأ أثناء إنشاء الحجز: {str(e)}')
            return redirect('ShoppingCart:cart')
    
    return redirect('ShoppingCart:cart')



    #داش بورد العميل
def user_dashboard_bookings(request):
    # قراءة بيانات الحجوزات من الـ session
    bookings_with_location = request.session.get('bookings_with_location', [])
    
    return render(request, 'admin/user_dashboard/pages/user-bookings.html', {
        'bookings_with_location': bookings_with_location
    })
