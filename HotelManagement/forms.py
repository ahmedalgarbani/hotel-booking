from django import forms
from .models import Hotel, Location, Phone, Image, City

class HotelForm(forms.ModelForm):
    class Meta:
        model = Hotel
        fields = ['location', 'name', 'email', 'description', 'rating', 'is_verified', 'verification_date']

class LocationForm(forms.ModelForm):
    class Meta:
        model = Location
        fields = ['name', 'address', 'city']

class PhoneForm(forms.ModelForm):
    class Meta:
        model = Phone
        fields = ['phone_number', 'country_code']

class ImageForm(forms.ModelForm):
    class Meta:
        model = Image
        fields = ['image_path', 'image_url']

class CityForm(forms.ModelForm):
    class Meta:
        model = City
        fields = ['name', 'state', 'country']
