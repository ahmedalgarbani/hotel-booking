from django.shortcuts import get_object_or_404, render
from rest_framework.exceptions import ValidationError
from rest_framework import viewsets
from rooms.models import RoomType
from HotelManagement.models import Hotel
from users.models import CustomUser
from .serializers import RoomsSerializer, HotelSerializer, RegisterSerializer
from django.contrib.auth import authenticate, get_user_model
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status, permissions
from django.db.utils import IntegrityError
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser,JSONParser
from django.core.exceptions import ValidationError
from datetime import datetime
from django.core.exceptions import ValidationError


User = get_user_model()
# Views
class HotelsViewSet(viewsets.ModelViewSet):
    queryset = Hotel.objects.all()
    serializer_class = HotelSerializer

class RoomsViewSet(viewsets.ModelViewSet):
    queryset = RoomType.objects.all()
    serializer_class = RoomsSerializer

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
            tokens = {
                'refresh': str(RefreshToken.for_user(user)),
                'access': str(RefreshToken.for_user(user).access_token),
            }
            return Response({'user': {'id': user.id, 'username': user.username, 'email': user.email}, 'tokens': tokens}, status=status.HTTP_200_OK)
        return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

class LogoutView(APIView):
    permission_classes = [permissions.IsAuthenticated]
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