from rest_framework import serializers
from django.contrib.auth import get_user_model
from HotelManagement.models import Hotel
from rooms.models import RoomType

User = get_user_model()

class HotelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Hotel
        fields = '__all__'

class RoomsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RoomType
        fields = '__all__'

class RegisterSerializer(serializers.ModelSerializer):
    image = serializers.ImageField(required=False)

    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'phone', 'first_name', 'last_name', 'image']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        image = validated_data.pop('image', None)
        validated_data["user_type"] = "customer"  
        user = User.objects.create_user(**validated_data)
        
        if image:
            user.image = image
            user.save()
            
        return user



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
