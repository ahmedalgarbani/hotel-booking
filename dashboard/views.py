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

def approve_hotel_account(request, id):
    hotel_request = HotelAccountRequest.objects.filter(id=id).first()
    
    if hotel_request:
        if CustomUser .objects.filter(username=hotel_request.hotel_name).exists():
            messages.error(request, 'اسم المستخدم موجود بالفعل')
            return redirect('mananghotel')  # Return here if username exists
            
        elif CustomUser .objects.filter(email=hotel_request.email).exists():
            messages.error(request, 'البريد الإلكتروني موجود بالفعل')
            return redirect('mananghotel')  # Return here if email exists

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

            # Update request status
            hotel_request.status = 'approved'
            hotel_request.save()

            return redirect('mananghotel')  # Return after successful creation
    else:
        # If the hotel request is not found, redirect as well
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

def delete_hotel_account_request(request, id_request):
    user = request.user
    if request.method == 'POST':
        try:
            # Get the hotel request
            hotel_request = HotelAccountRequest.objects.get(id=id_request)
            
            # Get the associated user
            try:
                associated_user = CustomUser .objects.get(username=hotel_request.hotel_name)
            except CustomUser .DoesNotExist:
                messages.error(request, 'Associated user not found')
                return redirect('mananghotel')

            # Delete the hotel request and associated user
            hotel_request.delete()
            associated_user.delete()

            # Log the activity
            ActivityLog.objects.create(
                custom_user_id=user,
                table_name='HotelAccountRequest',
                record_id=associated_user.id,  # Log the ID of the deleted user
                action='delete_hotel_account_request'
            )

            return redirect('mananghotel')
        except HotelAccountRequest.DoesNotExist:
            messages.error(request, 'Hotel account request not found')
            return redirect('mananghotel')
    else:
        # # For GET requests, redirect to the management page
        # return redirect('mananghotel')
        pass