from rest_framework import serializers
from HotelManagement.models import Hotel  # Import the model



class HotelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Hotel
        fields = '__all__'  # Or specify fields explicitly: ['id', 'name', 'description', 'price', 'created_at']
