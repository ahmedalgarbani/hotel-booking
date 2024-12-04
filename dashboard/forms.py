from django import forms
from users.models import HotelAccountRequest
from rooms.models import RoomImage ,RoomType
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




class RoomImageForm(forms.ModelForm):
    hotel = forms.ModelChoiceField(
        queryset=Hotel.objects.all(),
        empty_label="اختر الفندق",
        widget=forms.Select(attrs={'class': 'form-control'})
    )
    room_type = forms.ModelChoiceField(
        queryset=RoomType.objects.all(),
        empty_label="اختر نوع الغرفة",
        widget=forms.Select(attrs={'class': 'form-control'})
    )

    class Meta:
        model = RoomImage
        fields = ['hotel', 'room_type', 'image', 'updated_by', 'created_by']

    def __init__(self, *args, **kwargs):
        self.created_by = kwargs.pop('created_by', None)
        self.updated_by = kwargs.pop('updated_by', None)
        super().__init__(*args, **kwargs)

    def save(self, commit=True):
     instance = super().save(commit=False)
     if self.created_by:
        instance.created_by = self.created_by
     if self.updated_by:
        instance.updated_by = self.updated_by
     if commit:
        instance.save()
     return instance
