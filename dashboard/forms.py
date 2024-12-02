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
      hotel = forms.ChoiceField(choices=Hotel.objects.all())
      room_type = forms.ModelChoiceField(
        queryset=RoomType.objects.all(),  # استعلام لجلب جميع أنواع الغرف
        empty_label="اختر نوع الغرفة",   # خيار افتراضي يظهر أولاً
        widget=forms.Select(attrs={'class': 'form-control'})
    )
      class Meta:
         model = RoomImage
         fields = [
            'hotel', 
            'room_type', 
            'image',
            'updated_by',
            'created_by', 
           
         ]   
          # Override the __init__ method to accept created_by and updated_by
      def __init__(self, *args, **kwargs):
        self.created_by = kwargs.pop('created_by', None)  # Remove from kwargs and store in instance
        self.updated_by = kwargs.pop('updated_by', None)  # Same for updated_by
        super().__init__(*args, **kwargs)  # Call the parent class' init

      def save(self, commit=True):
        instance = super().save(commit=False)  # Don't save yet

        if self.created_by:
            instance.created_by = self.created_by  # Assign created_by user object
        if self.updated_by:
            instance.updated_by = self.updated_by  # Assign updated_by user object
        
        if commit:
            instance.save()  # Now save the instance to the DB

        return instance
