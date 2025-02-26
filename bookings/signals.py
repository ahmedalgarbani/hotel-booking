from django.db.models.signals import post_save, post_delete, pre_save
from django.dispatch import receiver
from .models import Booking
from rooms.models import  Availability, RoomImage
@receiver(post_save, sender=Booking)
def update_availability(sender, instance, **kwargs):
    if instance.status == 'complete':  # Check if status is changed to 'complete'
        availability = Availability.objects.filter(
            room_type=instance.room_type, 
            date=instance.check_in_date
        ).first()
        
        if availability and availability.available_rooms > 0:
            availability.available_rooms -= 1  # Reduce available rooms
            availability.save()