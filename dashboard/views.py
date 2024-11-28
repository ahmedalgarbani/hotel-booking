from django.shortcuts import get_object_or_404, redirect, render
from users.models import ActivityLog, HotelAccountRequest,CustomUser
from django.contrib import messages

from .forms import HotelAccountRequestForm 
def dashpord(request):
    user = request.user
    

    return render(request, 'admin/dashboard/index.html',{'user':user})


def mananghotel(request):
    hotel_requset=HotelAccountRequest.objects.all()

    return render(request, 'admin/dashboard/approve_hotel_account.html',{'hotel_requset':hotel_requset})

def details_hotel_account(request, id):
    hotel_request = HotelAccountRequest.objects.filter(id=id).first()

    return render(request,'admin/dashboard/ditals_requst_hotel.html',{'order':hotel_request})
   

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
        
      
        user.set_password(user.password)  
        user.save()

        # تحديث حالة الطلب
        hotel_request.status = 'approved'
        hotel_request.save()

        return redirect('mananghotel')
     else:
        # إذا لم يتم العثور على طلب الفندق، يمكنك إعادة توجيه أو عرض رسالة خطأ
        return redirect('mananghotel')

def edit_hotel_account_request(request, id):
    hotel_request = get_object_or_404(HotelAccountRequest, id=id)
    user=request.user
    if request.method == 'POST':
        form = HotelAccountRequestForm(request.POST, request.FILES, instance=hotel_request)  # تأكد من تمرير request.FILES
        if form.is_valid():
           
            form.save()  # حفظ التعديلات
            ActivityLog.objects.create(
                custom_user_id=user,
                table_name='HotelAccountRequest ',
                record_id=user.id,
                action='edit_hotel_account_request'
            )
            return redirect('mananghotel')
    else:
        form = HotelAccountRequestForm(instance=hotel_request)

    return render(request, 'admin/dashboard/edit_hotel_account_request.html', {
        'form': form,
        'hotel_request': hotel_request
    })
def delet_hotel_account_request(request,id_requesr):
    user=request.user
    if request.method == 'POST':
      hotel_request=HotelAccountRequest.objects.get(id=id_requesr)
      ActivityLog.objects.create(
                custom_user_id=user,
                table_name='HotelAccountRequest ',
                record_id=user.id,
                action='delet_hotel_account_request'
            )
      hotel_request.adelete()
      return redirect('mananghotel')
    else:
        pass