from django.contrib import admin
from django.utils import timezone
from django.db.models import Sum,Count
from django.db.models.functions import TruncMonth
from HotelManagement.models import *
from bookings.models import *
from rooms.models import RoomImage, RoomPrice, RoomStatus, RoomType, Availability
from users.models import *
from services.models import *
from notifications.models import Notifications
from reviews.models import HotelReview, RoomReview
import datetime

class CustomAdminSite(admin.AdminSite):
    def index(self, request, extra_context=None):
        extra_context = extra_context or {}
        

        today = timezone.now().date()
        start_of_week = today - timezone.timedelta(days=today.weekday())
        bookings_data = []
        for i in range(7):
            day = start_of_week + timezone.timedelta(days=i)
            bookings_count = Booking.objects.filter(created_at__date=day).count()
            bookings_data.append(bookings_count)


        current_year = timezone.now().year
        monthly_payments = Payment.objects.filter(
            payment_status=1,
            payment_date__year=current_year
        ).annotate(
            month=TruncMonth('payment_date')
        ).values('month').annotate(
            total=Sum('payment_totalamount')
        ).order_by('month')

        monthly_payments_data = [0] * 12
        for entry in monthly_payments:
            month = entry['month'].month 
            monthly_payments_data[month - 1] = float(entry['total'] or 0)

# --------------
        current_year = timezone.now().year
        monthly_users = CustomUser.objects.filter(
            user_type='customer',
            date_joined__year=current_year
        ).annotate(
            month=TruncMonth('date_joined')
        ).values('month').annotate(
            total=Count('id')
        ).order_by('month')

        monthly_users_data = [0] * 12
        for entry in monthly_users:
            month = entry['month'].month  
            monthly_users_data[month - 1] = entry['total']

       
    #    ---------------------
            
        payment_transactions = Payment.objects.filter(
            payment_status=1  
        ).select_related('booking__hotel').order_by('-payment_date')[:10]  

        transactions_data = []
        for payment in payment_transactions:
            transactions_data.append({
                'hotel_name': payment.booking.hotel.name if payment.booking and payment.booking.hotel else 'N/A',
                'amount': payment.payment_totalamount,
                'date': payment.payment_date.strftime('%Y-%m-%d %H:%M'),
                'status': 'تم الدفع',  
            })
    
    #    ---------------------
            
        extra_context.update({
            'total_bookings': Booking.objects.count(),
                        'monthly_users_data': monthly_users_data,
            'payment_transactions': transactions_data,
            'total_hotels': Hotel.objects.filter(is_verified=True).count(),
            'complete_payments': Payment.objects.filter(payment_status=1).aggregate(
                totalamount=Sum('payment_totalamount'))['totalamount'] or 0,
            'users_count': CustomUser.objects.filter(user_type='customer').count(),
            'bookings_data': bookings_data,
            'monthly_payments_data': monthly_payments_data,
        })

        return super().index(request, extra_context=extra_context)

admin_site = CustomAdminSite(name='custom_admin')