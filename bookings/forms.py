from django import forms
from django.core.exceptions import ValidationError

from rooms.services import change_date_format, change_date_format2
from .models import Booking, Availability, ExtensionMovement
from django.utils.translation import gettext_lazy as _


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


class BookingExtensionForm(forms.Form):
    new_check_out = forms.DateField(
        label=_("تاريخ الخروج الجديد"),
        widget=forms.DateInput(attrs={
            'type': 'date',
            'class': 'form-input',
            'min': "{{ check_out|date:'Y-m-d' }}",
            'required': 'required'
        })
    )
    reason = forms.ChoiceField(
        label=_("سبب التمديد"),
        choices=ExtensionMovement.REASON_CHOICES,
        widget=forms.Select(attrs={
            'class': 'form-input',
            'required': 'required'
        })
    )

    def clean_new_check_out(self):
        new_check_out = change_date_format2(str(self.cleaned_data.get('new_check_out')))
        print(new_check_out)
        print(self.booking)
        print(self.booking.check_out_date)
        if self.booking and new_check_out <= self.booking.check_out_date:
            raise ValidationError("يجب أن يكون تاريخ الخروج الجديد بعد تاريخ الخروج الحالي.")
        return new_check_out

    def __init__(self, *args, **kwargs):
        self.booking = kwargs.pop('booking', None)
        super().__init__(*args, **kwargs)

        if self.booking:
            available_rooms = self.get_available_rooms()  

    def get_available_rooms(self):
        latest_availability = (
            Availability.objects.filter(hotel=self.booking.hotel, room_type=self.booking.room)
            .order_by('-availability_date')
            .first()
        )
        return latest_availability.available_rooms if latest_availability else self.booking.room.rooms_count

    def clean(self):
        cleaned_data = super().clean()
        new_check_out = cleaned_data.get('new_check_out')

        if self.booking and new_check_out:
            overlapping_bookings = Booking.objects.filter(
                room=self.booking.room,
                check_in_date__lt=new_check_out,
                check_out_date__gt=self.booking.check_out_date
            ).exclude(pk=self.booking.pk)

            total_booked = sum(booking.rooms_booked for booking in overlapping_bookings)
            available_rooms = self.get_available_rooms()

        return cleaned_data
