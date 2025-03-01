from django import forms
from users.models import CustomUser
from django.core.exceptions import ValidationError
from PIL import Image  # استيراد مكتبة PIL للتحقق من أبعاد الصورة

class UserProfileForm(forms.ModelForm):
    class Meta:
        model = CustomUser
        fields = ['first_name', 'last_name', 'phone', 'image']  # تأكد من إضافة 'image' في الحقول
    
    def clean_image(self):
        image = self.cleaned_data.get('image')
        return image
