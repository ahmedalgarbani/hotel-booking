from django import forms
from .models import HotelReview, RoomReview

class HotelReviewForm(forms.ModelForm):
    class Meta:
        model = HotelReview
        fields = [ 'rating_service', 'rating_location', 'rating_value_for_money', 
                  'rating_cleanliness',  'review', 'status']

class RoomReviewForm(forms.ModelForm):
    class Meta:
        model = RoomReview
        fields = ['hotel', 'room_type', 'rating', 'review', 'status']
