from django.shortcuts import get_object_or_404, render, redirect
from HotelManagement.services import check_room_availability_full
from rooms.models import RoomType
from HotelManagement.models import Hotel
from rooms.services import calculate_total_cost, check_room_availability
from services.models import RoomTypeService
from django.contrib import messages
from django.utils import timezone
from datetime import datetime, timedelta
from django.urls import reverse
import json
from datetime import datetime
import random
from decimal import Decimal
from django.core.serializers.json import DjangoJSONEncoder
from bookings.models import Booking, BookingDetail, Guest
from payments.models import Payment,HotelPaymentMethod
from django.db import transaction
from django.contrib.auth.decorators import login_required
import logging
import traceback

from users.models import CustomUser

logger = logging.getLogger(__name__)



def process_booking(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)    
    if request.method == "POST":
        check_in = request.POST.get("check_in_date")
        check_out = request.POST.get("check_out_date")
        room_number = int(request.POST.get("room_number", 1))
        adult_number = int(request.POST.get("adult_number", 1))
        extra_services = request.POST.getlist("extra_services")

        if not check_in or not check_out:
            messages.error(request, "يرجى تحديد تاريخ الدخول والخروج.")
            return redirect('rooms:room_detail', room_id=room_id)

        try:
            check_in_date = datetime.strptime(check_in, '%Y-%m-%d').date()
            check_out_date = datetime.strptime(check_out, '%Y-%m-%d').date()
        except ValueError:
            messages.error(request, "صيغة التاريخ غير صحيحة. يجب أن تكون بالشكل YYYY-MM-DD.")
            return redirect('rooms:room_detail', room_id=room_id)

        today = timezone.now().date()
        if check_in_date < today:
            messages.error(request, "لا يمكن اختيار تاريخ دخول في الماضي.")
            return redirect('rooms:room_detail', room_id=room_id)

        if check_out_date <= check_in_date:
            messages.error(request, "يجب أن يكون تاريخ الخروج بعد تاريخ الدخول.")
            return redirect('rooms:room_detail', room_id=room_id)

        if room_number < 1:
            messages.error(request, "يجب أن يكون عدد الغرف 1 على الأقل.")
            return redirect('rooms:room_detail', room_id=room_id)

        if adult_number > room.max_capacity:
            messages.error(request, f"السعة القصوى لهذا النوع من الغرف هي {room.max_capacity} أشخاص.")
            return redirect('rooms:room_detail', room_id=room_id)

        # is_available, message = check_room_availability(room, room.hotel, room_number)
        is_available, message = check_room_availability_full(today_date=today,hotel=room.hotel,room_type=room,  required_rooms=room_number,check_in=check_in_date,check_out=check_out_date)

        if not is_available:
            messages.error(request, message)
            return redirect('rooms:room_detail', room_id=room_id)
        total_price,room_price= calculate_total_cost(room, check_in_date, check_out_date, room_number)

        extra_services_details = []
        extra_services_total = 0.0

        for service_id in extra_services:
            service = RoomTypeService.objects.filter(id=service_id).first()
            if service:
                service_price = float(service.additional_fee)
                extra_services_total += service_price
                extra_services_total *= room_number
                extra_services_details.append({
                    "id": service.id,
                    "name": service.name,
                    "price": service_price
                })
        days_count = (check_out_date - check_in_date).days
        grand_total = total_price + extra_services_total

        from decimal import Decimal

        request.session["booking_data"] = {
            "hotel_id": room.hotel.id,
            "room_id": room_id,
            "check_in": check_in,
            "check_out": check_out,
            "days":days_count,
            "room_price": float(room_price) if isinstance(room_price, Decimal) else room_price,
            "room_number": room_number,
            "adult_number": adult_number,
            "total_price": float(grand_total) if isinstance(grand_total, Decimal) else grand_total,
            "extra_services": extra_services_details,
            "extra_services_total": float(extra_services_total) if isinstance(extra_services_total, Decimal) else extra_services_total,
            "grand_total": float(grand_total) if isinstance(grand_total, Decimal) else grand_total,
        }


        return redirect(reverse("payments:checkout", args=[room_id]))

    return redirect(reverse("rooms:room_detail", args=[room_id]))




# Later
@login_required(login_url='/users/login') 
def add_guest(request, booking_id): 
    booking = get_object_or_404(Booking, id=booking_id, user=request.user)
    hotel = booking.hotel
    room = booking.room
    max_guests_allowed = room.max_capacity * booking.rooms_booked 


    if request.method == "POST":
        guests_data = request.POST
        id_card_images = request.FILES.getlist('id_card_image[]', [])

        names = guests_data.getlist('name[]')
        phone_numbers = guests_data.getlist('phone_number[]')
        genders = guests_data.getlist('gender[]')
        birthday_dates = guests_data.getlist('birthday_date[]')

        num_guests_submitted = len(names)

        if num_guests_submitted > max_guests_allowed:
            messages.error(request, f"لا يمكنك إضافة أكثر من {max_guests_allowed} ضيف لهذا الحجز.")
            context = {
                "booking": booking,
                "room": room,
                "hotel": hotel,
                "max_guests": max_guests_allowed,
    
            }
            return render(request, "frontend/home/pages/add_guest.html", context)

        guests_to_create = []
        for i in range(num_guests_submitted):
           
            # ... (أضف التحقق هنا إذا لزم الأمر) ...

            guest = Guest(
                hotel=hotel,
                booking=booking,
                name=names[i],
                phone_number=phone_numbers[i],
                gender=genders[i],
                birthday_date=birthday_dates[i] if birthday_dates[i] else None, 
                id_card_image=id_card_images[i] if i < len(id_card_images) else None,
                check_in_date=booking.check_in_date,
                check_out_date=booking.check_out_date,
                created_by=request.user, 
                updated_by=request.user 
            )
            guests_to_create.append(guest)

        try:
            Guest.objects.bulk_create(guests_to_create)
            messages.success(request, f"تم إضافة {num_guests_submitted} ضيف بنجاح.")
            return redirect(reverse("customer:user_dashboard_bookings"))
        except Exception as e:
            messages.error(request, f"حدث خطأ أثناء حفظ الضيوف: {e}")
            context = {
                "booking": booking,
                "room": room,
                "hotel": hotel,
                "max_guests": max_guests_allowed,
            }
            return render(request, "frontend/home/pages/add_guest.html", context)


    context = {
        "booking": booking,
        "room": room,
        "hotel": hotel,
        "max_guests": max_guests_allowed, 
    }
    return render(request, "frontend/home/pages/add_guest.html", context)





class DecimalEncoder(DjangoJSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        return super().default(obj)
    
@login_required(login_url='/users/login')
def checkout(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)
    hotel = room.hotel
    payment_methods = HotelPaymentMethod.objects.filter(hotel=hotel,is_active=True)

    check_in = request.GET.get('check_in_date')
    check_out = request.GET.get('check_out_date')

    try:
        check_in_date = datetime.strptime(check_in, '%Y-%m-%d %H:%M') if check_in else timezone.now()
        check_out_date = datetime.strptime(check_out, '%Y-%m-%d %H:%M') if check_out else (timezone.now() + timedelta(days=1))
    except (ValueError, TypeError):
        check_in_date = timezone.now()
        check_out_date = timezone.now() + timedelta(days=1)


    booking_data = request.session.get("booking_data", {})    
    context = {
        'room': room,
        'paymentsMethods': payment_methods,
        'check_in_display': check_in_date.strftime('%d/%m/%Y %I:%M %p'),
        'check_out_display': check_out_date.strftime('%d/%m/%Y %I:%M %p'),
        'booking_data': booking_data,
    }

    return render(request, 'frontend/home/pages/checkout.html', context)



def save_guests(request, room_id):
    if request.method == "POST":
        guest_names = request.POST.getlist("guest_name[]")
        guest_ages = request.POST.getlist("guest_age[]")
        guest_id_numbers = request.POST.getlist("guest_id_number[]")
        booking_data = request.session.get("booking_data", {})
        guests = []
        for name, age, id_number in zip(guest_names, guest_ages, guest_id_numbers):
            guests.append({
                "name": name,
                "age": age,
                "id_number": id_number if id_number else None,
                "check_in_date": booking_data["check_in"],
                "check_out_date":booking_data["check_out"],
            })

        request.session["guests"] = guests
        request.session.modified = True

        return redirect("payments:checkout", room_id=room_id)

    return redirect("payments:add_guest", room_id=room_id)



logger = logging.getLogger(__name__)

def hotel_confirm_payment(request):
    if request.method != 'POST':
        return redirect("payments:checkout", room_id=request.session.get("booking_data", {}).get("room_id", 1))

    try:
        with transaction.atomic():
            booking_data = request.session.get("booking_data")
            if not booking_data:
                messages.error(request, "لم يتم العثور على بيانات الحجز. يرجى إعادة المحاولة.")
                return redirect("home:index")

      
            payment_method_id = request.POST.get("payment_method")
            transfer_image = request.FILES.get("transfer_image")

            payment_method = get_object_or_404(HotelPaymentMethod, id=payment_method_id)
            pending_status = Booking.BookingStatus.PENDING

            coupon_data = request.session.get("coupon", {})
            amount_to_pay = coupon_data.get("finalTotal", booking_data.get("grand_total", 0))
            discount = coupon_data.get("discount", 0)
            discount_code = coupon_data.get("coupon", "")

            booking = Booking.objects.create(
                hotel_id=booking_data["hotel_id"],
                user=request.user,
                room_id=booking_data["room_id"],
                check_in_date=booking_data["check_in"],
                check_out_date=booking_data["check_out"],
                amount=amount_to_pay,
                status=pending_status,
                rooms_booked=booking_data["room_number"],
            )
            for service_detail in booking_data.get("extra_services", []):
                service_id = service_detail["id"]
                quantity = booking_data["room_number"] * booking_data["days"]
                price = service_detail["price"]

                try:
                    service = RoomTypeService.objects.get(id=service_id)
                except RoomTypeService.DoesNotExist:
                    continue  

                BookingDetail.objects.create(
                    booking=booking,
                    hotel_id=booking_data["hotel_id"],
                    service=service,
                    quantity=quantity,
                    price=price,
                    notes=f"خدمة إضافية للحجز - {service.name}"
                )

            payment = Payment.objects.create(
                payment_method=payment_method,
                payment_status=0,  
                user=request.user,
                payment_date=timezone.now(),
                payment_subtotal=booking_data.get("total_price", 0),
                payment_discount=discount,
                payment_discount_code=discount_code,
                payment_totalamount=amount_to_pay,
                payment_currency=payment_method.payment_option.currency.currency_symbol,
                booking=booking,
                payment_type='e_pay' if payment_method.payment_option.method_name != 'كاش' else 'cash',
                payment_note=f"تم التحويل بواسطة: {request.user.get_full_name()} - ",
                transfer_image=transfer_image
            )

            request.session.pop("booking_data", None)
            request.session.pop("coupon", None)
            request.session.pop("coupon_applied", None)

            messages.success(request, "تم تأكيد الدفع والحجز بنجاح.")
            return render(request, 'frontend/home/pages/payment-complete.html', {
                'payment': payment,
                'booking': booking,
               
            })

    except Exception as e:
        logger.error(f"خطأ أثناء تأكيد الدفع: {traceback.format_exc()}")
        messages.error(request, f"حدث خطأ أثناء إتمام العملية: {str(e)}")
        return redirect("payments:checkout", room_id=booking_data.get("room_id", 1) if booking_data else 1)  


def user_dashboard_bookings(request):
    bookings_with_location = request.session.get('bookings_with_location', [])
    
    return render(request, 'admin/user_dashboard/pages/user-bookings.html', {
        'bookings_with_location': bookings_with_location
    })




def payment_detail_view(request, pk):
    payment = get_object_or_404(Payment, pk=pk)
    return render(request, 'admin/payments/payment_detail.html', {'payment': payment})


from django.utils.translation import gettext as _


@login_required
def change_payment_status_view(request, payment_id):
    payment = get_object_or_404(Payment, id=payment_id)

    if not request.user.is_superuser:
        hotel_manager = payment.booking.hotel.manager
        if hotel_manager is None or hotel_manager.id != request.user.id:
            messages.error(request, _("ليس لديك إذن لتعديل هذه الدفعة."))
            return redirect('/admin')

    if request.method == 'POST':
        new_status = request.POST.get('status')
        try:
            with transaction.atomic():
                payment.payment_status = new_status
                payment.save()

                if int(new_status) == 1:  
                    payment.booking.status = Booking.BookingStatus.CONFIRMED
                    payment.booking.save()
                if int(new_status) == 2:  
                    payment.booking.status = Booking.BookingStatus.CANCELED
                    payment.booking.save()

            label = dict(Payment.payment_choice).get(int(new_status), new_status)
            messages.success(request, _(f"تم تغيير حالة الدفعة إلى '{label}'"))

        except Exception as e:
            messages.error(request, _("حدث خطأ أثناء تحديث الحالة: {}").format(str(e)))

    return redirect('payments:external-payment-detail', pk=payment.id)

