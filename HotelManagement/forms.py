from django import forms
from .models import HotelRequest, City
from django.utils.translation import gettext_lazy as _

class HotelRequestForm(forms.ModelForm):
    city_choice = forms.ChoiceField(
        label=_("المدينة"),
        widget=forms.Select(attrs={
            'class': 'form-control',
            'placeholder': 'اختر المدينة'
        })
    )
    
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
            'country', 'address',
            'country_code', 'phone_number'
        ]
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'أدخل اسمك الكامل'}),
            'email': forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'أدخل بريدك الإلكتروني'}),
            'role': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'مثال: مالك الفندق، مدير...'}),
            'hotel_name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'اسم الفندق'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 4, 'placeholder': 'وصف مختصر للفندق'}),
            'business_license_number': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'أدخل رقم الرخصة التجارية'}),
            'country': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'الدولة'}),
            'address': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'العنوان التفصيلي'}),
            'country_code': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'مثال: +966'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'رقم الهاتف'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # تجهيز خيارات المدن
        cities = City.objects.all().order_by('state')
        city_choices = [('', '-- اختر المدينة --')]
        city_choices.extend([(str(city.id), f"{city.state} - {city.country}") for city in cities])
        city_choices.append(('new', '-- إضافة مدينة جديدة --'))
        self.fields['city_choice'].choices = city_choices
        
        # جعل بعض الحقول إلزامية
        self.fields['business_license_number'].required = True
        self.fields['document_path'].required = True
        self.fields['country'].required = True

    def clean(self):
        cleaned_data = super().clean()
        city_choice = cleaned_data.get('city_choice')
        new_city_name = cleaned_data.get('new_city_name')
        
        if city_choice == 'new':
            if not new_city_name:
                self.add_error('new_city_name', _('الرجاء إدخال اسم المدينة الجديدة'))
            else:
                cleaned_data['state'] = new_city_name
                if not cleaned_data.get('country'):
                    cleaned_data['country'] = 'المملكة العربية السعودية'
        else:
            try:
                city = City.objects.get(id=int(city_choice))
                cleaned_data['state'] = city.state
                cleaned_data['country'] = city.country
            except (City.DoesNotExist, ValueError):
                self.add_error('city_choice', _('الرجاء اختيار مدينة صحيحة'))
        
        return cleaned_data