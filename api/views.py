import re
from django.shortcuts import get_object_or_404, render
from httpx import request
from rest_framework.exceptions import ValidationError
from rest_framework import viewsets
from bookings.models import Booking
from customer.models import Favourites
from notifications.models import Notifications
from payments.models import HotelPaymentMethod, Payment
from rooms.models import RoomType
from HotelManagement.models import Hotel
from users.models import CustomUser
from .serializers import BookingSerializer, FavouritesSerializer, HotelPaymentMethodSerializer, NotificationsSerializer, PaymentSerializer, RoomsSerializer, HotelSerializer, RegisterSerializer
from django.contrib.auth import authenticate, get_user_model
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser,JSONParser
from django.core.exceptions import ValidationError
from django.core.exceptions import ValidationError
from rest_framework.decorators import api_view
from rest_framework.decorators import action
from rest_framework.pagination import PageNumberPagination


User = get_user_model()
# Views

class CustomPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 50

from django.db.models import Sum
class HotelsViewSet(viewsets.ModelViewSet):
    queryset = Hotel.objects.filter(is_verified=True)
    serializer_class = HotelSerializer
    pagination_class = CustomPagination
    filterset_fields = ['location', 'services__name']
    search_fields = ['name', 'description', 'location__address']
    ordering_fields = ['name', 'created_at']


    @action(detail=False, methods=['get'])
    def search(self, request):
        hotel_name = request.query_params.get('name', '')
        location = request.query_params.get('location', '')
        adult_number = request.query_params.get('adult_number', '')

        if not hotel_name and not location and not adult_number:
            return Response({'error': 'Provide at least one search parameter'}, status=status.HTTP_400_BAD_REQUEST)

        queryset = Hotel.objects.filter(
            name__icontains=hotel_name,
            location__address__icontains=location
        )

        if adult_number:
            try:
                adult_number = int(adult_number)
                queryset = queryset.annotate(
                    total_capacity=Sum('room_types__default_capacity')
                ).filter(total_capacity__gte=adult_number)
            except ValueError:
                return Response({'error': 'Invalid adult number format'}, status=status.HTTP_400_BAD_REQUEST)

        paginated_queryset = self.paginate_queryset(queryset)
        serializer = HotelSerializer(paginated_queryset, many=True, context={'request': request})
        
        return self.get_paginated_response(serializer.data)

class HotelPaymentMethodViewSet(viewsets.ModelViewSet):
 
    queryset = HotelPaymentMethod.objects.filter(is_active=True)  
    serializer_class = HotelPaymentMethodSerializer

    @action(detail=False, methods=['post'])
    def active_payment_methods(self, request):
       
        hotel_id = request.data.get('hotel_id')

        if not hotel_id:
            return Response(
                {'error': 'hotel_id is required in the request body'},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            hotel = Hotel.objects.get(pk=hotel_id)
        except Hotel.DoesNotExist:
            return Response(
                {'error': 'Hotel not found'},
                status=status.HTTP_404_NOT_FOUND
            )

        payment_methods = HotelPaymentMethod.objects.filter(
            hotel=hotel,
            is_active=True,
            payment_option__is_active=True
        ).select_related('payment_option__currency')

        serializer = HotelPaymentMethodSerializer(payment_methods, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)





    
class RoomsViewSet(viewsets.ModelViewSet):
    queryset = RoomType.objects.all()
    serializer_class = RoomsSerializer


class FavouritesViewSet(viewsets.ModelViewSet):
    serializer_class = FavouritesSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Favourites.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        hotel_id = serializer.validated_data['hotel'].id
        if Favourites.objects.filter(user=request.user, hotel=hotel_id).exists():
            return Response({"detail": "Favourite already exists."}, status=status.HTTP_400_BAD_REQUEST)

        self.perform_create(serializer)
        return Response({"detail": "Favourite added successfully."}, status=status.HTTP_201_CREATED)

    @action(detail=False, methods=['delete'], url_path='remove')
    def remove_favourite(self, request):
        # user_id = request.data.get('user')
        hotel_id = request.data.get('hotel')

        if not hotel_id :
            return Response({"error": " Hotel ID are required."}, status=status.HTTP_400_BAD_REQUEST)

        instance = Favourites.objects.filter(user=request.user, hotel_id=hotel_id).first()

        if instance:
            instance.delete()
            return Response({"detail": "Favourite removed successfully."}, status=status.HTTP_204_NO_CONTENT)

        return Response({"error": "Favourite not found."}, status=status.HTTP_404_NOT_FOUND)





class RegisterView(APIView):
    parser_classes = (JSONParser,MultiPartParser, FormParser)

    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            try:
                user = serializer.save()
                return Response({'message': 'User created successfully', 'user': serializer.data}, status=status.HTTP_201_CREATED)
            except ValidationError as ve:
                return Response({'error': str(ve)}, status=status.HTTP_400_BAD_REQUEST)
            except Exception as e:
                return Response({'error': 'Server error occurred'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LoginView(APIView):
    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')

        if not email or not password:
            return Response({'error': 'Email and password are required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

        user = authenticate(request, username=user.username, password=password) 
        if user is not None:
            refresh = RefreshToken.for_user(user)
            return Response({
                'user': {'id': user.id, 'username': user.username, 'email': user.email},
                'tokens': {'refresh': str(refresh), 'access': str(refresh.access_token)}
            }, status=status.HTTP_200_OK)

        return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

class LogoutView(APIView):
    permission_classes = [IsAuthenticated]
 

    def post(self, request):
        try:
            refresh_token = request.data.get("refresh_token")

            if not refresh_token:
                return Response({"error": "Refresh token is required"}, status=status.HTTP_400_BAD_REQUEST)
            RefreshToken(refresh_token).blacklist()
            return Response({"message": "Logout successful"}, status=status.HTTP_205_RESET_CONTENT)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        


        
# Test login
# {
#     "email":"a9a0a2@a3a.com",
#     "password":"a9a1515151a"
# }
        




def usage(request):
    return render(request,"api/usage_doc.html")        





class PaymentViewSet(viewsets.ModelViewSet):
    serializer_class = PaymentSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Payment.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=False, methods=['post'])
    def make_payment(self, request):
       
        booking_id = request.data.get('booking_id')
        payment_method_id = request.data.get('payment_method_id')
        payment_subtotal = request.data.get('payment_subtotal')
        payment_totalamount = request.data.get('payment_totalamount')
        payment_currency = request.data.get('payment_currency')
        payment_type = request.data.get('payment_type')
        transfer_image = request.FILES.get('transfer_image') 
        payment_note = request.data.get('payment_note', '')
        payment_discount = request.data.get('payment_discount', 0)

        if not all([booking_id, payment_method_id, payment_subtotal, payment_totalamount, payment_currency, payment_type]):
            return Response(
                {'error': 'All fields except payment_note are required.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            booking = Booking.objects.get(id=booking_id)
        except Booking.DoesNotExist:
            return Response({'error': 'Booking not found'}, status=status.HTTP_404_NOT_FOUND)

        try:
            payment_method = HotelPaymentMethod.objects.get(id=payment_method_id)
        except HotelPaymentMethod.DoesNotExist:
            return Response({'error': 'Payment method not found'}, status=status.HTTP_404_NOT_FOUND)

        payment = Payment(
            booking=booking,
            payment_method=payment_method,
            payment_subtotal=payment_subtotal,
            payment_totalamount=payment_totalamount,
            payment_currency=payment_currency,
            payment_type=payment_type,
            transfer_image=transfer_image, 
            payment_note=payment_note,
            payment_discount=payment_discount,
            payment_status=0 
        )

        payment.save()

        serializer = PaymentSerializer(payment)

        return Response(serializer.data, status=status.HTTP_201_CREATED)




class BookingViewSet(viewsets.ModelViewSet):
    serializer_class = BookingSerializer
    permission_classes = [IsAuthenticated]


    def get_queryset(self):
        return Booking.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=False, methods=['post'])
    def create_booking(self, request):
    
        hotel_id = request.data.get('hotel_id')
        room_id = request.data.get('room_id')
        check_in_date = request.data.get('check_in_date')
        check_out_date = request.data.get('check_out_date')
        amount = request.data.get('amount')
        rooms_booked = request.data.get('rooms_booked', 1)
        
        user = get_object_or_404(CustomUser, id=request.user.id)

        if not all([hotel_id, room_id, check_in_date, check_out_date, amount]):
            return Response({'error': 'Missing required fields'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            hotel = Hotel.objects.get(id=hotel_id)
        except Hotel.DoesNotExist:
            return Response({'error': 'Hotel not found'}, status=status.HTTP_404_NOT_FOUND)

        try:
            room = RoomType.objects.get(id=room_id)
        except RoomType.DoesNotExist:
            return Response({'error': 'Room type not found'}, status=status.HTTP_404_NOT_FOUND)

        booking = Booking.objects.create(
            hotel=hotel,
            user=user,
            room=room,
            check_in_date=check_in_date,
            check_out_date=check_out_date,
            amount=amount,
            rooms_booked=rooms_booked
        )

        serializer = BookingSerializer(booking)

        return Response(serializer.data, status=status.HTTP_201_CREATED)





class NotificationsViewSet(viewsets.ModelViewSet):
    serializer_class = NotificationsSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Notifications.objects.filter(user=self.request.user, is_active=True).order_by('-send_time')
        # return Notifications.objects.all().order_by('-send_time')

    @action(detail=True, methods=['post'])
    def mark_as_read(self, request, pk=None):
        notification = self.get_object()
        notification.mark_as_read()  
        return Response({'status': 'notification marked as read'}, status=status.HTTP_200_OK)



# booking------------------
# {
#   "hotel":1,
#           "room" :1,
#         "check_in_date":"2025-03-22",
#         "check_out_date": "2025-03-25",
#         "amount": "1500",
#         "rooms_booked" : 4
# }