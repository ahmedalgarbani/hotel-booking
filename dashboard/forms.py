from django import forms
from users.models import HotelAccountRequest
from django.forms import modelformset_factory

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