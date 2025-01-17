import os
import django
import random
from datetime import datetime, timedelta
from django.utils import timezone

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hotels.settings')
django.setup()

from faker import Faker
from django.contrib.auth import get_user_model
from HotelManagement.models import City, Location, Hotel, Phone
from rooms.models import Category, RoomType, RoomStatus, Availability
from bookings.models import BookingStatus, Booking, Guest

fake = Faker(['ar_SA', 'en_US'])
User = get_user_model()

def create_users(num_users=10):
    users = []
    for _ in range(num_users):
        user = User.objects.create_user(
            username=fake.user_name(),
            email=fake.email(),
            password='password123',
            first_name=fake.first_name(),
            last_name=fake.last_name()
        )
        users.append(user)
    return users

def create_cities(num_cities=5):
    cities = []
    for _ in range(num_cities):
        city = City.objects.create(
            name=fake.city(),
            state=fake.state(),
            country="المملكة العربية السعودية"
        )
        cities.append(city)
    return cities

def create_locations(cities, num_locations=10):
    locations = []
    for _ in range(num_locations):
        location = Location.objects.create(
            name=fake.street_name(),
            address=fake.street_address(),
            city=random.choice(cities)
        )
        locations.append(location)
    return locations

def create_hotels(locations, users, num_hotels=5):
    hotels = []
    for _ in range(num_hotels):
        hotel = Hotel.objects.create(
            location=random.choice(locations),
            name=f"فندق {fake.company()}",
            email=fake.company_email(),
            description=fake.text(max_nb_chars=500),
            is_verified=random.choice([True, False]),
            created_by=random.choice(users)
        )
        
        # Create phone numbers for each hotel
        for _ in range(random.randint(1, 3)):
            Phone.objects.create(
                hotel=hotel,
                country_code="+966",
                phone_number=fake.numerify(text='#########')
            )
        hotels.append(hotel)
    return hotels

def create_room_categories(hotels):
    categories = []
    category_names = ["عادية", "ديلوكس", "جناح", "جناح تنفيذي", "جناح رئاسي"]
    for hotel in hotels:
        for name in category_names:
            category = Category.objects.create(
                hotel=hotel,
                name=name
            )
            categories.append(category)
    return categories

def create_room_types(categories):
    room_types = []
    for category in categories:
        room_type = RoomType.objects.create(
            hotel=category.hotel,
            category=category,
            name=f"غرفة {category.name}",
            description=fake.text(max_nb_chars=200),
            default_capacity=random.randint(1, 4),
            max_capacity=random.randint(4, 6),
            beds_count=random.randint(1, 3),
            rooms_count=random.randint(5, 20),
            base_price=random.randint(300, 2000),
            is_active=True
        )
        room_types.append(room_type)
    return room_types

def create_room_status(hotels):
    statuses = []
    status_choices = [
        ("متاح", "غرفة متاحة للحجز", True),
        ("محجوز", "غرفة محجوزة", False),
        ("صيانة", "غرفة تحت الصيانة", False),
        ("تنظيف", "غرفة قيد التنظيف", False)
    ]
    
    for hotel in hotels:
        for code, desc, is_available in status_choices:
            status = RoomStatus.objects.create(
                hotel=hotel,
                code=code,
                name=code,
                description=desc,
                is_available=is_available
            )
            statuses.append(status)
    return statuses

def create_booking_status():
    statuses = []
    status_choices = [
        ("معلق", 1),
        ("مؤكد", 2),
        ("ملغي", 3),
        ("مكتمل", 4)
    ]
    for name, code in status_choices:
        status = BookingStatus.objects.create(
            booking_status_name=name,
            status_code=code
        )
        statuses.append(status)
    return statuses

def create_guest(booking, hotel):
    guest = Guest.objects.create(
        hotel=hotel,
        name=fake.name(),
        phone_number=fake.numerify(text='+966#########'),
        id_card_number=fake.numerify(text='##########'),
        booking=booking,
        created_by=booking.created_by
    )
    return guest

def create_bookings(hotels, users, room_types, booking_statuses, num_bookings=20):
    bookings = []
    for _ in range(num_bookings):
        hotel = random.choice(hotels)
        user = random.choice(users)
        room_type = random.choice([rt for rt in room_types if rt.hotel == hotel])
        check_in = timezone.now() + timedelta(days=random.randint(-30, 30))
        check_out = check_in + timedelta(days=random.randint(1, 7))
        
        # Create booking first
        booking = Booking.objects.create(
            hotel=hotel,
            user=user,
            room=room_type,
            check_in_date=check_in,
            check_out_date=check_out,
            amount=random.randint(500, 5000),
            status=random.choice(booking_statuses),
            created_by=user
        )
        
        # Create guest for the booking after saving
        guest = Guest.objects.create(
            hotel=hotel,
            name=fake.name(),
            phone_number=fake.numerify(text='+966#########'),
            id_card_number=fake.numerify(text='##########'),
            booking=booking,
            created_by=user
        )
        
        bookings.append(booking)
    return bookings

def main():
    print("بدء إنشاء البيانات الوهمية...")
    
    # Create basic data
    users = create_users()
    print("✓ تم إنشاء المستخدمين")
    
    cities = create_cities()
    print("✓ تم إنشاء المدن")
    
    locations = create_locations(cities)
    print("✓ تم إنشاء المواقع")
    
    hotels = create_hotels(locations, users)
    print("✓ تم إنشاء الفنادق")
    
    # Create room-related data
    categories = create_room_categories(hotels)
    print("✓ تم إنشاء تصنيفات الغرف")
    
    room_types = create_room_types(categories)
    print("✓ تم إنشاء أنواع الغرف")
    
    room_statuses = create_room_status(hotels)
    print("✓ تم إنشاء حالات الغرف")
    
    # Create booking-related data
    booking_statuses = create_booking_status()
    print("✓ تم إنشاء حالات الحجز")
    
    bookings = create_bookings(hotels, users, room_types, booking_statuses)
    print("✓ تم إنشاء الحجوزات")
    
    print("\nتم إنشاء جميع البيانات الوهمية بنجاح!")

if __name__ == "__main__":
    main()
