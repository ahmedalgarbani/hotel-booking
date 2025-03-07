from django.db.models.signals import post_save
from django.dispatch import receiver

from bookings.models import Booking
from .models import RoomType, Availability, RoomStatus
from django.utils import timezone

# @receiver(post_save, sender=RoomType)
# def create_availability_for_room_type(sender, instance, created, **kwargs):
   
#     if created:
#         room_status, _ = RoomStatus.objects.get_or_create(
#             hotel=instance.hotel,
#             code="AVAILABLE",
#             defaults={
#                 "name": "Available",
#                 "description": "Default status for available rooms",
#                 "is_available": True,
#             }
#         )

#         today = timezone.now().date()
#         Availability.objects.create(
#             hotel=instance.hotel,
#             room_type=instance,
#             room_status=room_status,
#             availability_date=today,
#             available_rooms=instance.rooms_count,
#             notes="Initial availability created automatically.",
#         )

# from django.db.models.signals import post_save
# from datetime import timedelta

# @receiver(post_save, sender=Booking)
# def update_room_availability(sender, instance, **kwargs):
#     print("Signal triggered: Booking saved")
#     print(f"Room: {instance.room}")
#     print(f"Status ID: {instance.status.id}")

#     check_in = instance.check_in_date
#     check_out = instance.check_out_date

#     current_date = check_in
#     while current_date < check_out:  
#         availability = Availability.objects.filter(
#             room_type=instance.room.id, 
#             availability_date=current_date
#         ).first()

#         if availability:
#             if instance.status.id == 1: 
#                 if availability.available_rooms > 0:
#                     availability.available_rooms -= 1
#                     availability.save()
#                     print(f"Reduced availability for {current_date}, Remaining rooms: {availability.available_rooms}")
#                 else:
#                     print(f"No available rooms left for {current_date}")

#             elif instance.status.id == 2:  
#                 availability.available_rooms += 1
#                 availability.save()
#                 print(f"Restored availability for {current_date}, Available rooms: {availability.available_rooms}")

#         else:
#             print(f"No availability record found for {current_date}")

#         current_date += timedelta(days=1)  
