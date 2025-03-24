from rest_framework import serializers
from django.contrib.auth import get_user_model
from HotelManagement.models import Hotel
from bookings.models import Booking
from customer.models import Favourites
from notifications.models import Notifications
from payments.models import Currency, HotelPaymentMethod, Payment, PaymentOption
from rooms.models import RoomType,RoomImage
from services.models import HotelService, RoomTypeService
from django.core.exceptions import ValidationError

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
        fields = [
            'id',
            'payment_option',
            'account_name',
            'account_number',
            'iban',
            'description',
            
        ]      




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

class BookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Booking
        fields = [
            'hotel', 'user', 'room', 'check_in_date', 'check_out_date', 
            'amount', 'status',  'rooms_booked'
        ]

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

    class Meta:
        model = Hotel
        fields = ['id', 'name', 'profile_picture', 'description', 'location', 'services', 'rooms']
        

    def get_rooms(self, obj):
        rooms = RoomType.objects.filter(hotel=obj)
        return RoomsSerializer(rooms, many=True, context=self.context).data

    def get_services(self, obj):
        return HotelServiceSerializer(obj.hotel_services.all(), many=True).data

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
    hotel = HotelSerializer()
    class Meta:
        model = Favourites
        fields = ['hotel']


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
