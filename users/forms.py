from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.forms import UserCreationForm
from .models import CustomUser, HotelAccountRequest
from django.utils.translation import gettext_lazy as _

class HotelAccountRequestForm(forms.ModelForm):
    class Meta:
        model = HotelAccountRequest
        fields = '__all__'
        
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # جعل جميع الحقول مطلوبة ما عدا الملاحظات
        for field_name, field in self.fields.items():
            if field_name != 'notes':
                field.required = True

# استخدم النموذج (model) بدلاً من النموذج (form)
HotelAccountRequestFormSet = forms.modelformset_factory(
    HotelAccountRequest,
    form=HotelAccountRequestForm,
    extra=1
)

class CustomUser_CreationForm(UserCreationForm):
    phone = forms.CharField(max_length=20, required=False)

    class Meta:
        model = CustomUser
        fields = ('username', 'email', 'password1', 'password2', 'phone')
