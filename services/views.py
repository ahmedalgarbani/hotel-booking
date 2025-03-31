from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from django.utils.timezone import now
from django.views.decorators.csrf import csrf_exempt
from django.db import transaction
import re
from django.contrib.auth.decorators import login_required

from HotelManagement.models import Hotel
from .models import Coupon

@login_required(login_url='/users/login')
@csrf_exempt
def apply_coupon(request):
    if request.method == "POST":
        subtotal = request.POST.get("subtotal", "0")
        coupon_code = request.POST.get("coupon", "")
        hotel_id = request.POST.get("hotel_id", "0")
        
        match = re.search(r'\d+', subtotal)
        if not match:
            return JsonResponse({"message": "المجموع الفرعي غير صالح."}, status=400)
        
        subtotal = float(match.group())
        
        if request.session.get("coupon_applied", False):
            return JsonResponse({"message": "تم تطبيق الكوبون بالفعل."}, status=422)
        
        with transaction.atomic():
            hotel = get_object_or_404(Hotel, id=hotel_id)
            coupon = Coupon.objects.select_for_update().filter(code=coupon_code, status=True, hotel=hotel).first()

            if coupon.min_purchase_amount > subtotal:
                return JsonResponse({"message": "المبلغ اقل من المطلوب لتطبيق الكود"}, status=422)
            
            if not coupon:
                return JsonResponse({"message": "كود الكوبون غير صالح."}, status=422)

            if coupon.quantity <= 0:
                return JsonResponse({"message": "تم استنفاذ الكوبون بالكامل."}, status=422)
            
            if coupon.expired_date < now().date():
                return JsonResponse({"message": "انتهت صلاحية الكوبون."}, status=422)
            
            discount = 0
            if coupon.discount_type == "percent":
                discount = subtotal * (coupon.discount / 100)
            elif coupon.discount_type == "amount":
                discount = coupon.discount
            
            final_total = subtotal - discount

            request.session['coupon'] = {
                'finalTotal': final_total,
                'coupon_id': coupon.id,
                'discount': discount,
                'coupon': coupon.code
            }
            request.session["coupon_applied"] = True


            return JsonResponse({
                "message": "تم تطبيق الكوبون بنجاح.", 
                "finalTotal": final_total, 
                "discount": discount
            }, status=200)
