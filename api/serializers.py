from rest_framework import serializers
from django.contrib.auth import get_user_model
from HotelManagement.models import Hotel
from bookings.models import Booking,BookingDetail,Guest
from customer.models import Favourites
from hotels import settings
from notifications.models import Notifications
from payments.models import Currency, HotelPaymentMethod, Payment, PaymentOption
from rooms.models import Category, RoomType,RoomImage
from services.models import HotelService, RoomTypeService
from django.core.exceptions import ValidationError

from users.models import CustomUser

User = get_user_model()

class ImageSerializer(serializers.ModelSerializer):
    image_url = serializers.SerializerMethodField()

    class Meta:
        model = RoomImage
        fields = ['id', 'image_url','is_main','caption']

    def get_image_url(self, obj):
        request = self.context.get('request')
        if request:
            return request.build_absolute_uri(obj.image.url) if obj.image else None
        return obj.image.url if obj.image else None


class RoomServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = RoomTypeService
        fields = ['id', 'name','description','icon','additional_fee']

class HotelServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotelService
        fields = ['id', 'name']




class CurrencySerializer(serializers.ModelSerializer):
    class Meta:
        model = Currency
        fields = ['id', 'currency_name', 'currency_symbol']

class PaymentOptionSerializer(serializers.ModelSerializer):
    currency = CurrencySerializer()
    
    class Meta:
        model = PaymentOption
        fields = ['id', 'method_name', 'logo', 'currency']

class HotelPaymentMethodSerializer(serializers.ModelSerializer):
    payment_option = PaymentOptionSerializer()
    
    class Meta:
        model = HotelPaymentMethod
        fields = '__all__'    




class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = [
            'booking', 'payment_method', 'transfer_image', 'payment_status', 
            'payment_date', 'payment_subtotal', 'payment_totalamount', 
            'payment_currency', 'payment_type', 'payment_note', 'payment_discount'
        ]
        extra_kwargs = {
            'transfer_image': {'required': False, 'allow_null': True}
        }




class BookingDetailSerializer(serializers.ModelSerializer):
    hotel_name = serializers.CharField(source='hotel.name', read_only=True)
    service_name = serializers.CharField(source='service.name', read_only=True)

    class Meta:
        model = BookingDetail
        fields = [
            'id',
            'booking', 
            'hotel', 'hotel_name',
            'service', 'service_name',
            'quantity',
            'price',
            'total',
            'notes',
        ]

class BookingGuestSerializer(serializers.ModelSerializer):
    # hotel 
    # booking 

    

    class Meta:
        model = Guest
        fields = ['name', 'phone_number', 'id_card_image', 'gender', 'birthday_date', 'check_in_date', 'check_out_date']



class BookingSerializer(serializers.ModelSerializer):
    hotel_name = serializers.SerializerMethodField()
    user_name = serializers.SerializerMethodField()
    room_name = serializers.SerializerMethodField()
    details = BookingDetailSerializer(many=True, read_only=True)
    guests = BookingGuestSerializer(many=True, read_only=True)
    hotel_image = serializers.SerializerMethodField()

    class Meta:
        model = Booking
        fields = [
            'id', 'hotel', 'hotel_name','hotel_image', 'details','guests',
            'user', 'user_name', 'room', 'room_name',
            'check_in_date', 'check_out_date',
            'amount', 'status', 'rooms_booked'
        ]

    def get_hotel_name(self, obj):
        return obj.hotel.name
    def get_hotel_image(self, obj):
        request = self.context.get('request')
        if request:
            return request.build_absolute_uri(obj.hotel.profile_picture.url) if obj.hotel.profile_picture else None
        return obj.hotel.profile_picture.url if obj.hotel.profile_picture else None

    def get_user_name(self, obj):
        return f"{obj.user.first_name} {obj.user.last_name}"

    def get_room_name(self, obj):
        return obj.room.name


    def validate(self, data):
        if data.get('check_in_date') and data.get('check_out_date'):
            if data['check_in_date'] >= data['check_out_date']:
                raise serializers.ValidationError('Check-in date must be before check-out date.')

        if data.get('amount') <= 0:
            raise serializers.ValidationError('Amount must be greater than 0.')

        return data





class RoomsSerializer(serializers.ModelSerializer):
    images = serializers.SerializerMethodField()
    services = serializers.SerializerMethodField()
    

    class Meta:
        model = RoomType
        fields = '__all__'

    def get_images(self, obj):
        images = RoomImage.objects.filter(room_type=obj)
        return ImageSerializer(images, many=True, context=self.context).data

    def get_services(self, obj):
        services = obj.room_services.all()
        return RoomServiceSerializer(services, many=True).data

class HotelSerializer(serializers.ModelSerializer):
    rooms = serializers.SerializerMethodField()
    services = serializers.SerializerMethodField()
    location = serializers.SerializerMethodField()
    paymentOption = serializers.SerializerMethodField()

    class Meta:
        model = Hotel
        fields = ['id', 'name', 'profile_picture', 'description', 'location', 'services', 'rooms','paymentOption']
        

    def get_rooms(self, obj):
        rooms = RoomType.objects.filter(hotel=obj)
        return RoomsSerializer(rooms, many=True, context=self.context).data

    def get_services(self, obj):
        return HotelServiceSerializer(obj.hotel_services.all(), many=True).data
    def get_paymentOption(self, obj):
        return HotelPaymentMethodSerializer(obj.payment_methods.all(), many=True).data


    def get_location(self, obj):
        return obj.location.address if obj.location else None



class RegisterSerializer(serializers.ModelSerializer):
    image = serializers.ImageField(required=False)

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'phone', 'first_name', 'last_name', 'image']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        image = validated_data.pop('image', None)
        validated_data["user_type"] = "customer"
        try:
            user = User.objects.create_user(**validated_data)
        except ValidationError as e:
            raise serializers.ValidationError({'error': str(e)})

        if image:
            user.image = image
            user.save()

        return user


class NotificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notifications
        fields = '__all__'
        read_only_fields = ('sender', 'user', 'send_time')

class FavouritesSerializer(serializers.ModelSerializer):
    hotel = serializers.PrimaryKeyRelatedField(
        queryset=Hotel.objects.all(), write_only=True
    )
    hotel_data = HotelSerializer(source='hotel', read_only=True)

    class Meta:
        model = Favourites
        fields = ['hotel','hotel_data']

  
class HotelAvabilitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Hotel
        fields = ['id', 'name', 'location',]

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['id', 'name', 'description']



class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id','username','gender', 'birth_date','email', 'first_name', 'last_name', 'phone', 'image']


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = [
            'id', 'username', 'email', 'first_name', 'last_name',
            'phone', 'image', 'gender', 'birth_date', 
        ]
        read_only_fields = ['id', 'user_type', 'chield', 'chart']
        extra_kwargs = {
            'password': {'write_only': True},
        }
# ------------test------------------
# {
#   "username": "ahmed2025",
#   "email": "johnahmed2025.doe@example.com",
#   "password": "SecurePass123!",
#   "first_name": "ahmed",
#   "last_name": "Nasser",
#   "phone": 781717609,
#   "is_active": 1,
#   "chield_id": null,
#   "user_type": "customer"
# }
# ----------------------------------



# {
#   "username": "ahmed5112025",
#   "email": "johnahmed020202025.doe@example.com",
#   "password": "SecurePass123!",
#   "first_name": "ahmed",
#   "last_name": "Nasser",
#   "phone": 781717609,
#   "is_active": 1,
#   "chield_id": null,
#   "user_type": "customer"
# }
