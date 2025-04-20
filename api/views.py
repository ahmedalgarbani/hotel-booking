import re
from django.shortcuts import get_object_or_404, redirect, render
from httpx import request
from rest_framework.exceptions import ValidationError
from rest_framework import viewsets
from HotelManagement.services import get_hotels_query, get_query_params
from HotelManagement.views import hotel_search
from api.api_services import call_gemini_api
from bookings.models import Booking
from customer.models import Favourites
from notifications.models import Notifications
from payments.models import HotelPaymentMethod, Payment
from rooms.models import Availability, Category, RoomType
from HotelManagement.models import Hotel
from users.models import CustomUser
from .serializers import BookingSerializer, CategorySerializer, ChangePasswordSerializer, FavouritesSerializer, HotelAvabilitySerializer, HotelPaymentMethodSerializer, NotificationsSerializer, PaymentSerializer, RoomsSerializer, HotelSerializer, RegisterSerializer, UserProfileSerializer, UserSerializer
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
from django.db.models import Sum
from datetime import datetime, timedelta
from django.db.models import Sum, Count, Subquery,OuterRef
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
 
User = get_user_model()
# Views

class CustomPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 50

class HotelsViewSet(viewsets.ModelViewSet):
    queryset = Hotel.objects.filter(is_verified=True)
    serializer_class = HotelSerializer
    pagination_class = CustomPagination
    filterset_fields = ['location', 'services__name']
    search_fields = ['name', 'description', 'location__address']
    ordering_fields = ['name', 'created_at']

    @action(detail=False, methods=['get'])
    def search(self, request):
        hotel_name = request.query_params.get('name', '').strip()
        location = request.query_params.get('location', '').strip()
        adult_number = request.query_params.get('adult_number', '').strip()
        check_in = request.query_params.get('check_in', '').strip()
        check_out = request.query_params.get('check_out', '').strip()
        room_number = request.query_params.get('room_number', 1)
        category_type = request.query_params.get('category_type', '').strip()

        if not any([hotel_name, location, adult_number, room_number,category_type,check_in,check_out]):
            return Response({'error': 'Provide at least one search parameter'}, status=status.HTTP_400_BAD_REQUEST)

        queryset = Hotel.objects.all()

        if hotel_name:
            queryset = queryset.filter(name__icontains=hotel_name)

        if location:
            queryset = queryset.filter(location__address__icontains=location)

        if category_type:
            queryset = queryset.filter(room_types__category__name__icontains=category_type)

        if adult_number:
            try:
                adult_number = int(adult_number)
                queryset = queryset.annotate(
                    total_capacity=Sum('room_types__default_capacity')
                ).filter(total_capacity__gte=adult_number)
            except ValueError:
                return Response({'error': 'Invalid adult number format'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            room_number = int(room_number) if room_number else None
            if check_in and check_out:
                check_in_date = datetime.strptime(check_in, "%Y-%m-%d").date()
                check_out_date = datetime.strptime(check_out, "%Y-%m-%d").date()

                if check_in_date >= check_out_date:
                    return Response({'error': 'Check-out must be after check-in'}, status=status.HTTP_400_BAD_REQUEST)

                total_days = (check_out_date - check_in_date).days

                if room_number and room_number > 0:
                    avail_room_types = Availability.objects.filter(
                        availability_date__range=[check_in_date, check_out_date - timedelta(days=1)],
                        # availability_date__range=[check_in, check_out],
                        available_rooms__gte=room_number
                    ).values('room_type') \
                    .annotate(available_days=Count('id')) \
                    .filter(available_days=total_days) \
                    .values_list('room_type', flat=True)
                    queryset = queryset.filter(room_types__id__in=avail_room_types)
                
            else:
                queryset = queryset.annotate(
                    latest_avail=Subquery(
                        RoomType.objects.filter(
                            hotel=OuterRef('pk')
                        ).values('rooms_count')[:1]
                    )
                ).filter(latest_avail__gte=room_number)

        except ValueError:
            return Response({'error': 'Invalid date or room number format'}, status=status.HTTP_400_BAD_REQUEST)

        paginated_queryset = self.paginate_queryset(queryset.distinct())
        serializer = HotelSerializer(paginated_queryset, many=True, context={'request': request})
        return self.get_paginated_response(serializer.data)


class HotelPaymentMethodViewSet(viewsets.ModelViewSet):
    pagination_class = CustomPagination

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
    
class CategoriesViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.filter(status = True)
    serializer_class = CategorySerializer


class FavouritesViewSet(viewsets.ModelViewSet):
    serializer_class = FavouritesSerializer
    permission_classes = [IsAuthenticated]
    pagination_class = CustomPagination


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
    serializer_class = UserSerializer

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
            serializer = self.serializer_class(user, context={'request': request})
            return Response({
                'user': serializer.data,
                'tokens': {
                    'refresh': str(refresh),
                    'access': str(refresh.access_token),
                }
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
    pagination_class = CustomPagination


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
            user = request.user,
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
    pagination_class = CustomPagination

    def get_queryset(self):
        return Booking.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=False, methods=['post'])
    def create_booking(self, request):
        required_fields = ["hotel_id", "room_id", "check_in_date", "check_out_date", "amount"]
        missing_fields = [field for field in required_fields if not request.data.get(field)]

        if missing_fields:
            return Response(
                {"error": f"Missing required fields: {', '.join(missing_fields)}"},
                status=status.HTTP_400_BAD_REQUEST
            )

        hotel_id = request.data["hotel_id"]
        room_id = request.data["room_id"]
        check_in_date = request.data["check_in_date"]
        check_out_date = request.data["check_out_date"]
        amount = request.data["amount"]
        rooms_booked = request.data.get("rooms_booked", 1)

        user = get_object_or_404(CustomUser, id=request.user.id)

        hotel = get_object_or_404(Hotel, id=hotel_id)
        room = get_object_or_404(RoomType, id=room_id)

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
    pagination_class = CustomPagination

    def get_queryset(self):
        return Notifications.objects.filter(user=self.request.user, is_active=True).order_by('-send_time')
        # return Notifications.objects.all().order_by('-send_time')

    @action(detail=True, methods=['post'])
    def mark_as_read(self, request, pk=None):
        notification = self.get_object()
        notification.mark_as_read()  
        return Response({'status': 'notification marked as read'}, status=status.HTTP_200_OK)



    
class HotelAvailabilityViewSet(APIView):
    def get(self, request):
        
        hotel_name, check_in, check_out, adult_number, room_number, category_type = get_query_params(request)
        hotels_query, error_message = get_hotels_query(hotel_name, category_type, room_number, adult_number, check_in, check_out)
    
        serializer = HotelSerializer(hotels_query, many=True, context={'request': request})
        return Response({
            'adult_number': adult_number,
            'check_in_start': check_in.strftime('%m/%d/%Y') if check_in else '',
            'check_out_start': check_out.strftime('%m/%d/%Y') if check_out else '',
            'hotels': serializer.data,
            'error_message': error_message,
        }, status=status.HTTP_200_OK)







# class UserProfileView(APIView):
#     permission_classes = [IsAuthenticated]

#     def get(self, request):
#         serializer = UserSerializer(request.user)
#         return Response(serializer.data)



# http://127.0.0.1:8000/api/hotel_availability/?hotel_name=hotel_name&check_in=2025-03-25 00:00:00&check_out=2025-03-28 00:00:00&adult_number=1&room_number=1&category_type=1




@api_view(['POST'])
def call_gemini_chat_bot(request):
    prompt = request.data.get('prompt')
    
    if not prompt:
        return Response({"message": "Prompt is required."}, status=400)
    
    message = call_gemini_api(prompt=prompt)


    if message:
        return Response({
            "message": message,
        }, status=200)
    else:
        return Response({"message": "Failed to get response from Gemini API."}, status=500)



from django.db.models import Prefetch
@api_view(['POST'])
def get_best_hotels_by_gemini(request):
    prompt = request.data.get('prompt', "اريد منك عرض كل الفنادق")
    hotels = Hotel.objects.filter(is_verified=True).prefetch_related(
        'hotel_services',
        Prefetch('images'),
        Prefetch('room_types__room_services'),
        Prefetch('payment_methods__payment_option__currency')
    ).select_related('location')

    hotel_list = []

    for hotel in hotels:
        hotel_data = {
            "id": hotel.id,
            "name": hotel.name,
            "profile_picture": request.build_absolute_uri(hotel.profile_picture.url) if hotel.profile_picture else None,
            "description": hotel.description,
            "location": hotel.location.address if hotel.location else None,
            "services": [
                {
                    "id": service.id,
                    "name": service.name,
                }
                for service in hotel.hotel_services.all()
            ],
            "rooms": [],
            "paymentOption": [],
        }

        for room in hotel.room_types.all():
            room_data = {
                "id": room.id,
                "images": [
                    {
                        "id": img.id,
                        "image_url": request.build_absolute_uri(img.image.url) if img.image else None,
                        "is_main": img.is_main,
                        "caption": img.caption,
                    }
                    for img in room.images.all()
                ],
                "services": [
                    {
                        "id": srv.id,
                        "name": srv.name,
                        "description": srv.description,
                        "icon": request.build_absolute_uri(srv.icon.url) if srv.icon else None,
                        "additional_fee": srv.additional_fee,
                    }
                    for srv in room.room_services.all()
                ],

                "name": room.name,
                "description": room.description,
                "default_capacity": room.default_capacity,
                "max_capacity": room.max_capacity,
                "beds_count": room.beds_count,
                "rooms_count": room.rooms_count,
                "base_price": str(room.base_price),          
                "hotel": hotel.id,
                "category": room.category.id if room.category else None,
            }
            hotel_data["rooms"].append(room_data)

        for payment in hotel.payment_methods.all():
            payment_data = {
                "id": payment.id,
                "payment_option": {
                    "id": payment.payment_option.id,
                    "method_name": payment.payment_option.method_name,
                    "logo": request.build_absolute_uri(payment.payment_option.logo.url) if payment.payment_option.logo else None,
                    "currency": {
                        "id": payment.payment_option.currency.id,
                        "currency_name": payment.payment_option.currency.currency_name,
                        "currency_symbol": payment.payment_option.currency.currency_symbol,
                    },
                },

                "account_name": payment.account_name,
                "account_number": payment.account_number,
                "iban": payment.iban,
                "description": payment.description,
                "hotel": hotel.id,
            }
            hotel_data["paymentOption"].append(payment_data)

        hotel_list.append(hotel_data)
    result = call_gemini_api(prompt=prompt,text=hotel_list)
    if result:
        return Response({
            "result": result,
        }, status=200)
    else:
        return Response({"message": "Failed to get response from Gemini API."}, status=500)




class UserProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = UserProfileSerializer(request.user)
        return Response(serializer.data)

    def put(self, request):
        serializer = UserProfileSerializer(request.user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    





class ChangePasswordView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = ChangePasswordSerializer(data=request.data)
        user = request.user

        if serializer.is_valid():
            old_password = serializer.validated_data['old_password']
            new_password = serializer.validated_data['new_password']

            if not user.check_password(old_password):
                return Response({"error": "the old password is Wrong."}, status=status.HTTP_400_BAD_REQUEST)

            user.set_password(new_password)
            user.save()
            return Response({"detail": "Password changed successfully."}, status=status.HTTP_200_OK)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    


    
# booking------------------
# {
#   "hotel":1,
#           "room" :1,
#         "check_in_date":"2025-03-22",
#         "check_out_date": "2025-03-25",
#         "amount": "1500",
#         "rooms_booked" : 4
# }

