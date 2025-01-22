from django.core.management.base import BaseCommand
from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from HotelManagement.models import Hotel
from rooms.models import RoomType
from bookings.models import Booking,BookingDetail,Guest,BookingStatus
from reviews.models import Review
from services.models import Offer,Service
from payments.models import Currency,Payment,PaymentOption

class Command(BaseCommand):
    help = 'Sets up permissions for hotel managers'

    def handle(self, *args, **options):
        # Create hotel managers group if it doesn't exist
        hotel_managers_group, created = Group.objects.get_or_create(name='Hotel Managers')
        
        # Define the models and their permissions that hotel managers should have
        models_permissions = {
            Hotel: ['add', 'change', 'view', 'delete'],
            RoomType: ['add', 'change', 'view', 'delete'],
            Booking: ['view', 'change'],
            Review: ['view'],
            Offer:['add', 'change', 'view', 'delete'],
            Service:['add', 'change', 'view', 'delete'],
            BookingDetail:['add', 'change', 'view', 'delete'],
            Guest:['add', 'change', 'view', 'delete'],
            BookingStatus:['add', 'change', 'view', 'delete'],
            Currency:['add', 'change', 'view', 'delete'],
            Payment:['add', 'change', 'view', 'delete'],
            PaymentOption:['add', 'change', 'view', 'delete'],


            
        }

        # Create and assign permissions
        permissions_to_add = []
        for model, actions in models_permissions.items():
            content_type = ContentType.objects.get_for_model(model)
            for action in actions:
                codename = f'{action}_{model._meta.model_name}'
                try:
                    permission = Permission.objects.get(
                        codename=codename,
                        content_type=content_type,
                    )
                    permissions_to_add.append(permission)
                except Permission.DoesNotExist:
                    self.stdout.write(self.style.WARNING(
                        f'Permission {codename} does not exist'
                    ))

        # Add permissions to the group
        hotel_managers_group.permissions.set(permissions_to_add)
        
        self.stdout.write(self.style.SUCCESS(
            f'Successfully set up permissions for Hotel Managers group'
        ))
