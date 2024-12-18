from django import forms
from .models import Hotel, Location, Phone, Image, City
from django.utils.translation import gettext_lazy as _

class HotelForm(forms.ModelForm):
    class Meta:
        model = Hotel
        fields = [
            'name',
            'description',
            'manager',
            'location'
        ]
        labels = {
            'name': _('اسم الفندق'),
            'description': _('وصف الفندق'),
            'manager': _('مدير الفندق'),
            'location': _('موقع الفندق')
        }

class LocationForm(forms.ModelForm):
    class Meta:
        model = Location
        fields = ['name', 'address', 'city']
        labels = {
            'name': _('اسم الموقع'),
            'address': _('العنوان'),
            'city': _('المدينة')
        }

class PhoneForm(forms.ModelForm):
    class Meta:
        model = Phone
        fields = ['phone_number', 'country_code', 'hotel']
        labels = {
            'phone_number': _('رقم الهاتف'),
            'country_code': _('رمز الدولة'),
            'hotel': _('الفندق')
        }

class ImageForm(forms.ModelForm):
    class Meta:
        model = Image
        fields = ['image_path', 'image_url', 'hotel_id']
        labels = {
            'image_path': _('مسار الصورة'),
            'image_url': _('رابط الصورة'),
            'hotel_id': _('الفندق')
        }

class CityForm(forms.ModelForm):
    class Meta:
        model = City
        fields = ['name', 'state', 'country']
        labels = {
            'name': _('اسم المدينة'),
            'state': _('المحافظة'),
            'country': _('الدولة')
        }
