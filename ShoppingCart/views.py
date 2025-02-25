from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils import timezone
from django.db.models import Q
from .models import ShoppingCart, ShoppingCartItem
from rooms.models import RoomType, RoomPrice
from services.models import HotelService
from decimal import Decimal
from itertools import groupby
from operator import attrgetter

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
    total_price = 0
    
    for hotel_id, items in groupby(cart_items, key=lambda x: x.room_type.hotel):
        items_list = []
        hotel_total = 0
        
        for item in items:
            # البحث عن سعر خاص في جدول الأسعار
            special_price = RoomPrice.objects.filter(
                room_type=item.room_type,
                date_from__lte=item.check_in_date.date(),
                date_to__gte=item.check_out_date.date(),
                deleted_at__isnull=True
            ).first()
            
            # تحديد السعر اليومي
            if special_price:
                daily_price = special_price.price
            else:
                daily_price = item.room_type.base_price
                
            item.daily_price = daily_price
            items_list.append(item)
            item_total = item.Total_price
            hotel_total += item_total
            total_price += item_total
            
        grouped_items[hotel_id] = {
            'hotel': items_list[0].room_type.hotel,
            'items': items_list,
            'hotel_total': hotel_total
        }
    
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
        
        if not all([check_in_date, check_out_date]):
            messages.error(request, 'يرجى تحديد تواريخ تسجيل الدخول والمغادرة')
            return redirect('home:room_detail', room_id=room_id)
        
        try:
            # تحليل التاريخ والوقت
            check_in = timezone.datetime.strptime(check_in_date, '%Y-%m-%d %H:%M')
            check_out = timezone.datetime.strptime(check_out_date, '%Y-%m-%d %H:%M')
        except ValueError:
            messages.error(request, 'صيغة التاريخ غير صحيحة')
            return redirect('home:room_detail', room_id=room_id)
        
        # Get or create shopping cart
        cart, created = ShoppingCart.objects.get_or_create(
            user=request.user,
            deleted_at__isnull=True
        )
        
        # Get room type
        room_type = get_object_or_404(RoomType, id=room_id)
        
        # البحث عن سعر خاص في جدول الأسعار
        special_price = RoomPrice.objects.filter(
            room_type=room_type,
            date_from__lte=check_in.date(),
            date_to__gte=check_out.date(),
            deleted_at__isnull=True
        ).first()

        # حساب السعر الإجمالي بناءً على عدد الأيام
        days = (check_out - check_in).days
        if days < 1:
            days = 1  # حد أدنى يوم واحد

        # استخدام السعر الخاص إذا وجد، وإلا استخدام السعر الأساسي
        if special_price:
            price_per_day = special_price.price
        else:
            price_per_day = room_type.base_price
            
        total_price = Decimal(str(price_per_day)) * Decimal(str(days))
        
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
        
        messages.success(request, 'تمت إضافة الغرفة إلى عربة التسوق بنجاح')
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
            
        # إعادة حساب السعر الإجمالي
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
        if special_price:
            daily_price = special_price.price
        else:
            daily_price = cart_item.room_type.base_price
            
        # حساب السعر الإجمالي
        cart_item.Total_price = Decimal(str(daily_price)) * Decimal(str(days)) * Decimal(str(cart_item.quantity))
        cart_item.save()
        
        messages.success(request, 'تم تحديث الكمية بنجاح')
    
    return redirect('ShoppingCart:cart')
