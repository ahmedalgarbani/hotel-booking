import random
from datetime import timedelta # Added timedelta import
from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils.text import slugify # Added slugify import
# Import all models from your apps here
# Example: from accounts.models import User
# from rooms.models import Room, RoomType
# from bookings.models import Booking, Guest
from accounts.models import ChartOfAccounts, JournalEntry
from blog.models import Category as BlogCategory, Tag, Post, Comment # Renamed Category
from bookings.models import Guest, Booking, BookingDetail, ExtensionMovement, BookingHistory
from customer.models import Favourites
from home.models import InfoBox, RoomTypeHome, Setting, SocialMediaLink, HeroSlider, TeamMember, Partner, Testimonial, PricingPlan, ContactMessage, PrivacyPolicy, PaymenPolicy, TermsConditions
from HotelManagement.models import City, Location, Hotel, Phone, Image, HotelRequest # Assuming BaseModel is abstract
from notifications.models import Notifications
from payments.models import Currency, PaymentOption, HotelPaymentMethod, Payment, PaymentHistory
from reviews.models import HotelReview, RoomReview
from rooms.models import Category as RoomCategory, RoomType, RoomPrice, Availability, RoomImage # Renamed Category to avoid conflict
from services.models import HotelService, RoomTypeService, Offer, Coupon
from users.models import CustomUser, ActivityLog


class Command(BaseCommand):
    help = 'Populates the database with fake data for all models.'

    def add_arguments(self, parser):
        parser.add_argument(
            '--count',
            type=int,
            default=10,
            help='Number of records to create for each model (default: 10)',
        )

    @transaction.atomic  # Use a transaction to ensure atomicity
    def handle(self, *args, **options):
        count = options['count']
        fake = Faker() # You can specify locale e.g., Faker('ar_SA') for Arabic data

        self.stdout.write(self.style.SUCCESS(f'Starting to populate database with {count} records per model...'))

        # --- Population Logic ---
        # Add logic here to create fake data for each model
        # Remember to handle relationships (e.g., create a User before creating a Booking for them)
        # Use fake.* methods to generate data (e.g., fake.name(), fake.email(), fake.date_time_this_decade())

        # --- Create Users ---
        users = []
        for i in range(count * 2): # Create more users for variety
            # Ensure unique usernames and emails
            username = fake.unique.user_name()
            # Check if username already exists (simple check, might need refinement for large scale)
            while CustomUser.objects.filter(username=username).exists():
                 username = f"{fake.unique.user_name()}_{random.randint(100,999)}" # Add random suffix

            email = fake.unique.email()
            while CustomUser.objects.filter(email=email).exists():
                 email = f"{random.randint(100,999)}_{fake.unique.email()}" # Add random prefix

            user = CustomUser(
                username=username,
                email=email,
                first_name=fake.first_name(),
                last_name=fake.last_name(),
                is_staff=random.choice([True, False]), # Randomly assign staff status
                is_active=True,
                # Add other fields as needed, e.g., phone_number, address, user_type
            )
            user.set_password('password123') # Set a default password
            users.append(user)
        CustomUser.objects.bulk_create(users)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(users)} CustomUser records.'))
        # Fetch created users to use their IDs later
        created_users = list(CustomUser.objects.all())
        if not created_users:
             self.stdout.write(self.style.ERROR('No users found or created. Cannot proceed with related models.'))
             return # Exit if no users

        # --- Create Cities ---
        cities_to_create = []
        existing_slugs = set(City.objects.values_list('slug', flat=True))
        target_city_count = count // 2 or 1
        max_attempts_per_city = 10 # Max attempts to generate a unique slug for one city

        for _ in range(target_city_count):
            city_created = False
            for attempt in range(max_attempts_per_city):
                state_name = fake.state()
                country_name = fake.country()
                base_slug = slugify(state_name) or slugify(country_name)

                # If both slugify to empty, generate a random fallback *immediately*
                if not base_slug:
                    base_slug = f"city-{fake.unique.uuid4()[:8]}" # Use unique random part

                current_slug = base_slug
                num = 1
                # Check against DB slugs AND slugs generated in this loop
                while current_slug in existing_slugs:
                    current_slug = f"{base_slug}-{num}"
                    num += 1

                # Ensure the final slug is not empty and truly unique before adding
                if current_slug and current_slug not in existing_slugs:
                    cities_to_create.append(City(
                        state=state_name,
                        country=country_name,
                        slug=current_slug,
                        created_by=random.choice(created_users)
                    ))
                    existing_slugs.add(current_slug) # Add to our set immediately
                    city_created = True
                    break # Exit inner loop once unique slug is found

            if not city_created:
                self.stdout.write(self.style.WARNING(f"Failed to generate a unique slug for a city after {max_attempts_per_city} attempts. Skipping one city."))

        if cities_to_create:
            try:
                created_city_objects = City.objects.bulk_create(cities_to_create)
                self.stdout.write(self.style.SUCCESS(f'Successfully created {len(created_city_objects)} City records.'))
                # It's safer to fetch all cities again after creation if needed elsewhere
                created_cities = list(City.objects.all())
            except Exception as e:
                 self.stdout.write(self.style.ERROR(f'Critical Error during City bulk_create: {e}'))
                 # Print details of objects attempted
                 self.stdout.write("Attempted City data:")
                 for city_data in cities_to_create:
                     self.stdout.write(f" - State: {city_data.state}, Country: {city_data.country}, Slug: {city_data.slug}")
                 return # Stop execution
        else:
             self.stdout.write(self.style.WARNING('No new City records were created (possibly due to slug generation issues).'))
             created_cities = list(City.objects.all()) # Still fetch existing ones if any

        if not created_cities:
             self.stdout.write(self.style.WARNING('No cities created. Hotels will not have cities.'))


        # --- Create Locations ---
        locations = []
        for _ in range(count):
             locations.append(Location(
                 address=fake.address(),
                 latitude=fake.latitude(),
                 longitude=fake.longitude(),
                 city=random.choice(created_cities) if created_cities else None,
                 created_by=random.choice(created_users)
             ))
        Location.objects.bulk_create(locations)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(locations)} Location records.'))
        created_locations = list(Location.objects.all())
        if not created_locations:
             self.stdout.write(self.style.WARNING('No locations created. Hotels will not have locations.'))

        # --- Create Hotels ---
        hotels = []
        for i in range(count):
             hotel_user = random.choice(created_users) # Assign a user as manager/owner
             hotels.append(Hotel(
                 name=f"{fake.company()} Hotel {i}",
                 description=fake.text(max_nb_chars=500),
                 email=fake.unique.company_email(),
                 website=fake.url(),
                 location=random.choice(created_locations) if created_locations else None,
                 city=random.choice(created_cities) if created_cities else None, # Link city directly too if needed by model
                 manager=hotel_user, # Assuming a 'manager' field linked to CustomUser
                 created_by=hotel_user,
                 is_verified=random.choice([True, False]),
                 # Add other fields like rating, amenities etc.
             ))
        Hotel.objects.bulk_create(hotels)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(hotels)} Hotel records.'))
        created_hotels = list(Hotel.objects.all())
        if not created_hotels:
             self.stdout.write(self.style.ERROR('No hotels created. Cannot proceed with hotel-related models.'))
             return # Exit if no hotels

        # --- Create Phones for Hotels ---
        phones = []
        for hotel in created_hotels:
             # Create 1-3 phone numbers per hotel
             for _ in range(random.randint(1, 3)):
                 phones.append(Phone(
                     hotel=hotel,
                     phone_number=fake.phone_number(),
                     created_by=hotel.created_by # Use hotel creator/manager
                 ))
        Phone.objects.bulk_create(phones)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(phones)} Phone records for hotels.'))

        # --- Create Images for Hotels ---
        # Note: ImageField requires actual image files or setup for dummy images.
        # This will create records but ImageField might be empty or point to non-existent paths without further setup.
        images = []
        for hotel in created_hotels:
             # Create 2-5 images per hotel
             for i in range(random.randint(2, 5)):
                 images.append(Image(
                     hotel=hotel,
                     # image= 'path/to/fake/image.jpg', # Requires handling image files
                     alt_text=f"Image {i+1} for {hotel.name}",
                     created_by=hotel.created_by
                 ))
        Image.objects.bulk_create(images)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(images)} Image records for hotels (Image field may be blank).'))

        # --- Create Room Categories (Blog Category already imported as Category) ---
        room_categories = []
        cat_names = ['Single', 'Double', 'Suite', 'Family', 'Deluxe', 'Standard', 'Economy']
        for name in cat_names:
             # Ensure unique category names (simple check)
             if not RoomCategory.objects.filter(name=name).exists():
                 room_categories.append(RoomCategory(name=name, description=fake.sentence(), created_by=random.choice(created_users)))
        RoomCategory.objects.bulk_create(room_categories)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(room_categories)} RoomCategory records.'))
        created_room_categories = list(RoomCategory.objects.all())
        if not created_room_categories:
             self.stdout.write(self.style.WARNING('No room categories created. Room types will not have categories.'))

        
        # --- Create Room Types ---
        room_types = []
        for hotel in created_hotels:
             # Create 5-15 room types per hotel
             for i in range(random.randint(5, 15)):
                 room_types.append(RoomType(
                     hotel=hotel,
                     category=random.choice(created_room_categories) if created_room_categories else None,
                     name=f"{random.choice(['Standard', 'Deluxe', 'Executive', 'Ocean View', 'City View'])} {random.choice(['Single', 'Double', 'Queen', 'King'])} Room {i}",
                     description=fake.text(max_nb_chars=300),
                     capacity=random.randint(1, 4),
                     beds=random.randint(1, 2),
                     price_per_night=random.uniform(50.0, 500.0),
                     created_by=hotel.created_by,
                     # Add other fields like amenities, size etc.
                 ))
        RoomType.objects.bulk_create(room_types)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(room_types)} RoomType records.'))
        created_room_types = list(RoomType.objects.all())
        if not created_room_types:
             self.stdout.write(self.style.ERROR('No room types created. Cannot proceed with room-related models.'))
             return # Exit if no room types

        # --- Create Room Images ---
        # Similar note as Hotel Images regarding ImageField
        room_images = []
        for room_type in created_room_types:
             # Create 1-4 images per room type
             for i in range(random.randint(1, 4)):
                 room_images.append(RoomImage(
                     room_type=room_type,
                     # image='path/to/fake/room_image.jpg', # Requires handling image files
                     alt_text=f"Image {i+1} for {room_type.name}",
                     created_by=room_type.created_by
                 ))
        RoomImage.objects.bulk_create(room_images)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(room_images)} RoomImage records (Image field may be blank).'))

        # --- Create Currencies ---
        currencies = []
        currency_codes = ['USD', 'EUR', 'SAR', 'AED', 'YER'] # Add more as needed
        for code in currency_codes:
             if not Currency.objects.filter(code=code).exists():
                 currencies.append(Currency(
                     code=code,
                     name=fake.currency_name(),
                     symbol=fake.currency_symbol(),
                     created_by=random.choice(created_users)
                 ))
        Currency.objects.bulk_create(currencies)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(currencies)} Currency records.'))
        created_currencies = list(Currency.objects.all())
        if not created_currencies:
             self.stdout.write(self.style.WARNING('No currencies created. Payment methods might lack currency info.'))

        # --- Create Payment Options ---
        payment_options = []
        option_names = ['Credit Card', 'PayPal', 'Bank Transfer', 'Cash on Arrival', 'Stripe', 'Mada']
        for name in option_names:
             if not PaymentOption.objects.filter(name=name).exists():
                 payment_options.append(PaymentOption(
                     name=name,
                     description=fake.sentence(),
                     created_by=random.choice(created_users)
                 ))
        PaymentOption.objects.bulk_create(payment_options)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(payment_options)} PaymentOption records.'))
        created_payment_options = list(PaymentOption.objects.all())
        if not created_payment_options:
             self.stdout.write(self.style.WARNING('No payment options created. Hotel payment methods cannot be created.'))

        # --- Create Hotel Payment Methods ---
        hotel_payment_methods = []
        if created_hotels and created_payment_options and created_currencies:
             for hotel in created_hotels:
                 # Assign 2-4 payment methods per hotel
                 assigned_options = random.sample(created_payment_options, k=random.randint(2, min(4, len(created_payment_options))))
                 for option in assigned_options:
                     hotel_payment_methods.append(HotelPaymentMethod(
                         hotel=hotel,
                         payment_option=option,
                         currency=random.choice(created_currencies), # Assign a random currency
                         is_active=True,
                         created_by=hotel.created_by
                     ))
             HotelPaymentMethod.objects.bulk_create(hotel_payment_methods)
             self.stdout.write(self.style.SUCCESS(f'Successfully created {len(hotel_payment_methods)} HotelPaymentMethod records.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping HotelPaymentMethod creation due to missing Hotels, PaymentOptions, or Currencies.'))

        # --- Create Hotel Services ---
        hotel_services = []
        service_names = ['WiFi', 'Parking', 'Swimming Pool', 'Gym', 'Restaurant', 'Bar', 'Room Service', 'Laundry', 'Spa']
        for name in service_names:
             if not HotelService.objects.filter(name=name).exists():
                 hotel_services.append(HotelService(
                     name=name,
                     description=fake.sentence(),
                     price=random.uniform(0.0, 50.0), # Some services might be free
                     # icon field might need specific handling (e.g., FontAwesome class names)
                     icon=random.choice(['fa-wifi', 'fa-parking', 'fa-swimmer', 'fa-dumbbell', 'fa-utensils', 'fa-glass-martini-alt', 'fa-concierge-bell', 'fa-tshirt', 'fa-spa']),
                     created_by=random.choice(created_users)
                 ))
        HotelService.objects.bulk_create(hotel_services)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(hotel_services)} HotelService records.'))
        created_hotel_services = list(HotelService.objects.all())

        # --- Create Room Type Services ---
        room_type_services = []
        room_service_names = ['Air Conditioning', 'Private Bathroom', 'TV', 'Mini Bar', 'Balcony', 'Safe Deposit Box', 'Hair Dryer']
        for name in room_service_names:
             if not RoomTypeService.objects.filter(name=name).exists():
                 room_type_services.append(RoomTypeService(
                     name=name,
                     description=fake.sentence(),
                     price=random.uniform(0.0, 20.0),
                     icon=random.choice(['fa-snowflake', 'fa-bath', 'fa-tv', 'fa-glass-whiskey', 'fa-door-open', 'fa-lock', 'fa-wind']),
                     created_by=random.choice(created_users)
                 ))
        RoomTypeService.objects.bulk_create(room_type_services)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(room_type_services)} RoomTypeService records.'))
        created_room_type_services = list(RoomTypeService.objects.all())

        # --- Assign Services to Hotels and Room Types (Many-to-Many) ---
        if created_hotels and created_hotel_services:
            for hotel in created_hotels:
                services_to_add = random.sample(created_hotel_services, k=random.randint(3, min(8, len(created_hotel_services))))
                hotel.services.add(*services_to_add) # Assuming 'services' is the M2M field name in Hotel model
            self.stdout.write(self.style.SUCCESS(f'Assigned Hotel Services to Hotels.'))

        if created_room_types and created_room_type_services:
             for room_type in created_room_types:
                 services_to_add = random.sample(created_room_type_services, k=random.randint(2, min(5, len(created_room_type_services))))
                 room_type.services.add(*services_to_add) # Assuming 'services' is the M2M field name in RoomType model
             self.stdout.write(self.style.SUCCESS(f'Assigned Room Type Services to Room Types.'))

        # --- Create Offers ---
        offers = []
        if created_hotels:
            for _ in range(count * 2): # Create more offers
                 offers.append(Offer(
                     hotel=random.choice(created_hotels),
                     title=f"{random.randint(10, 50)}% off {fake.bs()}",
                     description=fake.text(max_nb_chars=200),
                     discount_percentage=random.uniform(5.0, 50.0),
                     start_date=fake.date_this_year(),
                     end_date=fake.date_between(start_date='+1d', end_date='+1y'),
                     is_active=random.choice([True, False]),
                     created_by=random.choice(created_users)
                 ))
            Offer.objects.bulk_create(offers)
            self.stdout.write(self.style.SUCCESS(f'Successfully created {len(offers)} Offer records.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping Offer creation due to missing Hotels.'))

        # --- Create Coupons ---
        coupons = []
        for _ in range(count):
             coupons.append(Coupon(
                 code=fake.unique.bothify(text='??##??##').upper(), # Generate unique code like AB12CD34
                 description=fake.sentence(),
                 discount_type=random.choice(['percentage', 'fixed']), # Assuming choices exist
                 discount_value=random.uniform(5.0, 100.0) if random.choice([True, False]) else random.uniform(5.0, 50.0),
                 valid_from=fake.date_this_year(),
                 valid_to=fake.date_between(start_date='+1d', end_date='+2y'),
                 max_usage=random.randint(50, 500),
                 usage_count=0,
                 is_active=True,
                 created_by=random.choice(created_users)
             ))
        Coupon.objects.bulk_create(coupons)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(coupons)} Coupon records.'))

        # --- Create Blog Categories ---
        blog_categories = []
        blog_cat_names = ['Travel Tips', 'Hotel News', 'Destinations', 'Food & Drink', 'Technology']
        for name in blog_cat_names:
             if not BlogCategory.objects.filter(name=name).exists():
                 blog_categories.append(BlogCategory(name=name, description=fake.sentence(), created_by=random.choice(created_users)))
        BlogCategory.objects.bulk_create(blog_categories)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(blog_categories)} BlogCategory records.'))
        created_blog_categories = list(BlogCategory.objects.all())
        if not created_blog_categories:
             self.stdout.write(self.style.WARNING('No blog categories created. Posts will not have categories.'))

        # --- Create Tags ---
        tags = []
        tag_names = ['luxury', 'budget', 'family travel', 'solo travel', 'business travel', 'adventure', 'relaxation', 'beach', 'city break', 'culture']
        for name in tag_names:
             if not Tag.objects.filter(name=name).exists():
                 tags.append(Tag(name=name, created_by=random.choice(created_users)))
        Tag.objects.bulk_create(tags)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(tags)} Tag records.'))
        created_tags = list(Tag.objects.all())
        if not created_tags:
             self.stdout.write(self.style.WARNING('No tags created. Posts will not have tags.'))

        # --- Create Posts ---
        posts = []
        if created_blog_categories and created_tags:
            for i in range(count * 3): # Create more posts
                 post_author = random.choice(created_users)
                 post = Post(
                     title=fake.sentence(nb_words=6),
                     content=fake.text(max_nb_chars=2000),
                     author=post_author, # Assuming 'author' field links to CustomUser
                     category=random.choice(created_blog_categories),
                     status=random.choice(['published', 'draft']), # Assuming choices exist
                     created_by=post_author,
                     # Add image field if exists
                 )
                 # Need to save post first before adding M2M tags
                 post.save()
                 # Assign 1-5 tags per post
                 tags_to_add = random.sample(created_tags, k=random.randint(1, min(5, len(created_tags))))
                 post.tags.add(*tags_to_add) # Assuming 'tags' is the M2M field name
                 posts.append(post) # Keep track of saved posts
            self.stdout.write(self.style.SUCCESS(f'Successfully created {len(posts)} Post records and assigned tags.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping Post creation due to missing BlogCategories or Tags.'))
        created_posts = posts # Use the list of saved posts

        # --- Create Comments ---
        comments = []
        if created_posts:
            for post in created_posts:
                 # Create 0-5 comments per post
                 for _ in range(random.randint(0, 5)):
                     comment_author = random.choice(created_users)
                     comments.append(Comment(
                         post=post,
                         author=comment_author, # Assuming 'author' links to CustomUser
                         content=fake.paragraph(nb_sentences=3),
                         created_by=comment_author,
                         is_approved=random.choice([True, False]),
                     ))
            Comment.objects.bulk_create(comments)
            self.stdout.write(self.style.SUCCESS(f'Successfully created {len(comments)} Comment records.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping Comment creation due to missing Posts.'))

        # --- Create Guests ---
        guests = []
        # Create guests based on a subset of users or create new ones
        guest_users = random.sample(created_users, k=min(len(created_users), count * 3)) # Use existing users as guests
        for user in guest_users:
             guests.append(Guest(
                 user=user,
                 first_name=user.first_name or fake.first_name(),
                 last_name=user.last_name or fake.last_name(),
                 email=user.email or fake.unique.email(),
                 phone=fake.phone_number(),
                 address=fake.address(),
                 created_by=user # Or a specific admin user
             ))
        # Add some guests not linked to users
        for _ in range(count):
             guests.append(Guest(
                 user=None,
                 first_name=fake.first_name(),
                 last_name=fake.last_name(),
                 email=fake.unique.email(),
                 phone=fake.phone_number(),
                 address=fake.address(),
                 created_by=random.choice(created_users)
             ))
        Guest.objects.bulk_create(guests)
        self.stdout.write(self.style.SUCCESS(f'Successfully created {len(guests)} Guest records.'))
        created_guests = list(Guest.objects.all())
        if not created_guests:
             self.stdout.write(self.style.WARNING('No guests created. Bookings cannot be created.'))

        # --- Create Bookings ---
        bookings = []
        if created_room_types and created_guests:
            booking_statuses = [choice[0] for choice in Booking.BookingStatus.choices]
            for i in range(count * 5): # Create more bookings
                 room_type = random.choice(created_room_types)
                 guest = random.choice(created_guests)
                 check_in = fake.date_time_between(start_date='-3m', end_date='+1m', tzinfo=None) # Use timezone-naive datetimes if model expects them
                 check_out = fake.date_time_between(start_date=check_in, end_date=check_in + timedelta(days=random.randint(1, 14)), tzinfo=None)
                 booking_status = random.choice(booking_statuses)

                 # Simple total price calculation (adjust based on actual logic if needed)
                 days = (check_out.date() - check_in.date()).days
                 total_price = room_type.price_per_night * days if days > 0 else room_type.price_per_night

                 bookings.append(Booking(
                     hotel=room_type.hotel,
                     room_type=room_type,
                     guest=guest,
                     user=guest.user if guest.user else random.choice(created_users), # Assign a user if guest has none
                     check_in_date=check_in.date(),
                     check_out_date=check_out.date(),
                     num_adults=random.randint(1, room_type.capacity or 2),
                     num_children=random.randint(0, (room_type.capacity or 2) - 1),
                     total_price=total_price,
                     status=booking_status,
                     special_requests=fake.sentence() if random.choice([True, False]) else '',
                     created_by=guest.created_by,
                     # Add other fields like booking_number, payment_status etc.
                 ))
            Booking.objects.bulk_create(bookings)
            self.stdout.write(self.style.SUCCESS(f'Successfully created {len(bookings)} Booking records.'))
            created_bookings = list(Booking.objects.all())
            if not created_bookings:
                 self.stdout.write(self.style.WARNING('No bookings created. Booking details and payments cannot be created.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping Booking creation due to missing RoomTypes or Guests.'))

        # --- Create Booking Details (if applicable) ---
        # This depends on the purpose of BookingDetail model. If it stores details per day or per room instance.
        # Assuming it might store assigned room number or daily status. Let's skip for now unless structure is clear.
        # booking_details = []
        # if created_bookings:
        #      for booking in created_bookings:
                 # Logic to create BookingDetail records based on the booking duration/rooms
                 # pass
        #      # BookingDetail.objects.bulk_create(booking_details)
        #      # self.stdout.write(self.style.SUCCESS(f'Successfully created {len(booking_details)} BookingDetail records.'))

        # --- Create Payments ---
        payments = []
        created_hotel_pm_instances = list(HotelPaymentMethod.objects.all()) # Fetch instances
        if created_bookings and created_hotel_pm_instances:
            payment_statuses = [choice[0] for choice in Payment._meta.get_field('status').choices] # Get choices dynamically
            for booking in created_bookings:
                 # Create payment for ~80% of bookings
                 if random.random() < 0.8:
                     # Find a payment method available for the booking's hotel
                     available_methods = [pm for pm in created_hotel_pm_instances if pm.hotel == booking.hotel]
                     if available_methods:
                         payment_method = random.choice(available_methods)
                         payment_status = random.choice(payment_statuses)
                         payments.append(Payment(
                             booking=booking,
                             hotel=booking.hotel,
                             user=booking.user,
                             amount=booking.total_price * random.uniform(0.8, 1.0), # Simulate partial or full payment
                             payment_method=payment_method.payment_option.name, # Store name or link to option? Check model
                             payment_option=payment_method.payment_option, # Link to option if FK
                             currency=payment_method.currency, # Link to currency if FK
                             status=payment_status,
                             transaction_id=fake.unique.iban() if payment_status == 'completed' else None,
                             created_by=booking.created_by,
                         ))
            Payment.objects.bulk_create(payments)
            self.stdout.write(self.style.SUCCESS(f'Successfully created {len(payments)} Payment records.'))
            created_payments = list(Payment.objects.all()) # Fetch created payments if needed later
        else:
             self.stdout.write(self.style.WARNING('Skipping Payment creation due to missing Bookings or HotelPaymentMethods.'))

        # --- Create Hotel Reviews ---
        hotel_reviews = []
        if created_hotels and created_users:
            for hotel in created_hotels:
                 # Create 0-10 reviews per hotel
                 for _ in range(random.randint(0, 10)):
                     reviewer = random.choice(created_users)
                     hotel_reviews.append(HotelReview(
                         hotel=hotel,
                         user=reviewer,
                         rating=random.randint(1, 5),
                         comment=fake.paragraph(nb_sentences=4),
                         is_approved=random.choice([True, False, None]), # Assuming nullable boolean or choices
                         created_by=reviewer,
                     ))
            HotelReview.objects.bulk_create(hotel_reviews)
            self.stdout.write(self.style.SUCCESS(f'Successfully created {len(hotel_reviews)} HotelReview records.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping HotelReview creation due to missing Hotels or Users.'))

        # --- Create Room Reviews ---
        room_reviews = []
        if created_room_types and created_users:
             for room_type in created_room_types:
                 # Create 0-5 reviews per room type
                 for _ in range(random.randint(0, 5)):
                     reviewer = random.choice(created_users)
                     room_reviews.append(RoomReview(
                         room_type=room_type,
                         user=reviewer,
                         rating=random.randint(1, 5),
                         comment=fake.paragraph(nb_sentences=3),
                         is_approved=random.choice([True, False, None]),
                         created_by=reviewer,
                     ))
             RoomReview.objects.bulk_create(room_reviews)
             self.stdout.write(self.style.SUCCESS(f'Successfully created {len(room_reviews)} RoomReview records.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping RoomReview creation due to missing RoomTypes or Users.'))

        # --- Create Favourites ---
        favourites = []
        if created_users and created_hotels:
            for user in created_users:
                 # Assign 0-5 favourite hotels per user
                 fav_hotels = random.sample(created_hotels, k=random.randint(0, min(5, len(created_hotels))))
                 for hotel in fav_hotels:
                     # Check if favourite already exists for this user/hotel combo
                     if not Favourites.objects.filter(user=user, hotel=hotel).exists():
                         favourites.append(Favourites(user=user, hotel=hotel, created_by=user))
            Favourites.objects.bulk_create(favourites)
            self.stdout.write(self.style.SUCCESS(f'Successfully created {len(favourites)} Favourites records.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping Favourites creation due to missing Users or Hotels.'))

        # --- Create Home App Content (Settings, Social, Testimonials etc.) ---
        # Settings (Assuming only one settings object is needed)
        if created_users and not Setting.objects.exists():
            Setting.objects.create(
                site_name=fake.company() + " Hotels",
                logo=None, # Image field
                favicon=None, # Image field
                email=fake.company_email(),
                phone=fake.phone_number(),
                address=fake.address(),
                created_by=random.choice(created_users)
            )
            self.stdout.write(self.style.SUCCESS('Created default Setting record.'))

        # Social Media Links
        social_links = []
        platforms = ['Facebook', 'Twitter', 'Instagram', 'LinkedIn', 'Youtube']
        if created_users and not SocialMediaLink.objects.exists(): # Create only if none exist
            for platform in platforms:
                 social_links.append(SocialMediaLink(
                     platform_name=platform,
                     link=fake.url(),
                     icon_class=f"fab fa-{platform.lower()}", # Example FontAwesome class
                     created_by=random.choice(created_users)
                 ))
            SocialMediaLink.objects.bulk_create(social_links)
            self.stdout.write(self.style.SUCCESS(f'Created {len(social_links)} SocialMediaLink records.'))

        # Testimonials
        testimonials = []
        if created_users:
            for _ in range(count):
                 testimonials.append(Testimonial(
                     author_name=fake.name(),
                     author_position=fake.job(),
                     quote=fake.text(max_nb_chars=250),
                     # author_image=None, # Image field
                     created_by=random.choice(created_users)
                 ))
            Testimonial.objects.bulk_create(testimonials)
            self.stdout.write(self.style.SUCCESS(f'Created {len(testimonials)} Testimonial records.'))

        # Contact Messages
        contact_messages = []
        if created_users:
             for _ in range(count * 2):
                 contact_messages.append(ContactMessage(
                     name=fake.name(),
                     email=fake.email(),
                     subject=fake.sentence(nb_words=4),
                     message=fake.paragraph(nb_sentences=5),
                     created_by=random.choice(created_users) # Or maybe null? Check model
                 ))
             ContactMessage.objects.bulk_create(contact_messages)
             self.stdout.write(self.style.SUCCESS(f'Created {len(contact_messages)} ContactMessage records.'))

        # Policies (Create one of each if they don't exist)
        if created_users:
            if not PrivacyPolicy.objects.exists():
                PrivacyPolicy.objects.create(title="Privacy Policy", content=fake.text(max_nb_chars=5000), created_by=random.choice(created_users))
                self.stdout.write(self.style.SUCCESS('Created default PrivacyPolicy record.'))
            if not PaymenPolicy.objects.exists(): # Note the typo in model name
                PaymenPolicy.objects.create(title="Payment Policy", content=fake.text(max_nb_chars=5000), created_by=random.choice(created_users))
                self.stdout.write(self.style.SUCCESS('Created default PaymenPolicy record.'))
            if not TermsConditions.objects.exists():
                TermsConditions.objects.create(title="Terms & Conditions", content=fake.text(max_nb_chars=5000), created_by=random.choice(created_users))
                self.stdout.write(self.style.SUCCESS('Created default TermsConditions record.'))

        # --- Create Hotel Requests ---
        hotel_requests = []
        if created_users:
             for _ in range(count // 2 or 1): # Fewer requests
                 requester = random.choice(created_users)
                 hotel_requests.append(HotelRequest(
                     user=requester,
                     hotel_name=fake.company() + " Resort",
                     email=requester.email,
                     phone=fake.phone_number(),
                     message=fake.paragraph(),
                     status=random.choice(['pending', 'approved', 'rejected']), # Assuming choices
                     created_by=requester
                 ))
             HotelRequest.objects.bulk_create(hotel_requests)
             self.stdout.write(self.style.SUCCESS(f'Created {len(hotel_requests)} HotelRequest records.'))

        # --- Create Room Prices (Basic) ---
        # More complex pricing might depend on seasons, days, etc. This is basic.
        room_prices = []
        if created_room_types and created_currencies:
             for room_type in created_room_types:
                 # Create 1-2 price entries per room type (e.g., standard, weekend)
                 for i in range(random.randint(1,2)):
                     start_date = fake.date_this_year()
                     end_date = fake.date_between(start_date=start_date, end_date='+1y')
                     room_prices.append(RoomPrice(
                         room_type=room_type,
                         price=room_type.price_per_night * random.uniform(0.9, 1.2), # Slight variation
                         currency=random.choice(created_currencies),
                         start_date=start_date,
                         end_date=end_date,
                         created_by=room_type.created_by
                     ))
             RoomPrice.objects.bulk_create(room_prices)
             self.stdout.write(self.style.SUCCESS(f'Created {len(room_prices)} RoomPrice records.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping RoomPrice creation due to missing RoomTypes or Currencies.'))

        # --- Create Availability (Basic) ---
        # This is highly simplified. Real availability is complex.
        # We'll just create some availability records for upcoming dates.
        availabilities = []
        if created_room_types:
             today = fake.date_object()
             for room_type in created_room_types:
                 # Create availability for the next 30 days
                 for i in range(30):
                     current_date = today + timedelta(days=i)
                     # Check if availability already exists for this room_type/date
                     if not Availability.objects.filter(room_type=room_type, date=current_date).exists():
                         availabilities.append(Availability(
                             room_type=room_type,
                             date=current_date,
                             available_rooms=random.randint(0, 10), # Assuming a max number of rooms of this type
                             created_by=room_type.created_by
                         ))
             Availability.objects.bulk_create(availabilities)
             self.stdout.write(self.style.SUCCESS(f'Created {len(availabilities)} basic Availability records for the next 30 days.'))
        else:
             self.stdout.write(self.style.WARNING('Skipping Availability creation due to missing RoomTypes.'))


        # --- Final Cleanup / Remaining Models ---
        # Add any other simple models here if needed
        # e.g., home.InfoBox, home.RoomTypeHome, home.HeroSlider etc. - often static content

        self.stdout.write(self.style.SUCCESS('Database population complete!'))
