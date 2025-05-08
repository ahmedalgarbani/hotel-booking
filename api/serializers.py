from rest_framework import serializers
from django.contrib.auth import get_user_model
from HotelManagement.models import Hotel
from bookings.models import Booking,BookingDetail,Guest
from customer.models import Favourites
from hotels import settings
from notifications.models import Notifications
from payments.models import Currency, HotelPaymentMethod, Payment, PaymentOption
from rooms.models import Availability, Category, RoomType,RoomImage
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
    """
    Serializer para mostrar información básica de huéspedes en las reservas
    """
    class Meta:
        model = Guest
        fields = ['name', 'phone_number', 'id_card_image', 'gender', 'birthday_date', 'check_in_date', 'check_out_date']


class GuestSerializer(serializers.ModelSerializer):
    """
    Serializer بسيط للضيوف يركز على البيانات الأساسية
    """
    class Meta:
        model = Guest
        fields = [
            'id', 'name', 'phone_number', 'id_card_image', 'gender',
            'birthday_date', 'check_in_date', 'check_out_date',
            'hotel', 'booking'
        ]


from django.conf import settings

from rest_framework import serializers
from datetime import datetime
from .models import Booking

class BookingSerializer(serializers.ModelSerializer):
    # الحقول المشتقة (للقراءة فقط)
    hotel_name = serializers.SerializerMethodField(read_only=True)
    user_name = serializers.SerializerMethodField(read_only=True)
    room_name = serializers.SerializerMethodField(read_only=True)
    hotel_image = serializers.SerializerMethodField(read_only=True)

    # الحقول المرتبطة بعلاقات
    details = BookingDetailSerializer(many=True, read_only=True)
    guests = BookingGuestSerializer(many=True, read_only=True)

    class Meta:
        model = Booking
        fields = [
            'id',
            'hotel',
            'hotel_name',
            'hotel_image',
            'details',
            'guests',
            'user',
            'user_name',
            'room',
            'room_name',
            'check_in_date',
            'check_out_date',
            'amount',
            'status',
            'rooms_booked'
        ]
        read_only_fields = [
            'id',
            'hotel_name',
            'user_name',
            'room_name',
            'hotel_image',
            'details',
            'guests',
            'user',        # يُعيّن تلقائيًا في الـ View
            'status',      # قد يُعيّن تلقائيًا
            'amount'       # قد يُحسب تلقائيًا
        ]

    # ────────────────────────────────────────────────────────────────────
    # دوال الحصول على الحقول المشتقة
    # ────────────────────────────────────────────────────────────────────
    def get_hotel_name(self, obj):
        return obj.hotel.name if obj.hotel else None

    def get_hotel_image(self, obj):
        if not obj.hotel.profile_picture:
            return None
        request = self.context.get('request')
        if request:
            return request.build_absolute_uri(obj.hotel.profile_picture.url)
        return obj.hotel.profile_picture.url

    def get_user_name(self, obj):
        return f"{obj.user.first_name} {obj.user.last_name}" if obj.user else "مستخدم مجهول"

    def get_room_name(self, obj):
        return obj.room.name if obj.room else None

    # ────────────────────────────────────────────────────────────────────
    # التحقق من صحة البيانات
    # ────────────────────────────────────────────────────────────────────
    def validate(self, data):
        # التحقق من التواريخ
        check_in_str = data.get('check_in_date')
        check_out_str = data.get('check_out_date')

        if check_in_str and check_out_str:
            try:
                check_in = datetime.strptime(check_in_str, '%Y-%m-%d').date()
                check_out = datetime.strptime(check_out_str, '%Y-%m-%d').date()
            except (ValueError, TypeError):
                raise serializers.ValidationError("تنسيق التاريخ غير صالح. استخدم `YYYY-MM-DD`.")

            if check_in >= check_out:
                raise serializers.ValidationError({
                    "error": f"تاريخ المغادرة ({check_out_str}) يجب أن يكون بعد تاريخ الوصول ({check_in_str})."
                })

            # إضافة التواريخ المحولة إلى البيانات
            data['check_in_date'] = check_in
            data['check_out_date'] = check_out

        # التحقق من المبلغ
        amount = data.get('amount')
        if amount is not None and amount <= 0:
            raise serializers.ValidationError("المبلغ يجب أن يكون أكبر من الصفر.")

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


from datetime import datetime
from django.db.models import Count

class HotelSerializer(serializers.ModelSerializer):
    rooms = serializers.SerializerMethodField()
    services = serializers.SerializerMethodField()
    location = serializers.SerializerMethodField()
    paymentOption = serializers.SerializerMethodField()

    class Meta:
        model = Hotel
        fields = ['id', 'name', 'profile_picture', 'description', 'location', 'services', 'rooms', 'paymentOption']

    def get_rooms(self, obj):
        check_in = self.context.get('check_in')
        check_out = self.context.get('check_out')
        room_number = self.context.get('room_number')

        rooms = RoomType.objects.filter(hotel=obj)

        if check_in and check_out and room_number:
            try:
                check_in_date = datetime.strptime(check_in, "%Y-%m-%d").date()
                check_out_date = datetime.strptime(check_out, "%Y-%m-%d").date()
                total_days = (check_out_date - check_in_date).days + 1

                available_room_ids = Availability.objects.filter(
                    availability_date__range=(check_in_date, check_out_date),
                    room_type__hotel=obj,
                    available_rooms__gte=room_number
                ).values('room_type') \
                 .annotate(day_count=Count('id')) \
                 .filter(day_count=total_days) \
                 .values_list('room_type', flat=True)

                rooms = rooms.filter(id__in=available_room_ids)

            except Exception:
                rooms = RoomType.objects.none()

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
        fields = ['username', 'email', 'password', 'phone', 'first_name', 'last_name', 'image', 'gender', 'birth_date', ]
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
        # extra_kwargs = {
        #     'password': {'write_only': True},
        # }

class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)

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
