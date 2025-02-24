import os
import django
import random
from datetime import datetime, timedelta
from decimal import Decimal
import pytz

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hotels.settings')
django.setup()

from django.contrib.auth import get_user_model
from rooms.models import Room, RoomType, RoomImage
from bookings.models import Booking
from reviews.models import Review
from blog.models import Post, Category
from services.models import Service
from notifications.models import Notification
from payments.models import Payment
from users.models import Profile

User = get_user_model()

def create_users():
    # Create superuser
    if not User.objects.filter(username='admin').exists():
        User.objects.create_superuser('admin', 'admin@example.com', 'admin123')

    # Create regular users
    usernames = ['john_doe', 'jane_smith', 'mike_wilson', 'sarah_brown', 'david_clark']
    for username in usernames:
        if not User.objects.filter(username=username).exists():
            user = User.objects.create_user(
                username=username,
                email=f'{username}@example.com',
                password='password123',
                first_name=username.split('_')[0].capitalize(),
                last_name=username.split('_')[1].capitalize()
            )
            Profile.objects.create(
                user=user,
                phone_number=f'+966{random.randint(500000000, 599999999)}',
                address=f'Street {random.randint(1, 100)}, City'
            )

def create_room_types():
    types = ['Single', 'Double', 'Suite', 'Deluxe', 'Family']
    for type_name in types:
        RoomType.objects.get_or_create(
            name=type_name,
            defaults={
                'description': f'A comfortable {type_name.lower()} room',
                'price': Decimal(random.randint(200, 1000))
            }
        )

def create_rooms():
    room_types = RoomType.objects.all()
    for i in range(1, 21):
        room, created = Room.objects.get_or_create(
            room_number=f'{random.randint(1, 4)}{str(i).zfill(2)}',
            defaults={
                'room_type': random.choice(room_types),
                'capacity': random.randint(1, 4),
                'description': f'Room with city view on floor {random.randint(1, 4)}',
                'is_available': random.choice([True, True, True, False])
            }
        )
        if created:
            RoomImage.objects.create(
                room=room,
                image='room_images/default.jpg',
                is_primary=True
            )

def create_bookings():
    users = User.objects.filter(is_superuser=False)
    rooms = Room.objects.all()
    
    for _ in range(30):
        check_in = datetime.now(pytz.UTC) + timedelta(days=random.randint(-30, 30))
        check_out = check_in + timedelta(days=random.randint(1, 7))
        
        Booking.objects.create(
            user=random.choice(users),
            room=random.choice(rooms),
            check_in=check_in,
            check_out=check_out,
            guests=random.randint(1, 4),
            status=random.choice(['pending', 'confirmed', 'completed', 'cancelled']),
            total_price=Decimal(random.randint(500, 2000))
        )

def create_reviews():
    users = User.objects.filter(is_superuser=False)
    rooms = Room.objects.all()
    
    for _ in range(50):
        Review.objects.create(
            user=random.choice(users),
            room=random.choice(rooms),
            rating=random.randint(1, 5),
            comment=f'Review comment {random.randint(1, 1000)}',
            date_posted=datetime.now(pytz.UTC) - timedelta(days=random.randint(0, 90))
        )

def create_blog_posts():
    categories = ['Travel', 'Accommodation', 'Food', 'Events', 'Local Guide']
    for cat_name in categories:
        category, _ = Category.objects.get_or_create(name=cat_name)
    
    users = User.objects.filter(is_staff=True)
    if not users:
        users = [User.objects.first()]
    
    for i in range(20):
        Post.objects.create(
            title=f'Blog Post {i + 1}',
            content=f'This is the content of blog post {i + 1}. Lorem ipsum dolor sit amet.',
            author=random.choice(users),
            category=Category.objects.order_by('?').first(),
            status='published'
        )

def create_services():
    services = [
        'Room Service',
        'Spa Treatment',
        'Airport Transfer',
        'Laundry',
        'Restaurant Reservation'
    ]
    
    for service_name in services:
        Service.objects.create(
            name=service_name,
            description=f'Description for {service_name}',
            price=Decimal(random.randint(50, 300)),
            is_available=True
        )

def create_notifications():
    users = User.objects.all()
    for user in users:
        for _ in range(3):
            Notification.objects.create(
                user=user,
                title=f'Notification {random.randint(1, 100)}',
                message=f'This is a test notification message {random.randint(1, 100)}',
                is_read=random.choice([True, False])
            )

def create_payments():
    bookings = Booking.objects.all()
    for booking in bookings:
        Payment.objects.create(
            booking=booking,
            amount=booking.total_price,
            payment_method=random.choice(['credit_card', 'debit_card', 'cash']),
            status=random.choice(['pending', 'completed', 'failed']),
            transaction_id=f'TXN{random.randint(10000, 99999)}'
        )

def populate_database():
    print("Creating users...")
    create_users()
    
    print("Creating room types...")
    create_room_types()
    
    print("Creating rooms...")
    create_rooms()
    
    print("Creating bookings...")
    create_bookings()
    
    print("Creating reviews...")
    create_reviews()
    
    print("Creating blog posts...")
    create_blog_posts()
    
    print("Creating services...")
    create_services()
    
    print("Creating notifications...")
    create_notifications()
    
    print("Creating payments...")
    create_payments()
    
    print("Database population completed!")

if __name__ == '__main__':
    populate_database()
