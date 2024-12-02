from email.charset import QP
from xml.etree.ElementTree import QName
from django.shortcuts import get_object_or_404, redirect, render
from users.models import ActivityLog, HotelAccountRequest,CustomUser
from django.contrib import messages

from .forms import HotelAccountRequestForm 


def create_user(request,):
    pass


def list_user(request,):

     pass

def update_user(request,):
    pass


def deleste_user(request,):
    pass


# -------------------- page home dashpord ----------------------------
def dashpord(request):
    user = request.user
    

    return render(request, 'admin/dashboard/index.html',{'user':user})

# -------------------- view HotelAccountRequest ----------------------------
def Hotel_Account_Request_list(request):
    hotel_requset=HotelAccountRequest.objects.all()

    return render(request, 'admin/dashboard/approve_hotel_account.html',{'hotel_requset':hotel_requset})




def details_hotel_account(request, id):
    hotel_request = HotelAccountRequest.objects.filter(id=id).first()

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
    user=request.user
    if request.method == 'POST':
        form = HotelAccountRequestForm(request.POST, request.FILES, instance=hotel_request) 
        if form.is_valid():
            status= form.cleaned_data.get("status")
            hotel_name=form.cleaned_data.get('hotel_name')

            if status=="rejected":
                users=CustomUser.objects.filter(username=hotel_name).delete()
                form.save()  
                ActivityLog.objects.create(
                custom_user_id=user,
                table_name='HotelAccountRequest ',
                record_id=user.id,
                action='edit_hotel_account_request'
              )
                return redirect('mananghotel')
            elif status == "pending":
                users=CustomUser.objects.filter(username=hotel_name).delete()
                form.save()  
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