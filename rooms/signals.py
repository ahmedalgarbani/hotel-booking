from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import RoomType, Availability, RoomStatus
from django.utils import timezone

@receiver(post_save, sender=RoomType)
def create_availability_for_room_type(sender, instance, created, **kwargs):
   
    if created:
        room_status, _ = RoomStatus.objects.get_or_create(
            hotel=instance.hotel,
            code="AVAILABLE",
            defaults={
                "name": "Available",
                "description": "Default status for available rooms",
                "is_available": True,
            }
        )

        today = timezone.now().date()
        Availability.objects.create(
            hotel=instance.hotel,
            room_type=instance,
            room_status=room_status,
            date=today,
            available_rooms=instance.rooms_count,
            notes="Initial availability created automatically.",
        )
