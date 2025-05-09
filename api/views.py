import random
import re
from django.shortcuts import get_object_or_404, redirect, render
from httpx import request
from rest_framework.exceptions import ValidationError
from rest_framework import viewsets
from HotelManagement.services import get_hotels_query, get_query_params
from HotelManagement.views import hotel_search
from api.api_services import call_gemini_api
from bookings.models import Booking, Guest
from customer.models import Favourites
from notifications.models import Notifications
from payments.models import HotelPaymentMethod, Payment
from reviews.models import HotelReview, RoomReview
from rooms.models import Availability, Category, RoomType
from HotelManagement.models import Hotel
from users.models import CustomUser
from users.utils import send_sms_via_sadeem
from .serializers import (
    BookingSerializer, CategorySerializer, ChangePasswordSerializer,
    FavouritesSerializer, GuestSerializer, HotelAvabilitySerializer,
    HotelPaymentMethodSerializer, HotelReviewSerializer, NotificationsSerializer, PaymentSerializer, RoomReviewSerializer,
    RoomsSerializer, HotelSerializer, RegisterSerializer, UserProfileSerializer,
    UserSerializer
)
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
from datetime import datetime, timedelta, timezone
from django.db.models import Sum, Count, Subquery,OuterRef
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from datetime import datetime

User = get_user_model()
# Views

class CustomPagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    max_page_size = 50

class HotelsViewSet(viewsets.ModelViewSet):
    queryset = Hotel.objects.all()
    serializer_class = HotelSerializer

    @action(detail=False, methods=['get'])
    def search(self, request):
        hotel_name = request.query_params.get('name', '').strip()
        location = request.query_params.get('location', '').strip()
        adult_number = request.query_params.get('adult_number', '').strip()
        check_in = request.query_params.get('check_in', '').strip()
        check_out = request.query_params.get('check_out', '').strip()
        category_type = request.query_params.get('category_type', '').strip()
        
        try:
            room_number = int(request.query_params.get('room_number', 1))
        except ValueError:
            return Response({'error': 'Invalid room number format'}, status=status.HTTP_400_BAD_REQUEST)

        if not any([hotel_name, location, adult_number, room_number, category_type, check_in, check_out]):
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
            if check_in and check_out:
                check_in_date = datetime.strptime(check_in, "%Y-%m-%d").date()
                check_out_date = datetime.strptime(check_out, "%Y-%m-%d").date()

                if check_in_date >= check_out_date:
                    return Response({'error': 'Check-out must be after check-in'}, status=status.HTTP_400_BAD_REQUEST)

                total_days = (check_out_date - check_in_date).days + 1

                avail_room_types = Availability.objects.filter(
                    availability_date__range=[check_in_date, check_out_date],
                    available_rooms__gte=room_number
                ).values('room_type') \
                .annotate(available_days=Count('id')) \
                .filter(available_days=total_days) \
                .values_list('room_type', flat=True)

                queryset = queryset.filter(room_types__id__in=avail_room_types)

            elif room_number and room_number > 0:
                queryset = queryset.annotate(
                    latest_avail=Subquery(
                        RoomType.objects.filter(
                            hotel=OuterRef('pk')
                        ).values('rooms_count')[:1]
                    )
                ).filter(latest_avail__gte=room_number)

        except ValueError:
            return Response({'error': 'Invalid date format'}, status=status.HTTP_400_BAD_REQUEST)

        paginated_queryset = self.paginate_queryset(queryset.distinct())
        serializer = HotelSerializer(
            paginated_queryset,
            many=True,
            context={
                'request': request,
                'check_in': check_in,
                'check_out': check_out,
                'room_number': room_number,
                'adult_number':adult_number
            }
        )
        return self.get_paginated_response(serializer.data)


class RoomReviewViewSet(viewsets.ModelViewSet):
    queryset = RoomReview.objects.filter(status=True)
    serializer_class = RoomReviewSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class HotelReviewViewSet(viewsets.ModelViewSet):
    queryset = HotelReview.objects.filter(status=True)
    serializer_class = HotelReviewSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


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
        required_fields = ["hotel_id", "room_id", "check_in_date", "check_out_date"]
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
        rooms_booked = int(request.data.get("rooms_booked", 1))
        extra_services = request.data.get("extra_services", [])

        user = get_object_or_404(CustomUser, id=request.user.id)
        hotel = get_object_or_404(Hotel, id=hotel_id)
        room = get_object_or_404(RoomType, id=room_id)

        # التحقق من توافر الغرف
        from datetime import datetime
        today_date = datetime.now().date()
        check_in_date_obj = datetime.strptime(check_in_date, '%Y-%m-%d').date() if isinstance(check_in_date, str) else check_in_date
        check_out_date_obj = datetime.strptime(check_out_date, '%Y-%m-%d').date() if isinstance(check_out_date, str) else check_out_date

        from HotelManagement.services import check_room_availability_full
        is_available, message = check_room_availability_full(
            today_date=today_date,
            hotel=hotel,
            room_type=room,
            required_rooms=rooms_booked,
            check_in=check_in_date_obj,
            check_out=check_out_date_obj
        )

        if not is_available:
            return Response({"error": message}, status=status.HTTP_400_BAD_REQUEST)

        # حساب السعر الإجمالي
        from rooms.services.pricing import calculate_total_cost
        from services.models import RoomTypeService

        total_price, room_price = calculate_total_cost(room, check_in_date_obj, check_out_date_obj, rooms_booked)

        # إضافة تكلفة الخدمات الإضافية
        extra_services_total = 0
        extra_services_details = []

        if extra_services:
            try:
                # التحقق من وجود الخدمات المطلوبة
                valid_service_ids = list(RoomTypeService.objects.filter(
                    id__in=extra_services,
                    room_type=room,
                    hotel=hotel
                ).values_list('id', flat=True))

                # استخدام فقط معرفات الخدمات الصالحة
                services = RoomTypeService.objects.filter(id__in=valid_service_ids)
                days_count = (check_out_date_obj - check_in_date_obj).days

                for service in services:
                    service_price = float(service.additional_fee)
                    service_total = service_price * rooms_booked * days_count
                    extra_services_total += service_total
                    extra_services_details.append({
                        "id": service.id,
                        "name": service.name,
                        "price": service_price,
                        "total": service_total
                    })

                # إذا كانت هناك خدمات غير صالحة، أضف تحذير
                invalid_services = set(extra_services) - set(valid_service_ids)
                if invalid_services:
                    print(f"Warning: Services with IDs {invalid_services} not found for room {room.id}")
            except Exception as e:
                print(f"Error processing services: {str(e)}")
                # استمر بدون خدمات إضافية في حالة حدوث خطأ
                extra_services_total = 0
                extra_services_details = []

        grand_total = total_price + extra_services_total

        # إنشاء الحجز
        booking = Booking.objects.create(
            hotel=hotel,
            user=user,
            room=room,
            check_in_date=check_in_date,
            check_out_date=check_out_date,
            amount=grand_total,
            rooms_booked=rooms_booked
        )

        # إضافة تفاصيل الخدمات الإضافية إلى جدول BookingDetail
        from bookings.models import BookingDetail

        if extra_services_details:  # استخدم extra_services_details بدلاً من extra_services
            days_count = (check_out_date_obj - check_in_date_obj).days
            for service_detail in extra_services_details:
                try:
                    service = RoomTypeService.objects.get(id=service_detail["id"])
                    BookingDetail.objects.create(
                        booking=booking,
                        hotel=hotel,
                        service=service,
                        quantity=rooms_booked * days_count,
                        price=service_detail["price"],
                        notes=f"خدمة إضافية للحجز - {service.name}"
                    )
                except RoomTypeService.DoesNotExist:
                    print(f"Warning: Service with ID {service_detail['id']} not found when creating BookingDetail")
                except Exception as e:
                    print(f"Error creating BookingDetail: {str(e)}")

        serializer = BookingSerializer(booking)
        response_data = serializer.data
        response_data.update({
            "price_details": {
                "room_price": room_price,
                "total_room_cost": total_price,
                "extra_services_cost": extra_services_total,
                "extra_services": extra_services_details,
                "grand_total": grand_total,
                "days_count": (check_out_date_obj - check_in_date_obj).days
            }
        })

        return Response(response_data, status=status.HTTP_201_CREATED)
#يعرض تفاصيل التكلفة وتوافر الغرفة دون إنشاء الحجز.
    @action(detail=False, methods=['post'])
    def calculate_booking_price(self, request):
        """
        Calculate the booking price without creating a booking.
        This allows the user to see the price breakdown before confirming.
        """
        required_fields = ["hotel_id", "room_id", "check_in_date", "check_out_date"]
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
        rooms_booked = int(request.data.get("rooms_booked", 1))
        extra_services = request.data.get("extra_services", [])

        hotel = get_object_or_404(Hotel, id=hotel_id)
        room = get_object_or_404(RoomType, id=room_id)

        # التحقق من توافر الغرف
        from datetime import datetime
        today_date = datetime.now().date()
        check_in_date_obj = datetime.strptime(check_in_date, '%Y-%m-%d').date() if isinstance(check_in_date, str) else check_in_date
        check_out_date_obj = datetime.strptime(check_out_date, '%Y-%m-%d').date() if isinstance(check_out_date, str) else check_out_date

        # التحقق من توافر الغرف (اختياري في هذه المرحلة)
        from HotelManagement.services import check_room_availability_full
        is_available, message = check_room_availability_full(
            today_date=today_date,
            hotel=hotel,
            room_type=room,
            required_rooms=rooms_booked,
            check_in=check_in_date_obj,
            check_out=check_out_date_obj
        )

        if not is_available:
            return Response({"error": message, "is_available": False}, status=status.HTTP_200_OK)

        # حساب سعر الغرفة
        from rooms.services.pricing import calculate_total_cost
        from services.models import RoomTypeService

        total_price, room_price = calculate_total_cost(room, check_in_date_obj, check_out_date_obj, rooms_booked)

        # حساب تكلفة الخدمات الإضافية
        extra_services_total = 0
        extra_services_details = []

        if extra_services:
            try:
                # التحقق من وجود الخدمات المطلوبة
                valid_service_ids = list(RoomTypeService.objects.filter(
                    id__in=extra_services,
                    room_type=room
                ).values_list('id', flat=True))

                # استخدام فقط معرفات الخدمات الصالحة
                services = RoomTypeService.objects.filter(id__in=valid_service_ids)
                days_count = (check_out_date_obj - check_in_date_obj).days

                for service in services:
                    service_price = float(service.additional_fee)
                    service_total = service_price * rooms_booked * days_count
                    extra_services_total += service_total
                    extra_services_details.append({
                        "id": service.id,
                        "name": service.name,
                        "price": service_price,
                        "total": service_total
                    })

                # إذا كانت هناك خدمات غير صالحة، أضف تحذير
                invalid_services = set(extra_services) - set(valid_service_ids)
                if invalid_services:
                    print(f"Warning: Services with IDs {invalid_services} not found for room {room.id}")
            except Exception as e:
                print(f"Error processing services: {str(e)}")
                # استمر بدون خدمات إضافية في حالة حدوث خطأ
                extra_services_total = 0
                extra_services_details = []

        grand_total = total_price + extra_services_total

        # إرجاع تفاصيل السعر
        return Response({
            "is_available": True,
            "price_details": {
                "room_price": room_price,
                "total_room_cost": total_price,
                "extra_services_cost": extra_services_total,
                "extra_services": extra_services_details,
                "grand_total": grand_total,
                "days_count": (check_out_date_obj - check_in_date_obj).days,
                "hotel_name": hotel.name,
                "room_name": room.name,
                "rooms_booked": rooms_booked,
                "check_in_date": check_in_date,
                "check_out_date": check_out_date
            }
        }, status=status.HTTP_200_OK)




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


class GuestViewSet(viewsets.ModelViewSet):
    """
    API endpoint لإدارة الضيوف (Guest)
    يتيح إنشاء وعرض وتعديل وحذف بيانات الضيوف
    ويربط الضيوف تلقائيًا بصاحب الحجز
    """
    serializer_class = GuestSerializer
    pagination_class = CustomPagination
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        """
        الحصول على قائمة الضيوف حسب صلاحيات المستخدم
        """
        user = self.request.user
        
        # للاختبار فقط: إذا كان المستخدم غير مصادق (مجهول)، اعرض جميع الضيوف
        if user.is_anonymous:
            return Guest.objects.all().order_by('-created_at')
        
        # إذا كان المستخدم مسؤولاً (admin) أو مشرفاً (staff) أو مدير فندق يمكنه رؤية جميع الضيوف
        if user.is_staff or user.is_superuser or getattr(user, 'user_type', '') == 'hotel_manager':
            return Guest.objects.all().order_by('-created_at')
        
        # للمستخدم العادي، يمكنه رؤية الضيوف المرتبطين بحجوزاته فقط
        return Guest.objects.filter(booking__user=user).order_by('-created_at')

    def create(self, request, *args, **kwargs):
        """
        إنشاء ضيف جديد مرتبط بحجز المستخدم
        """
        # التحقق من وجود رقم الحجز في البيانات المرسلة
        booking_id = request.data.get('booking')
        if not booking_id:
            return Response(
                {"error": "يجب تحديد رقم الحجز لإضافة ضيف"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # التحقق من وجود الحجز
        try:
            booking = Booking.objects.get(id=booking_id)
            
            # للاختبار فقط: تخطي التحقق من صاحب الحجز للمستخدم المجهول
            if not request.user.is_anonymous:
                # التحقق من أن المستخدم هو صاحب الحجز أو لديه صلاحيات خاصة
                if booking.user != request.user and not request.user.is_staff and getattr(request.user, 'user_type', '') != 'hotel_manager':
                    return Response(
                        {"error": "لا يمكنك إضافة ضيوف لحجز لا يخصك"},
                        status=status.HTTP_403_FORBIDDEN
                    )
            
            # إضافة معرف الفندق تلقائيًا من الحجز إذا لم يتم توفيره
            data = request.data.copy()
            if 'hotel' not in data:
                data['hotel'] = booking.hotel.id
            
            serializer = self.get_serializer(data=data)
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
            
        except Booking.DoesNotExist:
            return Response(
                {"error": "الحجز غير موجود"},
                status=status.HTTP_404_NOT_FOUND
            )

    def perform_create(self, serializer):
        """
        حفظ بيانات الضيف وربطه بالمستخدم صاحب الحجز
        """
        guest = serializer.save()

        # تعيين تواريخ الوصول والمغادرة من الحجز إذا لم يتم تحديدها
        if guest.booking and (not guest.check_in_date or not guest.check_out_date):
            if not guest.check_in_date and guest.booking.check_in_date:
                guest.check_in_date = guest.booking.check_in_date

            if not guest.check_out_date and guest.booking.check_out_date:
                guest.check_out_date = guest.booking.check_out_date

            guest.save()

    @action(detail=False, methods=['post'], url_path='create-multiple')
    def create_multiple(self, request):
        """
        إنشاء مجموعة من الضيوف دفعة واحدة
        يتوقع هذا الإجراء مصفوفة من بيانات الضيوف
        """
        data = request.data

        # التحقق من أن البيانات المرسلة هي مصفوفة
        if not isinstance(data, list):
            return Response(
                {"error": "يجب إرسال مصفوفة من بيانات الضيوف"},
                status=status.HTTP_400_BAD_REQUEST
            )

        # التحقق من أن المستخدم هو صاحب الحجز لكل عنصر
        booking_ids = set()
        for item in data:
            booking_id = item.get('booking')
            if booking_id:
                booking_ids.add(booking_id)

        # التحقق من ملكية الحجوزات
        user = request.user
        if not user.is_staff and not user.user_type == 'hotel_manager':
            for booking_id in booking_ids:
                try:
                    booking = Booking.objects.get(id=booking_id)
                    if booking.user != user:
                        return Response(
                            {"error": f"لا يمكنك إضافة ضيوف للحجز رقم {booking_id} لأنه لا يخصك"},
                            status=status.HTTP_403_FORBIDDEN
                        )
                except Booking.DoesNotExist:
                    return Response(
                        {"error": f"الحجز رقم {booking_id} غير موجود"},
                        status=status.HTTP_404_NOT_FOUND
                    )

        # إنشاء سيريالايزر لكل عنصر في المصفوفة
        serializers = []
        for item in data:
            serializer = self.get_serializer(data=item)
            if serializer.is_valid():
                serializers.append(serializer)
            else:
                # إذا كان هناك خطأ في أي عنصر، إرجاع الخطأ مع رقم العنصر
                return Response(
                    {
                        "error": f"خطأ في العنصر رقم {data.index(item) + 1}",
                        "details": serializer.errors
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )

        # حفظ جميع الضيوف
        created_guests = []
        for serializer in serializers:
            guest = serializer.save()

            # تعيين تواريخ الوصول والمغادرة من الحجز إذا لم يتم تحديدها
            if guest.booking and (not guest.check_in_date or not guest.check_out_date):
                if not guest.check_in_date and guest.booking.check_in_date:
                    guest.check_in_date = guest.booking.check_in_date

                if not guest.check_out_date and guest.booking.check_out_date:
                    guest.check_out_date = guest.booking.check_out_date

                guest.save()

            created_guests.append(serializer.data)

        return Response(created_guests, status=status.HTTP_201_CREATED)




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



from django.utils import timezone
from datetime import timedelta
class SendSMSView(APIView):
    def post(self, request):
        phone_number = request.data.get('phone_number')
        if not phone_number:
            return Response({'error': 'phone_number is required.'}, status=status.HTTP_400_BAD_REQUEST)

        otp_code = ''.join(random.choices('0123456789', k=6))
        otp_created_at = timezone.now()
        message = f"رمز التحقق الخاص بك لتسجيل حساب ديار هو: {otp_code}"
        success = send_sms_via_sadeem(phone_number, message)

        if success:
            request.session['otp_details'] = {
                'code': otp_code,
                'created_at': otp_created_at.isoformat(),
                'phone': phone_number
            }
            request.session.modified = True 
            return Response({'success': True, 'message': 'OTP sent via SMS.'}, status=status.HTTP_200_OK)
        else:
            return Response({'success': False, 'message': 'Failed to send SMS.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class CheckOTPView(APIView):
    def post(self, request):
        phone_number = request.data.get('phone_number')
        otp_code = request.data.get('otp_code')

        if not phone_number or not otp_code:
            return Response({'error': 'phone_number and otp_code are required.'}, status=status.HTTP_400_BAD_REQUEST)

        session_data = request.session.get('otp_details')
        if not session_data:
            return Response({'success': False, 'message': 'No OTP found. Please request a new one.'}, status=status.HTTP_400_BAD_REQUEST)

        stored_code = session_data.get('code')
        stored_phone = session_data.get('phone')
        created_at_str = session_data.get('created_at')

        try:
            created_at = timezone.datetime.fromisoformat(created_at_str).replace(tzinfo=timezone.utc)
        except Exception:
            return Response({'success': False, 'message': 'Invalid OTP data in session.'}, status=status.HTTP_400_BAD_REQUEST)

        if timezone.now() > created_at + timedelta(minutes=5):
            return Response({'success': False, 'message': 'OTP expired. Please request a new one.'}, status=status.HTTP_400_BAD_REQUEST)

        if phone_number != stored_phone or otp_code != stored_code:
            return Response({'success': False, 'message': 'Invalid OTP or phone number.'}, status=status.HTTP_400_BAD_REQUEST)

        del request.session['otp_details']
        return Response({'success': True, 'message': 'OTP verified successfully.'}, status=status.HTTP_200_OK)






# booking ------------------
# {
#   "hotel":1,
#           "room" :1,
#         "check_in_date":"2025-03-22",
#         "check_out_date": "2025-03-25",
#         "amount": "1500",
#         "rooms_booked" : 4
# }

