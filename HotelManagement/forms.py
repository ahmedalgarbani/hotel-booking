from django import forms
from .models import HotelRequest

class HotelRequestForm(forms.ModelForm):
    class Meta:
        model = HotelRequest
        fields = '__all__'
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4, 'placeholder': 'باللغة الإنجليزية فقط ، بدون HTML ، بدون عنوان ويب أو بريد إلكتروني ، بدون أحرف كبيرة'}),
            'additional_description': forms.Textarea(attrs={'rows': 4, 'placeholder': 'لا يوجد HTML ولا ويب أو عنوان بريد إلكتروني ، ولا تستخدم الأحرف الكبيرة'}),
            'name': forms.TextInput(attrs={'placeholder': 'اسمك'}),
            'email': forms.EmailInput(attrs={'placeholder': 'بريدك الالكتروني'}),
            'role': forms.Select(attrs={'class': 'select-contain-select',}),
            'official_name': forms.TextInput(attrs={'placeholder': 'الاسم التجاري الرسمي'}),
            'country': forms.Select(attrs={'class': 'select-contain-select',}),
            'city': forms.TextInput(attrs={'placeholder': 'مثال: نيويورك'}),
            'street_address': forms.TextInput(attrs={'placeholder': 'رقم المبنى واسم الشارع مثال: 123 Main Street'}),
            'additional_address_info': forms.TextInput(attrs={'placeholder': 'رقم الجناح ، تقاطع ، ساحة ، مربع'}),
            'longitude': forms.TextInput(attrs={'placeholder': 'خريطة خط الطول'}),
            'latitude': forms.TextInput(attrs={'placeholder': 'خريطة Latitude'}),
            'phone': forms.TextInput(attrs={'placeholder': '+1(1)8547632521'}),
            'fax': forms.TextInput(attrs={'placeholder': '+1(1)1147521433'}),
            'website': forms.URLInput(attrs={'placeholder': 'https://www.techydevs.com'}),
            'facebook': forms.URLInput(attrs={'placeholder': 'https://www.facebook.com'}),
            'instagram': forms.URLInput(attrs={'placeholder': 'https://www.instagram.com'}),
            'twitter': forms.URLInput(attrs={'placeholder': 'https://www.twitter.com'}),
            'linkedin': forms.URLInput(attrs={'placeholder': 'https://www.linkedin.com'}),
             'total_rooms': forms.TextInput(attrs={'placeholder': 'إجمالي عدد الغرف والأجنحة'}),
             'price_range_min': forms.TextInput(attrs={'placeholder': 'دقيقة'}),
             'price_range_max': forms.TextInput(attrs={'placeholder': 'ماكس'}),
            'currency': forms.Select(attrs={'class': 'select-contain-select'}),
             'image': forms.FileInput(attrs={'class': 'multi file-upload-input with-preview'}),
        }