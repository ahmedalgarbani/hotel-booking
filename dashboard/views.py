from email.charset import QP
from xml.etree.ElementTree import QName
from django.shortcuts import get_object_or_404, redirect, render
from dashboard.forms import HotelAccountRequestForm, RoomImageForm
from users.models import ActivityLog, HotelAccountRequest,CustomUser
from django.contrib import messages
from rooms.models import RoomType,RoomPrice,RoomStatus,Category,Availability,RoomImage

from django import forms 
# from django.shortcuts import render, redirect
# from django.http import HttpResponse
# from .forms import RoomImageForm 
# -------------------- page home dashpord ----------------------------
def dashpord(request):
    user = request.user
    

    return render(request, 'admin/dashboard/index.html',{'user':user})

# -------------------- view HotelAccountRequest ----------------------------


def Hotel_Account_Request_list(request):
    hotel_requset=HotelAccountRequest.objects.all()

    return render(request, 'admin/dashboard/approve_hotel_account.html',{'hotel_requset':hotel_requset})




def details_hotel_account(request, slug):
    hotel_request = get_object_or_404(HotelAccountRequest, slug=slug)
    return render(request,'admin/dashboard/ditals_requst_hotel.html',{'order':hotel_request})

def approve_Hotel_Account_Request(request, id):
    hotel_request = HotelAccountRequest.objects.filter(id=id).first()
    
    if hotel_request:
        if CustomUser .objects.filter(username=hotel_request.hotel_name).exists():
            messages.error(request, 'اسم المستخدم موجود بالفعل')
            return redirect('mananghotel')  
            
        elif CustomUser .objects.filter(email=hotel_request.email).exists():
            messages.error(request, 'البريد الإلكتروني موجود بالفعل')
            return redirect('mananghotel') 
        else:    
            user = CustomUser  (
                username=hotel_request.hotel_name,
                email=hotel_request.email,
                phone=hotel_request.phone,
                password='123', 
                user_type="hotel_manager"
            )
        
            user.set_password(user.password)  
            user.save()

           
            hotel_request.status = 'approved'
            hotel_request.save()

            return redirect('mananghotel') 
    else:
       
        return redirect('mananghotel')
def edit_hotel_account_request(request, id):
    hotel_request = get_object_or_404(HotelAccountRequest, id=id)
    user = request.user
    if request.method == 'POST':
        form = HotelAccountRequestForm(request.POST, request.FILES, instance=hotel_request) 
        if form.is_valid():
            form.save()
            ActivityLog.objects.create(
                custom_user_id=user,
                table_name='HotelAccountRequest',
                record_id=hotel_request.id,  
                action='edit_hotel_account_request'
            )
            messages.success(request, 'تم تعديل الطلب بنجاح!')
            return redirect('mananghotel')
    else:
        form = HotelAccountRequestForm(instance=hotel_request)

    return render(request, 'admin/dashboard/edit_hotel_account_request.html', {
        'form': form,
        'hotel_request': hotel_request
    })

def create_hotel_account_request(request):
    if request.method == 'POST':
        form = HotelAccountRequestForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, 'تم إنشاء طلب فتح الحساب بنجاح!')
            return redirect('mananghotel')  
    else:
        form = HotelAccountRequestForm()

    return render(request, 'admin/dashboard/create_hotel_account_request.html', {'form': form})








def delete_hotel_account_request(request, id_request):
    user = request.user
    if request.method == 'POST':
        try:
           
            hotel_request = HotelAccountRequest.objects.get(id=id_request)
            
            
            try:
                associated_user = CustomUser .objects.get(username=hotel_request.hotel_name)
            except CustomUser .DoesNotExist:
                messages.error(request, 'Associated user not found')
                return redirect('mananghotel')

            
            hotel_request.delete()
            associated_user.delete()

            
            ActivityLog.objects.create(
                custom_user_id=user,
                table_name='HotelAccountRequest',
                record_id=associated_user.id,  
                action='delete_hotel_account_request'
            )

            return redirect('mananghotel')
        except HotelAccountRequest.DoesNotExist:
            messages.error(request, 'Hotel account request not found')
            return redirect('mananghotel')
    else:
       
        pass






 # -------------------- view romms ----------------------------#
 
 

#----------------------صفحه الانواع----------------------#
def rooms_types(request):
     data_types=RoomType.objects.all()
     print(data_types)
     return render(request, 'admin/dashboard/room/rooms_types.html',{'roomType':data_types})





#----------------------صفحه التوافر----------------------#
def rooms_availability(request):
     data_availability=Availability.objects.all()
     print(data_availability)
     return render(request, 'admin/dashboard/room/rooms_availability.html',{'roomavailability':data_availability})





#----------------------صفحه الفئات----------------------#
def rooms_categories(request):
     data_Category=Category.objects.all()
     return render(request, 'admin/dashboard/room/rooms_categories.html',{'roomCategory':data_Category})





#----------------------صفحه الاسعار----------------------#
def rooms_prices(request):
     data_roomPrice=RoomPrice.objects.all()
     return render(request, 'admin/dashboard/room/rooms_prices.html',{'roomPrice':data_roomPrice})




#----------------------صفحه الحاله----------------------#
def rooms_status(request):
     data_roomStatus=RoomStatus.objects.all()
     return render(request, 'admin/dashboard/room/rooms_status.html',{'roomStatus':data_roomStatus})




#----------------------صفحه الصور----------------------#
def rooms_images(request):
     data_roomImage=RoomImage.objects.all()
     return render(request, 'admin/dashboard/room/rooms_images.html',{'roomImage':data_roomImage})   
# تأكد من استبدال "YourModel" بنموذجك

 # افترض أن لديك نموذج

def add_rooms_images(request):
    if request.method == 'POST':
        created_by = request.user
        updated_by = request.user
        form = RoomImageForm(request.POST, request.FILES, created_by=created_by, updated_by=updated_by)

        if form.is_valid():
            instance = form.save(commit=False)
            instance.save()
            return redirect('rooms_images')  # استبدل بـ URL ناجح
        else:
            return render(request, 'admin/dashboard/room/add_rooms_images.html', {'form': form})
    else:
        form = RoomImageForm()
        return render(request, 'admin/dashboard/room/add_rooms_images.html', {'form': form})
    
    