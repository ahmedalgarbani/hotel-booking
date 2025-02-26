
from django import forms
from reviews.models import RoomReview  # استيراد مودل RoomReview من نفس التطبيق

class ReviewForm(forms.ModelForm):
    rating = forms.IntegerField(
        label='تقييم الغرفة',
        widget=forms.RadioSelect(
            choices=[(i, str(i)) for i in range(1, 6)],  # خيارات التقييم من 1 إلى 5
            attrs={'class': 'rate-stars-option'}  # يمكنك إضافة كلاسات CSS هنا إذا لزم الأمر
        ),
        min_value=1,
        max_value=5,
    )
    review = forms.CharField(
        label='رسالة المراجعة',
        widget=forms.Textarea(attrs={'rows': 4}), # يمكنك إضافة صفوف افتراضية لـ Textarea
        help_text='اكتب رأيك عن الغرفة'
    )

    class Meta:
        model = RoomReview
        fields = ['rating', 'review']
        # لا نقوم بتضمين حقول 'user' و 'room_type' و 'hotel' هنا، لأننا سنقوم بتعبئتها في الـ View