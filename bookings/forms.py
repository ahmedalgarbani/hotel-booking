from django import forms
from django.core.exceptions import ValidationError
from .models import Booking, Availability

class BookingAdminForm(forms.ModelForm):
    class Meta:
        model = Booking
        fields = '__all__'

    def clean(self):
        cleaned_data = super().clean()

        hotel = cleaned_data.get('hotel')
        room = cleaned_data.get('room')
        rooms_booked = cleaned_data.get('rooms_booked')

        latest_availability = (
            Availability.objects.filter(hotel=hotel, room_type=room)
            .order_by('-availability_date')
            .first()
        )

        available_rooms = latest_availability.available_rooms if latest_availability else room.rooms_count

        if rooms_booked > available_rooms:
            raise ValidationError(f"Cannot book {rooms_booked} rooms. Only {available_rooms} rooms are available.")
        
        return cleaned_data
