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
        self.fields['country_code'].required = True
        self.fields['phone_number'].required = True
        self.fields['role'].required = True

        # تعيين القيم الافتراضية
        self.fields['country_code'].initial = '+967'
        self.fields['role'].initial = 'مدير فندق'

        # جعل حقل الدور للقراءة فقط
        self.fields['role'].widget.attrs['readonly'] = True

    def clean_phone_number(self):
        """التحقق من أن رقم الهاتف يتكون من 9 أرقام فقط"""
        phone_number = self.cleaned_data.get('phone_number')

        if phone_number:
            # إزالة أي أحرف غير رقمية
            phone_number = ''.join(filter(str.isdigit, phone_number))

            # التحقق من الطول
            if len(phone_number) != 9:
                raise forms.ValidationError(_('يجب أن يتكون رقم الهاتف من 9 أرقام فقط'))

        return phone_number