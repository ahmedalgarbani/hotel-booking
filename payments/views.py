from django.shortcuts import render

# Create your views here.

def user_dashboard_index(request):
    return render(request,'admin/user_dashboard/index.html')

def user_dashboard_bookings(request):
    return render(request,'admin/user_dashboard/pages/user-bookings.html')
def user_dashboard_settings(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-settings.html')
def user_dashboard_wishlist(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-wishlist.html')
def user_dashboard_reviews(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-reviews.html')
def user_dashboard_profile(request):
    return render(request,'admin/user_dashboard/pages/user-dashboard-profile.html')
