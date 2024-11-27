from django.shortcuts import get_object_or_404, redirect, render
from users.models import HotelAccountRequest,CustomUser
def dashpord(request):
    user = request.user
    

    return render(request, 'admin/dashboard/index.html',{'user':user})


def mananghotel(request):
    hotel_requset=HotelAccountRequest.objects.all()

    return render(request, 'dashboard/approve_hotel_account.html',{'hotel_requset':hotel_requset})

def details_hotel_account(request, id):
    hotel_request = HotelAccountRequest.objects.filter(id=id).first()

    return render(request,'dashboard/ditals_requst_hotel.html',{'order':hotel_request})
   

def approve_hotel_account(request,id):
     hotel_request = HotelAccountRequest.objects.filter(id=id).first()
     if hotel_request:
     
        user = CustomUser (
            username=hotel_request.hotel_name,
            email=hotel_request.email,
            phone=hotel_request.phone,
            password='123', 
            user_type="hotel_manager"
        )
        
        # حفظ المستخدم الجديد
        user.set_password(user.password)  # استخدام هذه الدالة لتشفير كلمة المرور
        user.save()

        # تحديث حالة الطلب
        hotel_request.status = 'approved'  # يجب أن يكون 'approved' بدلاً من 'approve'
        hotel_request.save()

        return redirect('mananghotel')
     else:
        # إذا لم يتم العثور على طلب الفندق، يمكنك إعادة توجيه أو عرض رسالة خطأ
        return redirect('mananghotel')

 