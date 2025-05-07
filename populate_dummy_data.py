import os
import sys
import django
import random
from datetime import datetime, timedelta
from decimal import Decimal

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'HotelManagement.settings')
django.setup()

# Import models after Django setup
from django.contrib.auth import get_user_model
from django.utils import timezone
from HotelManagement.models import City, Location, Hotel, Phone, Image
from rooms.models import Category, RoomType, RoomPrice, Availability, RoomImage
from bookings.models import Booking, Guest, BookingDetail
from services.models import Service, RoomTypeService
from users.models import CustomUser

User = get_user_model()

def create_users(num_users=5):
    """Create dummy users"""
    print("Creating users...")
    users = []
    for i in range(1, num_users + 1):
        username = f"user{i}"
        email = f"user{i}@example.com"
        
        # Skip if user already exists
        if User.objects.filter(username=username).exists():
            users.append(User.objects.get(username=username))
            continue
            
        user = User.objects.create_user(
            username=username,
            email=email,
            password="password123",
            first_name=f"First{i}",
            last_name=f"Last{i}",
            user_type="customer" if i < num_users else "hotel_manager"
        )
        users.append(user)
    
    # Create admin user if it doesn't exist
    if not User.objects.filter(username="admin").exists():
        User.objects.create_superuser(
            username="admin",
            email="admin@example.com",
            password="admin123",
            first_name="Admin",
            last_name="User",
            user_type="admin"
        )
    
    return users

def create_cities(num_cities=3):
    """Create dummy cities"""
    print("Creating cities...")
    cities = []
    city_data = [
        {"state": "الرياض", "country": "السعودية"},
        {"state": "جدة", "country": "السعودية"},
        {"state": "مكة المكرمة", "country": "السعودية"},
        {"state": "المدينة المنورة", "country": "السعودية"},
        {"state": "الدمام", "country": "السعودية"},
    ]
    
    for i in range(min(num_cities, len(city_data))):
        city_info = city_data[i]
        city, created = City.objects.get_or_create(
            state=city_info["state"],
            country=city_info["country"],
            defaults={
                "slug": f"{city_info['state']}-{city_info['country']}".lower().replace(" ", "-")
            }
        )
        cities.append(city)
    
    return cities

def create_locations(cities, num_locations=5):
    """Create dummy locations"""
    print("Creating locations...")
    locations = []
    addresses = [
        "شارع الملك فهد",
        "شارع الأمير محمد بن سلمان",
        "شارع العليا",
        "شارع التحلية",
        "شارع الملك عبدالله",
        "شارع الستين",
        "شارع الملك خالد",
    ]
    
    for i in range(min(num_locations, len(addresses))):
        city = random.choice(cities)
        location, created = Location.objects.get_or_create(
            address=addresses[i],
            city=city
        )
        locations.append(location)
    
    return locations

def create_hotels(locations, users, num_hotels=3):
    """Create dummy hotels"""
    print("Creating hotels...")
    hotels = []
    hotel_names = [
        "فندق الريتز كارلتون",
        "فندق الفورسيزونز",
        "فندق الماريوت",
        "فندق هيلتون",
        "فندق شيراتون",
    ]
    
    for i in range(min(num_hotels, len(hotel_names))):
        location = locations[i % len(locations)]
        manager = users[-1]  # Use the last user as manager
        
        hotel, created = Hotel.objects.get_or_create(
            name=hotel_names[i],
            location=location,
            defaults={
                "slug": hotel_names[i].lower().replace(" ", "-"),
                "description": f"وصف فندق {hotel_names[i]} الفاخر",
                "manager": manager,
                "created_by": manager
            }
        )
        
        # Add phone number if it doesn't exist
        if not Phone.objects.filter(hotel=hotel).exists():
            Phone.objects.create(
                hotel=hotel,
                country_code="+966",
                phone_number=f"5{random.randint(10000000, 99999999)}",
                created_by=manager
            )
        
        hotels.append(hotel)
    
    return hotels

def create_categories(num_categories=3):
    """Create room categories"""
    print("Creating room categories...")
    categories = []
    category_names = ["فاخرة", "عائلية", "اقتصادية", "جناح", "ديلوكس"]
    
    for i in range(min(num_categories, len(category_names))):
        category, created = Category.objects.get_or_create(
            name=category_names[i],
            defaults={
                "description": f"غرف {category_names[i]} مريحة ومجهزة بالكامل",
                "status": True
            }
        )
        categories.append(category)
    
    return categories

def create_room_types(hotels, categories, num_room_types_per_hotel=2):
    """Create room types for each hotel"""
    print("Creating room types...")
    room_types = []
    
    for hotel in hotels:
        for i in range(num_room_types_per_hotel):
            category = categories[i % len(categories)]
            name = f"غرفة {category.name} {i+1}"
            
            room_type, created = RoomType.objects.get_or_create(
                hotel=hotel,
                name=name,
                category=category,
                defaults={
                    "description": f"وصف {name}",
                    "default_capacity": random.randint(1, 3),
                    "max_capacity": random.randint(3, 5),
                    "beds_count": random.randint(1, 3),
                    "rooms_count": random.randint(5, 20),
                    "base_price": Decimal(random.randint(300, 1500)),
                    "is_active": True
                }
            )
            
            # Create room image if it doesn't exist
            if not RoomImage.objects.filter(room_type=room_type).exists():
                RoomImage.objects.create(
                    hotel=hotel,
                    room_type=room_type,
                    image_url=f"https://placehold.co/600x400?text={name}",
                    is_main=True,
                    caption=f"صورة {name}"
                )
            
            room_types.append(room_type)
    
    return room_types

def create_room_prices(room_types):
    """Create price entries for room types"""
    print("Creating room prices...")
    today = timezone.now().date()
    
    for room_type in room_types:
        # Create regular price
        RoomPrice.objects.get_or_create(
            hotel=room_type.hotel,
            room_type=room_type,
            date_from=today,
            date_to=today + timedelta(days=90),
            defaults={
                "price": room_type.base_price,
                "is_special_offer": False
            }
        )
        
        # Create special weekend price
        RoomPrice.objects.get_or_create(
            hotel=room_type.hotel,
            room_type=room_type,
            date_from=today + timedelta(days=3),
            date_to=today + timedelta(days=5),
            defaults={
                "price": room_type.base_price * Decimal('1.2'),
                "is_special_offer": True
            }
        )

def create_availabilities(room_types):
    """Create availability entries for room types"""
    print("Creating availabilities...")
    today = timezone.now().date()
    
    for room_type in room_types:
        for day in range(30):  # Create availability for next 30 days
            date = today + timedelta(days=day)
            
            # Vary availability to simulate some busy days
            if day % 7 in [5, 6]:  # Weekends have fewer rooms
                available_rooms = max(1, room_type.rooms_count - random.randint(3, 5))
            else:
                available_rooms = max(1, room_type.rooms_count - random.randint(0, 3))
            
            Availability.objects.get_or_create(
                hotel=room_type.hotel,
                room_type=room_type,
                availability_date=date,
                defaults={
                    "available_rooms": available_rooms,
                    "notes": "تم تحديث التوفر تلقائيًا" if day == 0 else ""
                }
            )

def create_services(num_services=5):
    """Create hotel services"""
    print("Creating services...")
    services = []
    service_names = [
        "خدمة الغرف",
        "إفطار",
        "واي فاي",
        "موقف سيارات",
        "مسبح",
        "صالة رياضية",
        "سبا",
        "نقل من وإلى المطار"
    ]
    
    for i in range(min(num_services, len(service_names))):
        service, created = Service.objects.get_or_create(
            name=service_names[i],
            defaults={
                "description": f"وصف خدمة {service_names[i]}",
                "price": Decimal(random.randint(50, 300)),
                "is_active": True
            }
        )
        services.append(service)
    
    return services

def create_room_services(room_types, services):
    """Assign services to room types"""
    print("Creating room services...")
    
    for room_type in room_types:
        # Assign 2-3 random services to each room type
        num_services = random.randint(2, min(3, len(services)))
        selected_services = random.sample(services, num_services)
        
        for service in selected_services:
            RoomTypeService.objects.get_or_create(
                room_type=room_type,
                service=service,
                defaults={
                    "price": service.price * Decimal('0.9'),  # 10% discount for room package
                    "is_included": random.choice([True, False])
                }
            )

def create_bookings(room_types, users, num_bookings=10):
    """Create dummy bookings"""
    print("Creating bookings...")
    today = timezone.now()
    
    for i in range(num_bookings):
        # Select a random room type and user
        room_type = random.choice(room_types)
        user = random.choice(users[:-1])  # Exclude the manager
        
        # Generate random dates
        days_offset = random.randint(-5, 20)  # Some bookings in the past, some in future
        check_in_date = today + timedelta(days=days_offset)
        duration = random.randint(1, 7)
        check_out_date = check_in_date + timedelta(days=duration)
        
        # Calculate amount based on duration and room price
        base_price = room_type.base_price
        amount = base_price * Decimal(duration)
        
        # Determine booking status
        if days_offset < 0:
            # Past bookings are either confirmed or canceled
            status = random.choice([Booking.BookingStatus.CONFIRMED, Booking.BookingStatus.CANCELED])
            if status == Booking.BookingStatus.CONFIRMED:
                actual_check_out_date = check_out_date
            else:
                actual_check_out_date = None
        elif days_offset == 0:
            # Today's bookings are confirmed
            status = Booking.BookingStatus.CONFIRMED
            actual_check_out_date = None
        else:
            # Future bookings are pending or confirmed
            status = random.choice([Booking.BookingStatus.PENDING, Booking.BookingStatus.CONFIRMED])
            actual_check_out_date = None
        
        # Create booking
        booking = Booking.objects.create(
            hotel=room_type.hotel,
            user=user,
            room=room_type,
            check_in_date=check_in_date,
            check_out_date=check_out_date,
            actual_check_out_date=actual_check_out_date,
            amount=amount,
            status=status,
            account_status=True,
            rooms_booked=random.randint(1, 2),
            created_by=user
        )
        
        # Create guest for booking
        Guest.objects.create(
            hotel=room_type.hotel,
            booking=booking,
            name=f"{user.first_name} {user.last_name}",
            phone_number=f"5{random.randint(10000000, 99999999)}",
            gender=random.choice(['male', 'female']),
            check_in_date=check_in_date,
            check_out_date=check_out_date,
            created_by=user
        )
        
        # Add booking details if room has services
        room_services = RoomTypeService.objects.filter(room_type=room_type)
        if room_services.exists():
            # Add 1-2 services to booking
            for service in room_services[:min(2, room_services.count())]:
                BookingDetail.objects.create(
                    booking=booking,
                    hotel=room_type.hotel,
                    service=service.service,
                    price=service.price,
                    created_by=user
                )

def main():
    """Main function to populate the database with dummy data"""
    print("Starting to populate database with dummy data...")
    
    # Create basic data
    users = create_users(6)
    cities = create_cities(3)
    locations = create_locations(cities, 5)
    hotels = create_hotels(locations, users, 3)
    
    # Create room-related data
    categories = create_categories(3)
    room_types = create_room_types(hotels, categories, 2)
    create_room_prices(room_types)
    create_availabilities(room_types)
    
    # Create services
    services = create_services(5)
    create_room_services(room_types, services)
    
    # Create bookings
    create_bookings(room_types, users, 15)
    
    print("Successfully populated database with dummy data!")

if __name__ == "__main__":
    main()
