
from django.urls import path
from . import views


app_name = 'payments'
urlpatterns = [
    
    path('',views.user_dashboard_index,name='user_dashboard_index'),
    path('user-dashboard/bookings',views.user_dashboard_bookings,name='user_dashboard_bookings'),
    path('user-dashboard/settings',views.user_dashboard_settings,name='user_dashboard_settings'),
    path('user-dashboard/wishlist',views.user_dashboard_wishlist,name='user_dashboard_wishlist'),
    path('user-dashboard/reviews',views.user_dashboard_reviews,name='user_dashboard_reviews'),
    path('user-dashboard/profile',views.user_dashboard_profile,name='user_dashboard_profile'),
]
