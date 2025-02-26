from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from django.db.models import Q
from .models import ShoppingCart, ShoppingCartItem,AdditionalService
from rooms.models import RoomType, RoomPrice
from services.models import HotelService
from decimal import Decimal
from itertools import groupby
from operator import attrgetter
from services.models import RoomTypeService  
from itertools import groupby
from decimal import Decimal
from django.shortcuts import render
from .models import ShoppingCart, AdditionalService

# Create your views here.

@login_required
def cart(request):
    # Get or create shopping cart for the user
    cart, created = ShoppingCart.objects.get_or_create(
        user=request.user,
        deleted_at__isnull=True
    )
    
    # Get all active items in the cart
    cart_items = cart.items.filter(deleted_at__isnull=True)
    
    # Group items by hotel and calculate prices
    cart_items = sorted(cart_items, key=lambda x: x.room_type.hotel.id)
    grouped_items = {}
    total_price = Decimal("0.00")
    
    for hotel, items in groupby(cart_items, key=lambda x: x.room_type.hotel):
        items_list = []
        hotel_total = Decimal("0.00")
        
        for item in items:
            # البحث عن سعر خاص في جدول الأسعار
            special_price = RoomPrice.objects.filter(
                room_type=item.room_type,
                date_from__lte=item.check_in_date.date(),
                date_to__gte=item.check_out_date.date(),
                deleted_at__isnull=True
            ).first()
            
            # تحديد السعر اليومي
            daily_price = special_price.price if special_price else item.room_type.base_price
            item.daily_price = daily_price

            # جلب الخدمات الإضافية لهذا العنصر
            additional_services = item.shopping_services.all()

            # حساب تكلفة الخدمات الإضافية
            additional_services_total = sum(
                Decimal(service.services.additional_fee) 
                for service in additional_services
            )

            # حساب إجمالي العنصر بشكل صحيح
            item_total = (daily_price + additional_services_total) * item.quantity
            item.Total_price = item_total  # تأكد من تحديث السعر الإجمالي
            
            # ** تمرير الخدمات الإضافية إلى القالب **
            item.additional_services = additional_services

            items_list.append(item)
            hotel_total += item_total
        
        grouped_items[hotel.id] = {
            'hotel': items_list[0].room_type.hotel,
            'items': items_list,
            'hotel_total': hotel_total
        }
        total_price += hotel_total  # تحديث الإجمالي الكلي بشكل صحيح
    
    context = {
        'cart': cart,
        'grouped_items': grouped_items,
        'total_price': total_price
    }
    
    return render(request, 'frontend/home/pages/cart.html', context)


@login_required
def add_to_cart(request, room_id):
    if request.method == 'GET':
        check_in_date = request.GET.get('check_in_date')
        check_out_date = request.GET.get('check_out_date')
        extra_services = request.GET.getlist('extra_services') 

        if not all([check_in_date, check_out_date]):
            messages.error(request, 'يرجى تحديد تواريخ تسجيل الدخول والمغادرة')
            return redirect('home:room_detail', room_id=room_id)

        try:
            check_in = timezone.datetime.strptime(check_in_date, '%Y-%m-%d %H:%M')
            check_out = timezone.datetime.strptime(check_out_date, '%Y-%m-%d %H:%M')
        except ValueError:
            messages.error(request, 'صيغة التاريخ غير صحيحة')
            return redirect('home:room_detail', room_id=room_id)

        # Get or create shopping cart
        cart, _ = ShoppingCart.objects.get_or_create(user=request.user, deleted_at__isnull=True)
        
        # Get room type
        room_type = get_object_or_404(RoomType, id=room_id)

        # Get special price if available
        special_price = RoomPrice.objects.filter(
            room_type=room_type,
            date_from__lte=check_in.date(),
            date_to__gte=check_out.date(),
            deleted_at__isnull=True
        ).first()

        days = (check_out - check_in).days
        days = max(days, 1)  # Minimum one day

        price_per_day = special_price.price if special_price else room_type.base_price
        total_price = Decimal(price_per_day) * Decimal(days)

        # Create cart item
        cart_item = ShoppingCartItem.objects.create(
            cart=cart,
            item_type='room',
            room_type=room_type,
            quantity=1,
            Total_price=total_price,
            check_in_date=check_in,
            check_out_date=check_out
        )

        # **Save Additional Services**
        total_additional_fees = Decimal(0)
        for service_id in extra_services:
            service = get_object_or_404(RoomTypeService, id=service_id)
            AdditionalService.objects.create(
                services=service,
                shoppingcartitem=cart_item
            )
            total_additional_fees += Decimal(service.additional_fee)

        # **Update Cart Item Price**
        cart_item.Total_price += total_additional_fees
        cart_item.save()

        messages.success(request, 'تمت إضافة الغرفة والخدمات الإضافية إلى عربة التسوق بنجاح')
        return redirect('ShoppingCart:cart')

    return redirect('home:room_detail', room_id=room_id)


@login_required
def remove_from_cart(request, item_id):
    cart_item = get_object_or_404(ShoppingCartItem, id=item_id, cart__user=request.user)
    cart_item.deleted_at = timezone.now()
    cart_item.save()
    
    messages.success(request, 'تم إزالة العنصر من عربة التسوق')
    return redirect('ShoppingCart:cart')

@login_required
def update_quantity(request, item_id):
    if request.method == 'POST':
        cart_item = get_object_or_404(ShoppingCartItem, id=item_id, cart__user=request.user)
        action = request.POST.get('action')
        
        if action == 'increase':
            cart_item.quantity += 1
        elif action == 'decrease' and cart_item.quantity > 1:
            cart_item.quantity -= 1
            
        # حساب عدد الأيام
        days = (cart_item.check_out_date - cart_item.check_in_date).days
        if days < 1:
            days = 1
            
        # البحث عن سعر خاص
        special_price = RoomPrice.objects.filter(
            room_type=cart_item.room_type,
            date_from__lte=cart_item.check_in_date.date(),
            date_to__gte=cart_item.check_out_date.date(),
            deleted_at__isnull=True
        ).first()
        
        # تحديد السعر اليومي
        daily_price = special_price.price if special_price else cart_item.room_type.base_price
        
        # حساب تكلفة الخدمات الإضافية
        additional_services_total = Decimal('0.00')
        for service in cart_item.shopping_services.all():
            if hasattr(service.services, 'additional_fee'):  # تأكد من أن الحقل موجود
                additional_services_total += Decimal(service.services.additional_fee)
            else:
                print(f"⚠️ Warning: RoomTypeService has no 'additional_fee' field. Check the model.")
        
        # حساب السعر الإجمالي (بما في ذلك الخدمات الإضافية)
        cart_item.Total_price = (
            (Decimal(str(daily_price)) + additional_services_total) * 
            Decimal(str(days)) * 
            Decimal(str(cart_item.quantity))
        )

        cart_item.save()
        messages.success(request, 'تم تحديث الكمية بنجاح')
    
    return redirect('ShoppingCart:cart')
