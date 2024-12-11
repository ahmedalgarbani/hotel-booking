from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.forms import UserCreationForm
from .models import CustomUser,HotelAccountRequest
from django import forms
from users.models import HotelAccountRequest
from django.forms import modelformset_factory
 # فورم حق انشاء طلبات الفندق 
class HotelAccountRequestForm(forms.ModelForm):
    class Meta:
        model = HotelAccountRequest
        fields = [
            'hotel_name', 
            'owner_name', 
            'email', 
            'phone', 
            'password',
            'hotel_description', 
            'business_license_number', 
            'document_path', 
            'verify_number', 
            'status', 
            'admin_notes'
        ]

# استخدم النموذج (model) بدلاً من النموذج (form)
HotelAccountRequestFormSet = modelformset_factory(HotelAccountRequest, form=HotelAccountRequestForm, extra=1)
class CustomUser_CreationForm(UserCreationForm):
    # user_type = forms.ChoiceField(choices=CustomUser.USER_TYPE_CHOICES)
    phone = forms.CharField(max_length=20, required=False)

    class Meta:
        model = CustomUser

        fields = ('username', 'email', 'password1', 'password2', 'phone')



