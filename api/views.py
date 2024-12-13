# api/views.py
from rest_framework import viewsets
from HotelManagement.models import Hotel 
from .serializers import HotelSerializer

class HotelsViewSet(viewsets.ModelViewSet):
    """
    A viewset for viewing and editing Hotels instances.
    """
    queryset = Hotel.objects.all()
    serializer_class = HotelSerializer
