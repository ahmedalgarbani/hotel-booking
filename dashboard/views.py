
from django.shortcuts import get_object_or_404, redirect, render
from users.models import ActivityLog, HotelAccountRequest,CustomUser
from django.contrib import messages
from users.forms import CustomUser_CreationForm, HotelAccountRequestForm
from django.forms import inlineformset_factory
from .forms import HotelAccountRequestForm,HotelAccountRequestFormSet



def create_user(request):
    if request.method == 'POST':
        form = CustomUser_CreationForm(request.POST)

        if form.is_valid():
            user = form.save(commit=False)
            user_type = form.cleaned_data.get('user_type')
            
            
            if user_type == 'hotel_manager':
                return redirect('request_hotel_account')  

            if user_type == "admin":
                messages.error(request, 'لا يمكنك انشاء حساب مسوول ')
                return redirect('register') 
            else:
                user.is_superuser = False
                user.is_staff = False

            user.save()
            return redirect('login')  
    else:
        form = CustomUser_CreationForm()
    
    return render(request, 'admin/dashboard/create_user.html', {'form': form})


# def create_user(request):
#     # تعيين قيمة افتراضية لـ formset
#     formset = None

#     if request.method == 'POST':
#         # إنشاء نموذج المستخدم باستخدام البيانات المرسلة
#         user_form = CustomUser_CreationForm(request.POST)
        
#         if user_form.is_valid():
#             # حفظ المستخدم الجديد
#             user = user_form.save()
            
#             # إنشاء InlineFormSet لطلبات الحساب الفندقي
#             HotelAccountRequestFormSet = inlineformset_factory(
#                 CustomUser ,
#                 HotelAccountRequest,
#                 form=HotelAccountRequestForm,
#                 extra=1,
#                 fk_name='user'  # استخدام 'user' كاسم ForeignKey
#             )
            
#             # إنشاء نموذج المجموعة باستخدام البيانات المرسلة
#             formset = HotelAccountRequestFormSet(request.POST, instance=user)
            
#             if formset.is_valid():
#                 # حفظ الطلبات
#                 formset.save()
#                 messages.success(request, 'تم إنشاء المستخدم وطلبات الحساب بنجاح!')
#                 return redirect('list_user')  # إعادة التوجيه إلى قائمة المستخدمين
#             else:
#                 messages.error(request, 'هناك خطأ في طلبات الحساب. يرجى التحقق من المدخلات.')
#         else:
#             messages.error(request, 'هناك خطأ في تفاصيل المستخدم. يرجى التحقق من المدخلات.')
#     else:
#         # إذا كانت الطريقة GET، إنشاء نماذج فارغة
#         user_form = CustomUser_CreationForm()
#         HotelAccountRequestFormSet = inlineformset_factory(
#             CustomUser ,
#             HotelAccountRequest,
#             form=HotelAccountRequestForm,
#             extra=1,
#             fk_name='user'  # استخدام 'user' كاسم ForeignKey
#         )
#         formset = HotelAccountRequestFormSet(queryset=HotelAccountRequest.objects.none())  # لا تظهر أي طلبات موجودة

#     return render(request, 'admin/dashboard/create_user_with_requests.html', {
#         'user_form': user_form,
#         'formset': formset,
#     })
def list_user(request):
    users = CustomUser.objects.all()
    return render(request, 'admin/dashboard/list_user.html', {'users': users})
def update_user(request, id):
    user = get_object_or_404(CustomUser , id=id)
    if request.method == 'POST':
        form = CustomUser_CreationForm(request.POST, instance=user) 
        if form.is_valid():
            form.save()
            messages.success(request, 'تم تحديث المستخدم بنجاح!')
            return redirect('list_user') 
    else:
        form = CustomUser_CreationForm(instance=user)

    return render(request, 'admin/dashboard/update_user.html', {'form': form, 'user': user})
       


def delete_user(request, id):
    user = get_object_or_404(CustomUser , id=id)
    if request.method == 'POST':
         hotelAccountRequest=HotelAccountRequest.objects.filter(hotel_name=user.username)
         if hotelAccountRequest.exists():
             
          hotelAccountRequest.delete()
          user.delete()
          messages.success(request, 'تم حذف المستخدم بنجاح!')
          return redirect('list_user')  
    return render(request, 'admin/dashboard/delete_user.html', {'user': user})


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
                password=hotel_request.password, 
                user_type="hotel_manager",
                is_staff = True
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
            status= form.cleaned_data.get("status")
            hotel_name=form.cleaned_data.get('hotel_name')

            if status=="rejected":
                users=CustomUser.objects.filter(username=hotel_name).delete()
                form.save()  
                ActivityLog.objects.create(
                custom_user_id=user,
                table_name='HotelAccountRequest',
                record_id=hotel_request.id,  
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
        formset = HotelAccountRequestFormSet(request.POST, request.FILES)
        if formset.is_valid():
           
            formset.save()
            messages.success(request, 'تم إنشاء طلب فتح الحساب بنجاح!')
            return redirect('mananghotel')  
    else:
        # استخدم FormSet جديد بدون أي بيانات موجودة
        formset = HotelAccountRequestFormSet(queryset=HotelAccountRequest.objects.none())

    return render(request, 'admin/dashboard/create_hotel_account_request.html', {'formset': formset})


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