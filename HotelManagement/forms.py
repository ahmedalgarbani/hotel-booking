from django import forms
from .models import HotelRequest, City
from django.utils.translation import gettext_lazy as _

class HotelRequestForm(forms.ModelForm):
    new_city_name = forms.CharField(
        max_length=100,
        required=False,
        label=_("اسم المدينة الجديدة"),
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'أدخل اسم المدينة الجديدة',
            'style': 'display: none;'  # سيظهر عبر CSS عند اختيار "مدينة جديدة"
        })
    )

    class Meta:
        model = HotelRequest
        fields = [
            'name', 'email', 'role',
            'hotel_name', 'description', 'profile_picture',
            'business_license_number', 'document_path',
            'address', 'country_code', 'phone_number'
        ]
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'أدخل اسمك الكامل'}),
            'email': forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'أدخل بريدك الإلكتروني'}),
            'role': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'مثال: مالك الفندق، مدير...'}),
            'hotel_name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'اسم الفندق'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 4, 'placeholder': 'وصف مختصر للفندق'}),
            'business_license_number': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'أدخل رقم الرخصة التجارية'}),
            'address': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'العنوان التفصيلي للفندق'}),
            'country_code': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'مثال: +966'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'رقم الهاتف'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # جعل بعض الحقول إلزامية
        self.fields['business_license_number'].required = True
        self.fields['document_path'].required = True
        self.fields['address'].required = True