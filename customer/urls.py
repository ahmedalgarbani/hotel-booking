from django.urls import path
from . import views

app_name = 'customer'

urlpatterns = [
    path('', views.user_dashboard_index, name='user_dashboard_index'),
    path('user-dashboard/bookings', views.user_dashboard_bookings, name='user_dashboard_bookings'),
    path('cancel/<int:booking_id>/', views.cancel_booking, name='cancel_booking'),
    
    # تعديل المسار settings ليكون مميزًا
 path('user-dashboard/settings/email', views.user_dashboard_settings_email, name='user_dashboard_settings_email'),
    path('user-dashboard/settings/password', views.user_dashboard_settings_password, name='user_dashboard_settings_password'),
    path('user-dashboard/settings', views.user_dashboard_settings, name='user_dashboard_settings'),
    
    path('user-dashboard/wishlist', views.user_dashboard_wishlist, name='user_dashboard_wishlist'),
    path('user-add-to-wishlist', views.add_to_favorites, name='add_to_favorites'),
    path('user-dashboard/reviews', views.user_dashboard_reviews, name='user_dashboard_reviews'),
    path('user-dashboard/profile', views.user_dashboard_profile, name='user_dashboard_profile'),
    
    # المسار الخاص بحذف المفضلة
    path('remove_favourite/<int:favourite_id>/', views.remove_favourite, name='remove_favourite'),
]
