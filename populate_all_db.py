import os
import django
import random
from datetime import datetime, timedelta
from decimal import Decimal
import pytz
from django.utils import timezone

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hotels.settings')
import django
django.setup()

from django.contrib.auth import get_user_model
from rooms.models import Category, RoomType, RoomPrice, RoomStatus, Availability, RoomImage, Review
from blog.models import Post, Category as BlogCategory
from services.models import HotelService
from notifications.models import Notifications
from payments.models import Payment, Currency, PaymentOption, HotelPaymentMethod
from HotelManagement.models import City, Location, Hotel, Phone, Image, HotelRequest
from django.core.files import File
from django.core.files.base import ContentFile
from bookings.models import Booking

User = get_user_model()

def create_users():
    # Create superuser
    if not User.objects.filter(username='admin').exists():
        User.objects.create_superuser('admin', 'admin@example.com', 'admin123')

    # Create hotel managers
    manager_usernames = ['manager1', 'manager2', 'manager3', 'manager4', 'manager5']  
    for username in manager_usernames:
        if not User.objects.filter(username=username).exists():
            User.objects.create_user(
                username=username,
                email=f'{username}@example.com',
                password='password123',
                first_name=f'{username}_first',
                last_name=f'{username}_last',
                user_type='hotel_manager'
            )

    # Create regular users
    usernames = ['john_doe', 'jane_smith', 'mike_wilson', 'sarah_brown', 'david_clark']
    for username in usernames:
        if not User.objects.filter(username=username).exists():
            User.objects.create_user(
                username=username,
                email=f'{username}@example.com',
                password='password123',
                first_name=username.split('_')[0].capitalize(),
                last_name=username.split('_')[1].capitalize()
            )

def create_hotel_management_data():
    # Create cities
    cities = ['الرياض', 'جدة', 'الدمام', 'مكة', 'المدينة']
    managers = User.objects.filter(user_type='hotel_manager')
    
    for i, city_name in enumerate(cities):
        city = City.objects.create(
            state='المنطقة الوسطى',
            country='المملكة العربية السعودية',
            slug=f'{city_name}-city'
        )
        
        # Create location for each city
        location = Location.objects.create(
            address=f'شارع الملك فهد، {city_name}',
            city=city
        )
        
        # Create hotel for each location with a unique manager
        hotel = Hotel.objects.create(
            location=location,
            name=f'فندق {city_name} الفاخر',
            slug=f'hotel-{city_name}',
            description=f'فندق فاخر في {city_name}',
            business_license_number=f'LIC{random.randint(1000, 9999)}',
            is_verified=True,
            verification_date=datetime.now(pytz.UTC),
            manager=managers[i]  
        )
        
        # Create phone numbers for hotel
        Phone.objects.create(
            phone_number=f'{random.randint(5000000, 5999999)}',
            country_code='+966',
            hotel=hotel
        )
        
        # Create images for hotel
        Image.objects.create(
            image_url=f'https://example.com/hotel_{city_name}.jpg',
            hotel=hotel
        )

def create_room_categories_and_types():
    hotels = Hotel.objects.all()
    
    for hotel in hotels:
        # Create room categories
        categories = [
            {'name': 'قياسية', 'description': 'غرف قياسية بأسعار معقولة'},
            {'name': 'ديلوكس', 'description': 'غرف فاخرة مع خدمات إضافية'},
            {'name': 'جناح', 'description': 'أجنحة فاخرة مع مساحة إضافية'},
            {'name': 'عائلية', 'description': 'غرف كبيرة مناسبة للعائلات'},
        ]
        
        for cat_data in categories:
            category = Category.objects.create(
                hotel=hotel,
                name=cat_data['name'],
                description=cat_data['description']
            )
            
            # Create room types for each category
            room_types_data = [
                {
                    'name': f'{cat_data["name"]} مفردة',
                    'description': f'غرفة {cat_data["name"]} لشخص واحد',
                    'default_capacity': 1,
                    'max_capacity': 2,
                    'beds_count': 1,
                    'rooms_count': random.randint(5, 10),
                    'base_price': random.randint(200, 500)
                },
                {
                    'name': f'{cat_data["name"]} مزدوجة',
                    'description': f'غرفة {cat_data["name"]} لشخصين',
                    'default_capacity': 2,
                    'max_capacity': 3,
                    'beds_count': 1,
                    'rooms_count': random.randint(5, 10),
                    'base_price': random.randint(300, 700)
                },
                {
                    'name': f'{cat_data["name"]} ثلاثية',
                    'description': f'غرفة {cat_data["name"]} لثلاثة أشخاص',
                    'default_capacity': 3,
                    'max_capacity': 4,
                    'beds_count': 2,
                    'rooms_count': random.randint(3, 7),
                    'base_price': random.randint(400, 900)
                }
            ]
            
            for type_data in room_types_data:
                room_type = RoomType.objects.create(
                    hotel=hotel,
                    category=category,
                    name=type_data['name'],
                    description=type_data['description'],
                    default_capacity=type_data['default_capacity'],
                    max_capacity=type_data['max_capacity'],
                    beds_count=type_data['beds_count'],
                    rooms_count=type_data['rooms_count'],
                    base_price=type_data['base_price'],
                    is_active=True
                )

def create_room_statuses():
    hotels = Hotel.objects.all()
    statuses = [
        ('AV', 'متاح', True),
        ('MA', 'صيانة', False),
        ('RS', 'محجوز', False),
        ('CL', 'تنظيف', False)
    ]
    
    for hotel in hotels:
        for code, name, is_available in statuses:
            RoomStatus.objects.create(
                hotel=hotel,
                code=code,
                name=name,
                description=f'حالة {name} للغرف',
                is_available=is_available
            )

def create_room_availability():
    hotels = Hotel.objects.all()
    current_date = datetime.now(pytz.UTC).date()
    
    for hotel in hotels:
        room_types = RoomType.objects.filter(hotel=hotel)
        available_status = RoomStatus.objects.filter(hotel=hotel, code='AV').first()
        
        for room_type in room_types:
            for day in range(30):  # Create availability for next 30 days
                Availability.objects.create(
                    hotel=hotel,
                    room_type=room_type,
                    room_status=available_status,
                    availability_date=current_date + timedelta(days=day),
                    available_rooms=random.randint(1, 5)
                )

def create_blog_posts():
    # Create blog categories
    categories = [
        {'name': 'أخبار الفنادق', 'description': 'آخر أخبار وتحديثات الفنادق'},
        {'name': 'نصائح السفر', 'description': 'نصائح وإرشادات مفيدة للمسافرين'},
        {'name': 'تجارب الضيوف', 'description': 'قصص وتجارب ضيوفنا الكرام'},
        {'name': 'وجهات سياحية', 'description': 'استكشف أجمل الوجهات السياحية'},
    ]
    
    for cat_data in categories:
        category = BlogCategory.objects.create(
            name=cat_data['name'],
            description=cat_data['description']
        )
    
    # Get some categories and users for the posts
    categories = BlogCategory.objects.all()
    authors = User.objects.filter(user_type='hotel_manager')
    
    # Create blog posts
    posts_data = [
        {
            'title': 'كيف تختار الفندق المناسب لإقامتك',
            'content': '''نقدم لكم في هذا المقال أهم النصائح لاختيار الفندق المناسب لإقامتكم.
            
            1. الموقع المناسب
            2. الميزانية المناسبة
            3. المرافق والخدمات
            4. تقييمات النزلاء السابقين
            
            نتمنى لكم إقامة سعيدة!''',
        },
        {
            'title': 'أفضل 5 وجهات سياحية في المملكة',
            'content': '''تعرف على أجمل الوجهات السياحية في المملكة العربية السعودية.
            
            1. الرياض - العاصمة النابضة بالحياة
            2. جدة التاريخية
            3. المدينة المنورة
            4. الطائف - مدينة الورد
            5. العلا - كنز التاريخ
            
            زوروا هذه الوجهات الرائعة واستمتعوا بتجربة لا تنسى!''',
        },
        {
            'title': 'نصائح للسفر الآمن',
            'content': '''إليكم أهم النصائح للسفر بأمان وراحة.
            
            1. التخطيط المسبق
            2. تأمين الحجوزات
            3. الاحتياطات الصحية
            4. الأوراق المطلوبة
            
            سفراً آمناً وممتعاً!''',
        }
    ]
    
    for post_data in posts_data:
        Post.objects.create(
            title=post_data['title'],
            content=post_data['content'],
            author=random.choice(authors),
            category=random.choice(categories),
            is_published=True,
            views=random.randint(10, 1000),
            published_at=timezone.now() - timedelta(days=random.randint(1, 30))
        )

def create_services():
    hotels = Hotel.objects.all()
    services = [
        'خدمة الغرف',
        'المنتجع الصحي',
        'خدمة النقل من وإلى المطار',
        'خدمة الغسيل',
        'حجز المطعم'
    ]
    
    for hotel in hotels:
        for service_name in services:
            HotelService.objects.create(
                hotel=hotel,
                name=service_name,
                description=f'وصف خدمة {service_name}',
                is_active=True
            )

def create_reviews():
    users = User.objects.filter(is_superuser=False)
    hotels = Hotel.objects.all()
    
    for hotel in hotels:
        room_types = RoomType.objects.filter(hotel=hotel)
        for _ in range(10):  # 10 reviews per hotel
            room_type = random.choice(room_types)
            Review.objects.create(
                hotel=hotel,
                room_type=room_type,
                user=random.choice(users),
                rating=random.randint(1, 5),
                content=f'تعليق على الغرفة {room_type.name}',
                created_at=datetime.now(pytz.UTC) - timedelta(days=random.randint(0, 90))
            )

def create_notifications():
    users = User.objects.all()
    admin_user = User.objects.filter(is_superuser=True).first()
    
    notification_types = ['0', '1', '2', '3']  # معلومة، تحذير، نجاح، خطأ
    messages = [
        'مرحباً بك في نظام إدارة الفنادق',
        'يرجى تحديث بياناتك الشخصية',
        'تم تأكيد حجزك بنجاح',
        'هناك تحديثات جديدة في النظام'
    ]
    
    for user in users:
        for _ in range(3):
            msg_index = random.randint(0, len(messages) - 1)
            Notifications.objects.create(
                sender=admin_user,
                user=user,
                message=messages[msg_index],
                status=random.choice(['0', '1']),  # غير مقروء أو مقروء
                notification_type=notification_types[msg_index],
                is_active=True
            )

def create_hotel_requests():
    for i in range(5):
        HotelRequest.objects.create(
            name=f'طلب فندق {i+1}',
            email=f'hotel{i+1}@example.com',
            role='مدير فندق',
            hotel_name=f'فندق جديد {i+1}',
            description=f'وصف للفندق الجديد رقم {i+1}',
            business_license_number=f'LIC{random.randint(1000, 9999)}',
            country='المملكة العربية السعودية',
            state='المنطقة الوسطى',
            city_name='الرياض',
            address=f'شارع {i+1}، حي السليمانية',
            country_code='+966',
            phone_number=f'05{random.randint(10000000, 99999999)}',
            is_approved=random.choice([True, False])
        )

def create_currencies():
    # قائمة العملات الشائعة في المنطقة
    currencies_data = [
        {'name': 'ريال سعودي', 'symbol': 'SAR'},
        {'name': 'دولار أمريكي', 'symbol': 'USD'},
        {'name': 'يورو', 'symbol': 'EUR'},
        {'name': 'درهم إماراتي', 'symbol': 'AED'},
        {'name': 'جنيه إسترليني', 'symbol': 'GBP'},
    ]
    
    hotels = Hotel.objects.all()
    for hotel in hotels:
        for currency_data in currencies_data:
            Currency.objects.create(
                currency_name=currency_data['name'],
                currency_symbol=currency_data['symbol'],
                hotel=hotel
            )

def create_payment_options():
    # طرق الدفع الشائعة
    payment_methods = [
        {'name': 'فيزا', 'logo': 'payment_logos/visa.png'},
        {'name': 'ماستر كارد', 'logo': 'payment_logos/mastercard.png'},
        {'name': 'مدى', 'logo': 'payment_logos/mada.png'},
        {'name': 'أبل باي', 'logo': 'payment_logos/apple_pay.png'},
        {'name': 'باي بال', 'logo': 'payment_logos/paypal.png'},
    ]
    
    currencies = Currency.objects.all()
    for currency in currencies:
        for method in payment_methods:
            PaymentOption.objects.create(
                method_name=method['name'],
                logo=method['logo'],
                currency=currency,
                is_active=True
            )

def create_hotel_payment_methods():
    hotels = Hotel.objects.all()
    payment_options = PaymentOption.objects.all()
    
    for hotel in hotels:
        # اختيار عدد عشوائي من طرق الدفع لكل فندق
        selected_options = random.sample(list(payment_options), k=random.randint(3, 5))
        
        for option in selected_options:
            HotelPaymentMethod.objects.create(
                hotel=hotel,
                payment_option=option,
                account_name=f"حساب {hotel.name} - {option.method_name}",
                account_number=f"{random.randint(1000000000, 9999999999)}",
                iban=f"SA{random.randint(1000000000000000, 9999999999999999)}",
                description=f"للدفع عبر {option.method_name}، يرجى اتباع التعليمات التالية...",
                is_active=True
            )

def create_payments():
    # نحتاج إلى التأكد من وجود حجوزات أولاً
    bookings = Booking.objects.all()
    if not bookings:
        print("لا توجد حجوزات لإنشاء مدفوعات لها")
        return
    
    payment_methods = HotelPaymentMethod.objects.all()
    
    for booking in bookings:
        # اختيار طريقة دفع عشوائية متاحة في الفندق
        hotel_methods = payment_methods.filter(hotel=booking.hotel, is_active=True)
        if not hotel_methods:
            continue
            
        payment_method = random.choice(hotel_methods)
        subtotal = booking.total_price
        discount = random.randint(0, 50) if random.random() < 0.3 else 0  # 30% احتمال وجود خصم
        
        Payment.objects.create(
            payment_method=payment_method,
            payment_status=random.choice([0, 1, 2, 3]),  # حالة عشوائية
            payment_subtotal=subtotal,
            payment_discount=discount,
            payment_totalamount=subtotal - discount,
            payment_currency=payment_method.payment_option.currency.currency_symbol,
            payment_note="تم الدفع بنجاح" if random.random() < 0.8 else "ملاحظات إضافية حول عملية الدفع",
            booking=booking,
            payment_type=random.choice(['cash', 'e_pay'])
        )

def populate_database():
    print("إنشاء المستخدمين...")
    create_users()
    
    print("إنشاء بيانات إدارة الفنادق...")
    create_hotel_management_data()
    
    print("إنشاء تصنيفات وأنواع الغرف...")
    create_room_categories_and_types()
    
    print("إنشاء حالات الغرف...")
    create_room_statuses()
    
    print("إنشاء توفر الغرف...")
    create_room_availability()
    
    print("إنشاء المقالات...")
    create_blog_posts()
    
    print("إنشاء الخدمات...")
    create_services()
    
    print("إنشاء العملات...")
    create_currencies()
    
    print("إنشاء خيارات الدفع...")
    create_payment_options()
    
    print("إنشاء طرق دفع الفنادق...")
    create_hotel_payment_methods()
    
    print("إنشاء الإشعارات...")
    create_notifications()
    
    print("إنشاء طلبات الفنادق...")
    create_hotel_requests()
    
    print("إنشاء المدفوعات...")
    create_payments()

if __name__ == '__main__':
    populate_database()
