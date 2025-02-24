from django.shortcuts import get_object_or_404, render
from rooms.models import RoomType
from HotelManagement.models import Hotel

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

# hotel -------------
def hotel_manager_dashboard_index(request):
    return render(request,'admin/hotel_manager_dashboard/index.html')
def admin_dashboard_booking(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-booking.html')
def admin_payments(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-payments.html')
def admin_invoice(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-invoice.html')
def admin_dashboard_wishlist(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-wishlist.html')
def admin_dashboard_users(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-users.html')
def admin_dashboard_user_detail(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-user-detail.html')
def admin_dashboard_settings(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-settings.html')
def admin_dashboard_reviews(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-reviews.html')
def admin_dashboard_orders(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-orders.html')
def admin_dashboard_orders_detail(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-dashboard-orders-details.html')
def admin_currency_list(request):
    return render(request,'admin/hotel_manager_dashboard/pages/admin-currency-list.html')


#خطوة ثاني بعد مناقشة المشرف اضافة السلة 
def cart(request,room_id):
    room = get_object_or_404(RoomType, id=room_id)
    return render(request,'frontend/home/pages/checkout.html',{'room_type':room})




#ارسال الى صفحة الدفع بيانات الغرفة 
def checkout(request, room_id):
    room = get_object_or_404(RoomType, id=room_id)
    hotel = get_object_or_404(Hotel,id=room.hotel_id)

    paymentsMethods = hotel.payment_methods.all()

   
    # حساب الضرائب والسعر الكلي
    tax = 5  #قيمة الضريبة 
    total_price = room.base_price + tax
    
    context = {
        'room': room,
        'tax': tax,
        'total_price': total_price,
        'paymentsMethods':paymentsMethods,
    }
    return render(request, 'frontend/home/pages/checkout.html', context)
