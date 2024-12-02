from django import forms
from users.models import HotelAccountRequest

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