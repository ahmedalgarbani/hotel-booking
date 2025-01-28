from django import forms
from .models import Review

#تحت التطوير 
class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        fields = ['hotel', 'room_type', 'rating', 'content']
        widgets = {
            'rating': forms.Select(choices=[(i, str(i)) for i in range(1, 6)]),
            'content': forms.Textarea(attrs={'rows': 4}),
        }