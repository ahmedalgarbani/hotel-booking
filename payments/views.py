from django.shortcuts import get_object_or_404, render, redirect
from rooms.models import RoomType
from HotelManagement.models import Hotel
from services.models import RoomTypeService
from .models import Payment, HotelPaymentMethod
from bookings.models import Booking
from django.contrib import messages
from django.utils import timezone
from datetime import datetime, timedelta
from django.urls import reverse


# Create your views here.



# hotel -


def process_booking(request, room_id):
    if request.method == "POST":
        check_in = request.POST.get("check_in_date")
        check_out = request.POST.get("check_out_date")
        room_number = int(request.POST.get("room_number", 1))
        adult_number = int(request.POST.get("adult_number", 1))
        total_price = float(request.POST.get("total_price", 0))
        grand_price = float(request.POST.get("grand_price", 0))
        
        extra_services = request.POST.getlist("extra_services")
        extra_services_details = []
        extra_services_total = 0
        
        for service_id in extra_services:
            service = RoomTypeService.objects.filter(id=service_id).first()  
            if service:
                service_price = service.additional_fee 
                extra_services_total += service_price
                extra_services_details.append({
                    "id": service.id,
                    "name": service.name,
                    "price": service_price
                })
        request.session["booking_data"] = {
            "hotel_id": request.POST.get("hotel_id"),
            "room_id": room_id,
            "check_in": check_in,
            "check_out": check_out,
            "room_number": room_number,
            "adult_number": adult_number,
            "total_price": total_price,
            "extra_services": extra_services_details,
            "extra_services_total": extra_services_total,
            "grand_total": grand_price,
        }
        
        return redirect(reverse("payments:add_guest", args=[room_id]))

    
    return redirect(reverse("rooms:room_detail", args=[room_id]))

def add_guest(request, room_id):
    booking_data = request.session.get("booking_data", {})
    if not booking_data:
        return redirect(reverse("rooms:room_detail", args=[room_id]))
    
    return render(request, "frontend/home/pages/add_guest.html", booking_data)


#ارسال الى صفحة الدفع بيانات الغرفة 
def checkout(request, room_id):
  
    room = get_object_or_404(RoomType, id=room_id)
    hotel = get_object_or_404(Hotel, id=1)
    payment_methods = HotelPaymentMethod.objects.filter(hotel=hotel)
    
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

def hotel_confirm_payment(request, room_id):
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
    hotel = get_object_or_404(Hotel, id=hotel_id)
    
    booking_data = request.session.get('booking_data')
    
    if booking_data:
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
        
        
        payment_methods = HotelPaymentMethod.objects.filter(hotel=hotel, is_active=True)
        total_price = sum(item.Total_price for item in cart_items)
        
        context = {
            'hotel': hotel,
            'payment_methods': payment_methods,
            'total_price': total_price,
            'is_direct_booking': False
        }
    
    return render(request, 'frontend/home/pages/checkout.html', context)


def hotel_confirm_payment(request, hotel_id):
    pass
    # if request.method == 'POST':
    #     # Get the user's cart items for this hotel
    #     cart = get_object_or_404(ShoppingCart, user=request.user, deleted_at__isnull=True)
    #     cart_items = cart.items.filter(
    #         deleted_at__isnull=True,
    #         room_type__hotel_id=hotel_id
    #     )
    #     print(cart_items)
    #     if not cart_items.exists():
    #         messages.error(request, 'لا توجد غرف في سلة التسوق لهذا الفندق')
    #         return redirect('ShoppingCart:cart')
        
    #     payment_method_id = request.POST.get('payment_method')
    #     payment_method = get_object_or_404(HotelPaymentMethod, id=payment_method_id)
        
    #     try:
    #         # Get pending status
    #         pending_status = BookingStatus.objects.get(status_code=0)
            
    #         # Create bookings for each room
    #         for item in cart_items:
    #             booking = Booking.objects.create(
    #                 room=item.room_type,
    #                 hotel=item.room_type.hotel,
    #                 user=request.user,

    #                 check_in_date=item.check_in_date,
    #                 check_out_date=item.check_out_date,
    #                 amount=item.Total_price,
    #                 status=pending_status
    #             )
                
    #             # Create payment record
    #             Payment.objects.create(
    #                 booking=booking,
    #                 payment_subtotal=item.Total_price,
    #                 payment_method=payment_method,
    #                 payment_status=0,  # Pending
    #                 payment_totalamount=item.Total_price
    #             )
                
    #             # Remove item from cart
    #             # item.soft_delete()
            
    #         messages.success(request, 'تم إنشاء الحجز بنجاح وفي انتظار تأكيد الدفع')
    #         return redirect('payments:user_dashboard_bookings')
            
    #     except Exception as e:
    #         print(f'حدث خطأ أثناء إنشاء الحجز: {str(e)}')
    #         messages.error(request, f'حدث خطأ أثناء إنشاء الحجز: {str(e)}')
    #         return redirect('ShoppingCart:cart')
    
    # return redirect('ShoppingCart:cart')



    #داش بورد العميل
def user_dashboard_bookings(request):
    # قراءة بيانات الحجوزات من الـ session
    bookings_with_location = request.session.get('bookings_with_location', [])
    
    return render(request, 'admin/user_dashboard/pages/user-bookings.html', {
        'bookings_with_location': bookings_with_location
    })
