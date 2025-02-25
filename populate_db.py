import os
import random
from decimal import Decimal
from datetime import timedelta

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hotels.settings')

import django
django.setup()

# Now we can import Django models
from django.utils import timezone
from django.utils.text import slugify
from django.contrib.auth import get_user_model

from users.models import CustomUser
from HotelManagement.models import Hotel, Image, Location, City
from rooms.models import (
    Category, RoomType, RoomPrice, RoomImage,
    RoomStatus, Availability, Review
)
from payments.models import (
    Currency, PaymentOption, HotelPaymentMethod, Payment
)

User = get_user_model()

def create_users():
    """Create users with different roles"""
    print("\nCreating users...")
    users_data = [
        {
            'username': 'admin',
            'email': 'admin@example.com',
            'password': 'admin123',
            'first_name': 'Admin',
            'last_name': 'User',
            'user_type': 'admin',
            'phone': '0500000000'
        },
        {
            'username': 'manager1',
            'email': 'manager1@example.com',
            'password': 'manager123',
            'first_name': 'Hotel',
            'last_name': 'Manager 1',
            'user_type': 'hotel_manager',
            'phone': '0511111111'
        },
        {
            'username': 'manager2',
            'email': 'manager2@example.com',
            'password': 'manager123',
            'first_name': 'Hotel',
            'last_name': 'Manager 2',
            'user_type': 'hotel_manager',
            'phone': '0522222222'
        },
        {
            'username': 'customer1',
            'email': 'customer1@example.com',
            'password': 'customer123',
            'first_name': 'Customer',
            'last_name': 'One',
            'user_type': 'customer',
            'phone': '0533333333'
        },
        {
            'username': 'staff1',
            'email': 'staff1@example.com',
            'password': 'staff123',
            'first_name': 'Staff',
            'last_name': 'One',
            'user_type': 'staff',
            'phone': '0544444444'
        }
    ]
    
    for user_data in users_data:
        try:
            user, created = User.objects.get_or_create(
                username=user_data['username'],
                defaults={
                    'email': user_data['email'],
                    'first_name': user_data['first_name'],
                    'last_name': user_data['last_name'],
                    'user_type': user_data['user_type'],
                    'phone': user_data['phone']
                }
            )
            if created:
                user.set_password(user_data['password'])
                user.save()
                print(f"Created user: {user.username} ({user.user_type})")
        except Exception as e:
            print(f"Error creating user {user_data['username']}: {str(e)}")

def create_cities():
    """Create cities and locations"""
    print("\nCreating cities and locations...")
    cities_data = [
        {
            'state': 'الرياض',
            'country': 'المملكة العربية السعودية',
            'address': 'وسط مدينة الرياض'
        },
        {
            'state': 'جدة',
            'country': 'المملكة العربية السعودية',
            'address': 'كورنيش جدة'
        },
        {
            'state': 'مكة المكرمة',
            'country': 'المملكة العربية السعودية',
            'address': 'العزيزية'
        },
        {
            'state': 'المدينة المنورة',
            'country': 'المملكة العربية السعودية',
            'address': 'المنطقة المركزية'
        },
        {
            'state': 'الدمام',
            'country': 'المملكة العربية السعودية',
            'address': 'الكورنيش'
        }
    ]
    
    for city_data in cities_data:
        try:
            # Create city first
            city, created = City.objects.get_or_create(
                state=city_data['state'],
                defaults={
                    'country': city_data['country'],
                    'slug': slugify(city_data['state'])
                }
            )
            if created:
                print(f"Created city: {city.state}")
            
            # Then create location
            location, created = Location.objects.get_or_create(
                city=city,
                address=city_data['address']
            )
            if created:
                print(f"Created location for {city.state}: {location.address}")
            
        except Exception as e:
            print(f"Error creating city {city_data['state']}: {str(e)}")

def reset_hotel_managers():
    """Reset all hotel manager assignments to ensure clean state"""
    try:
        Hotel.objects.update(manager=None)
        print("Reset all hotel manager assignments")
    except Exception as e:
        print(f"Error resetting hotel managers: {str(e)}")

def create_hotels():
    # Get list of hotel images from media folder
    hotel_images = [f for f in os.listdir('media/hotels/images') if f.endswith(('.jpg', '.jpeg', '.png'))] if os.path.exists('media/hotels/images') else []
    
    hotels = [
        {'name': 'Grand Hotel', 'name_en': 'Grand Hotel'},
        {'name': 'فندق الفخامة', 'name_en': 'Luxury Resort'},
        {'name': 'فندق الأعمال', 'name_en': 'Business Inn'},
        {'name': 'فندق العائلة', 'name_en': 'Family Stay'},
        {'name': 'منتجع الشاطئ', 'name_en': 'Beach Resort'}
    ]
    
    locations = Location.objects.all()
    if not locations.exists():
        create_cities()
        locations = Location.objects.all()
    
    # Get available hotel managers that are not already assigned to a hotel
    available_managers = list(User.objects.filter(
        user_type='hotel_manager',
        hotel__isnull=True  # Only get managers not already assigned to a hotel
    ))
    
    if not available_managers:
        print("Warning: No available hotel managers found. Creating hotels without managers.")
    
    for hotel_data in hotels:
        try:
            # Get a manager if available
            manager = None
            if available_managers:
                manager = available_managers.pop(0)  # Take the first available manager
            
            hotel, created = Hotel.objects.get_or_create(
                name=hotel_data['name'],
                defaults={
                    'location': random.choice(locations),
                    'description': f'A wonderful {hotel_data["name_en"].lower()} experience',
                    'is_verified': True,
                    'verification_date': timezone.now(),
                    'slug': slugify(hotel_data['name_en']),
                    'manager': manager
                }
            )
            
            if created:
                print(f"Created hotel: {hotel.name}")
                if manager:
                    print(f"Assigned manager: {manager.username}")
                else:
                    print("No manager assigned")
                
                if hotel_images:
                    # Set profile picture
                    profile_pic = random.choice(hotel_images)
                    hotel.profile_picture = f'hotels/images/{profile_pic}'
                    hotel.save()
                    
                    # Add additional images
                    for _ in range(3):  # Add 3 additional images
                        if hotel_images:
                            image_name = random.choice(hotel_images)
                            Image.objects.create(
                                hotel=hotel,
                                image_path=f'hotels/images/{image_name}'
                            )
        except Exception as e:
            print(f"Error creating hotel {hotel_data['name']}: {str(e)}")

def create_room_types():
    """Create room types for each hotel"""
    print("\nCreating room types...")
    room_types = [
        {
            'name': 'غرفة مفردة',
            'name_en': 'Single Room',
            'default_capacity': 1,
            'max_capacity': 2,
            'beds_count': 1,
            'base_price': 100.00
        },
        {
            'name': 'غرفة مزدوجة',
            'name_en': 'Double Room',
            'default_capacity': 2,
            'max_capacity': 3,
            'beds_count': 1,
            'base_price': 150.00
        },
        {
            'name': 'جناح',
            'name_en': 'Suite',
            'default_capacity': 2,
            'max_capacity': 4,
            'beds_count': 2,
            'base_price': 300.00
        },
        {
            'name': 'غرفة فاخرة',
            'name_en': 'Luxury Room',
            'default_capacity': 2,
            'max_capacity': 3,
            'beds_count': 1,
            'base_price': 250.00
        },
        {
            'name': 'غرفة عائلية',
            'name_en': 'Family Room',
            'default_capacity': 4,
            'max_capacity': 6,
            'beds_count': 2,
            'base_price': 400.00
        }
    ]
    
    hotels = Hotel.objects.all()
    room_images = [f for f in os.listdir('media/room_images') if f.endswith(('.jpg', '.jpeg', '.png'))] if os.path.exists('media/room_images') else []
    
    for hotel in hotels:
        print(f"\nCreating room types for hotel: {hotel.name}")
        # Create a default category for the hotel if it doesn't exist
        category, created = Category.objects.get_or_create(
            hotel=hotel,
            name='Default',
            defaults={'description': 'Default room category'}
        )
        if created:
            print(f"Created default category for {hotel.name}")
        
        for room_type_data in room_types:
            try:
                # Create room type
                room_type, created = RoomType.objects.get_or_create(
                    hotel=hotel,
                    name=room_type_data['name'],
                    defaults={
                        'category': category,
                        'description': f"A comfortable {room_type_data['name_en'].lower()}",
                        'default_capacity': room_type_data['default_capacity'],
                        'max_capacity': room_type_data['max_capacity'],
                        'beds_count': room_type_data['beds_count'],
                        'rooms_count': random.randint(5, 20),  # Random number of rooms
                        'base_price': room_type_data['base_price']
                    }
                )
                
                if created:
                    print(f"Created room type: {room_type.name}")
                    # Create room price for this type
                    price = RoomPrice.objects.create(
                        hotel=hotel,
                        room_type=room_type,
                        date_from=timezone.now().date(),
                        date_to=timezone.now().date() + timedelta(days=365),
                        price=room_type_data['base_price'],
                        is_special_offer=False
                    )
                    print(f"Created price for {room_type.name}: {price.price} SAR")
                    
                    # Add room images if available
                    if room_images:
                        for i in range(min(3, len(room_images))):  # Add up to 3 images
                            image_name = random.choice(room_images)
                            is_main = (i == 0)  # First image is main
                            RoomImage.objects.create(
                                hotel=hotel,
                                room_type=room_type,
                                image=f'room_images/{image_name}',
                                is_main=is_main,
                                caption=f"{room_type_data['name_en']} - Image {i+1}"
                            )
                        print(f"Added {min(3, len(room_images))} images to {room_type.name}")
                
            except Exception as e:
                print(f"Error creating room type {room_type_data['name']} for hotel {hotel.name}: {str(e)}")

def create_room_statuses():
    """Create room statuses for each hotel"""
    statuses = [
        {
            'code': 'available',
            'name': 'متاح',
            'name_en': 'Available',
            'description': 'الغرفة متاحة للحجز',
            'is_available': True
        },
        {
            'code': 'occupied',
            'name': 'مشغولة',
            'name_en': 'Occupied',
            'description': 'الغرفة مشغولة حالياً',
            'is_available': False
        },
        {
            'code': 'maintenance',
            'name': 'صيانة',
            'name_en': 'Under Maintenance',
            'description': 'الغرفة تحت الصيانة',
            'is_available': False
        },
        {
            'code': 'cleaning',
            'name': 'تنظيف',
            'name_en': 'Cleaning',
            'description': 'الغرفة قيد التنظيف',
            'is_available': False
        }
    ]
    
    hotels = Hotel.objects.all()
    for hotel in hotels:
        for status in statuses:
            try:
                RoomStatus.objects.get_or_create(
                    hotel=hotel,
                    code=status['code'],
                    defaults={
                        'name': status['name'],
                        'description': status['description'],
                        'is_available': status['is_available']
                    }
                )
            except Exception as e:
                print(f"Error creating room status {status['name']} for hotel {hotel.name}: {str(e)}")

def create_availabilities():
    """Create room availabilities for the next 30 days"""
    hotels = Hotel.objects.all()
    today = timezone.now().date()
    
    for hotel in hotels:
        # Get available status
        available_status = RoomStatus.objects.filter(hotel=hotel, code='available').first()
        if not available_status:
            print(f"No available status found for hotel {hotel.name}")
            continue
            
        room_types = RoomType.objects.filter(hotel=hotel)
        for room_type in room_types:
            total_rooms = room_type.rooms_count
            
            # Create availability records for next 30 days
            for day in range(30):
                date = today + timedelta(days=day)
                try:
                    # Randomly make some rooms unavailable
                    available_rooms = max(0, total_rooms - random.randint(0, 3))
                    
                    Availability.objects.get_or_create(
                        hotel=hotel,
                        room_type=room_type,
                        room_status=available_status,
                        availability_date=date,
                        defaults={
                            'available_rooms': available_rooms,
                            'notes': f'Automatically generated for {date}'
                        }
                    )
                except Exception as e:
                    print(f"Error creating availability for {room_type.name} on {date}: {str(e)}")

def create_reviews():
    """Create sample reviews for room types"""
    hotels = Hotel.objects.all()
    customers = CustomUser.objects.filter(user_type='customer')
    
    if not customers:
        print("No customers found to create reviews")
        return
        
    review_texts = [
        "غرفة رائعة وخدمة ممتازة",
        "تجربة جميلة، سأعود مرة أخرى",
        "نظيفة ومريحة جداً",
        "موقع ممتاز وطاقم ودود",
        "تجربة لا تنسى",
        "الغرفة كانت أكبر من المتوقع",
        "سعر معقول مقابل الخدمة",
        "تجربة مميزة"
    ]
    
    for hotel in hotels:
        room_types = RoomType.objects.filter(hotel=hotel)
        for room_type in room_types:
            # Create 3-5 reviews for each room type
            for _ in range(random.randint(3, 5)):
                try:
                    Review.objects.create(
                        hotel=hotel,
                        room_type=room_type,
                        user=random.choice(customers),
                        rating=random.randint(4, 5),  # Mostly positive reviews
                        content=random.choice(review_texts)
                    )
                except Exception as e:
                    print(f"Error creating review for {room_type.name}: {str(e)}")

def create_currencies():
    """Create currencies for each hotel"""
    print("\nCreating currencies...")
    currencies_data = [
        {
            'name': 'ريال سعودي',
            'symbol': 'SAR'
        },
        {
            'name': 'دولار أمريكي',
            'symbol': 'USD'
        }
    ]
    
    hotels = Hotel.objects.all()
    for hotel in hotels:
        for currency_data in currencies_data:
            try:
                currency, created = Currency.objects.get_or_create(
                    hotel=hotel,
                    currency_name=currency_data['name'],
                    defaults={
                        'currency_symbol': currency_data['symbol']
                    }
                )
                if created:
                    print(f"Created currency {currency.currency_name} for {hotel.name}")
            except Exception as e:
                print(f"Error creating currency {currency_data['name']} for {hotel.name}: {str(e)}")

def create_payment_options():
    """Create payment options"""
    print("\nCreating payment options...")
    payment_options_data = [
        {
            'name': 'بطاقة ائتمان',
            'logo': 'payment_logos/credit_card.png'
        },
        {
            'name': 'Apple Pay',
            'logo': 'payment_logos/apple_pay.png'
        },
        {
            'name': 'تحويل بنكي',
            'logo': 'payment_logos/bank_transfer.png'
        },
        {
            'name': 'نقداً',
            'logo': 'payment_logos/cash.png'
        }
    ]
    
    currencies = Currency.objects.all()
    for currency in currencies:
        for option_data in payment_options_data:
            try:
                payment_option, created = PaymentOption.objects.get_or_create(
                    method_name=option_data['name'],
                    currency=currency,
                    defaults={
                        'logo': option_data['logo'],
                        'is_active': True
                    }
                )
                if created:
                    print(f"Created payment option {payment_option.method_name} for {currency.currency_name}")
            except Exception as e:
                print(f"Error creating payment option {option_data['name']}: {str(e)}")

def create_hotel_payment_methods():
    """Create hotel payment methods"""
    print("\nCreating hotel payment methods...")
    hotels = Hotel.objects.all()
    payment_options = PaymentOption.objects.all()
    
    for hotel in hotels:
        print(f"\nSetting up payment methods for {hotel.name}")
        for payment_option in payment_options:
            try:
                method, created = HotelPaymentMethod.objects.get_or_create(
                    hotel=hotel,
                    payment_option=payment_option,
                    defaults={
                        'account_name': f"{hotel.name} Account",
                        'account_number': f"{random.randint(1000000000, 9999999999)}",
                        'iban': f"SA{random.randint(10000000000000000000, 99999999999999999999)}",
                        'description': f"Payment instructions for {payment_option.method_name}",
                        'is_active': True
                    }
                )
                if created:
                    print(f"Created payment method {payment_option.method_name} for {hotel.name}")
            except Exception as e:
                print(f"Error creating hotel payment method for {hotel.name}: {str(e)}")

def populate_database():
    """Populate database with sample data"""
    print("\nStarting database population...")
    
    create_cities()
    create_users()
    create_hotels()
    create_room_types()
    create_room_statuses()
    create_availabilities()
    create_reviews()
    create_currencies()
    create_payment_options()
    create_hotel_payment_methods()
    
    print("\nDatabase population completed successfully!")

if __name__ == '__main__':
    populate_database()
