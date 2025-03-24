from django.urls import path, include
from django.views import View
from rest_framework.routers import DefaultRouter

from customer.models import Favourites
from .views import NotificationsViewSet,BookingViewSet, PaymentViewSet, HotelPaymentMethodViewSet, HotelsViewSet, RoomsViewSet, LoginView, RegisterView,LogoutView,FavouritesViewSet, usage
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView
)

# Test
router = DefaultRouter()
router.register(r'hotels', HotelsViewSet, basename='hotels')
router.register(r'favourites', FavouritesViewSet, basename='favourite')
router.register(r'hotel-payment-methods', HotelPaymentMethodViewSet, basename='hotel-payment-methods')
router.register(r'payment', PaymentViewSet, basename='payment')
router.register(r'bookings', BookingViewSet,basename='booking')
router.register(r'notifications', NotificationsViewSet,basename='notification')

urlpatterns = [
    
    path('', include(router.urls)),

    #  JWT Token endpoints
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
    #  JWT authentication endpoints
    path('register/', RegisterView.as_view(), name='register'), 
    path('login/', LoginView.as_view(), name='login'),  
    path('logout/', LogoutView.as_view(), name='logout'),  
    path('usage/', usage, name='usage'),  
]
