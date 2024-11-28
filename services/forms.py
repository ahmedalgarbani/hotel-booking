from django import forms
from .models import Service

class ServiceForm(forms.ModelForm):
    class Meta:
        model = Service
        fields = ['name', 'description', 'is_active', 'additional_fee', 'hotel']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 3}),
        }
        labels = {
            'name': "اسم الخدمة",
            'description': "وصف الخدمة",
            'is_active': "نشطة",
            'additional_fee': "القيمة المضافة",
            'hotel': "الفندق",
        }
