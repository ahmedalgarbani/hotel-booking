from django import forms
from users.models import HotelAccountRequest
from HotelManagement.models import Hotel

class HotelAccountRequestForm(forms.ModelForm):
    class Meta:
        model = HotelAccountRequest
        fields = [
            'hotel_name', 
            'owner_name', 
            'email', 
            'phone', 
            'hotel_description', 
            'business_license_number', 
            'document_path', 
            'verify_number', 
            'status', 
            'admin_notes'
        ]