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
from django.contrib import admin
from django_celery_beat.models import (
    IntervalSchedule, 
    CrontabSchedule,
    SolarSchedule,
    ClockedSchedule,
    PeriodicTask
)

class CustomAdminSite(admin.AdminSite):
    def index(self, request, extra_context=None):
        extra_context = extra_context or {}
        today = timezone.now().date()
        start_of_week = today - timezone.timedelta(days=today.weekday())
        
        # Filter data by hotel for hotel managers
        if request.user.is_superuser:
            booking_filter = {}
            payment_filter = {}
            user_filter = {}
        elif hasattr(request.user, 'hotel'):  # Hotel manager logic
            booking_filter = {'hotel': request.user.hotel}
            payment_filter = {'booking__hotel': request.user.hotel}
            user_filter = {'hotel': request.user.hotel}
        else:
            booking_filter = {'id': 0}  # Empty data for unauthorized users
            payment_filter = {'id': 0}
            user_filter = {'id': 0}

        # Weekly bookings data
        bookings_data = [
            Booking.objects.filter(created_at__date=day, **booking_filter).count()
            for day in [start_of_week + timezone.timedelta(days=i) for i in range(7)]
        ]

        # Monthly payments data
        current_year = timezone.now().year
        monthly_payments = Payment.objects.filter(
            payment_status=1,
            payment_date__year=current_year,
            **payment_filter
        ).annotate(
            month=TruncMonth('payment_date')
        ).values('month').annotate(
            total=Sum('payment_totalamount')
        ).order_by('month')

        monthly_payments_data = [0] * 12
        for entry in monthly_payments:
            monthly_payments_data[entry['month'].month - 1] = float(entry['total'] or 0)

        # Monthly users data
        monthly_users = CustomUser.objects.filter(
            user_type='customer',
            date_joined__year=current_year,
            **user_filter
        ).annotate(
            month=TruncMonth('date_joined')
        ).values('month').annotate(
            total=Count('id')
        ).order_by('month')

        monthly_users_data = [0] * 12
        for entry in monthly_users:
            monthly_users_data[entry['month'].month - 1] = entry['total']

        # Recent payment transactions
        payment_transactions = Payment.objects.filter(
            **payment_filter
        ).select_related('booking__hotel').order_by('-payment_date')[:10]

        transactions_data = [
            {
                'hotel_name': payment.booking.hotel.name if payment.booking and payment.booking.hotel else 'N/A',
                'amount': payment.payment_totalamount,
                'date': payment.payment_date.strftime('%Y-%m-%d %H:%M'),
                'status': payment.payment_status
            } for payment in payment_transactions
        ]

        extra_context.update({
            'total_bookings': Booking.objects.filter(**booking_filter).count(),
            'monthly_users_data': monthly_users_data,
            'payment_transactions': transactions_data,
            'total_hotels': Hotel.objects.filter(is_verified=True).count() if request.user.is_superuser else 1,
            'complete_payments': Payment.objects.filter(payment_status=1, **payment_filter).aggregate(
                totalamount=Sum('payment_totalamount'))['totalamount'] or 0,
            'users_count': CustomUser.objects.filter(user_type='customer', **user_filter).count(),
            'bookings_data': bookings_data,
            'monthly_payments_data': monthly_payments_data,
        })

        return super().index(request, extra_context=extra_context)

admin_site = CustomAdminSite(name='custom_admin')

admin_site.register(IntervalSchedule)
admin_site.register(CrontabSchedule)
admin_site.register(SolarSchedule)
admin_site.register(ClockedSchedule)
admin_site.register(PeriodicTask)