from django.contrib import admin
from django.shortcuts import render
from django.contrib.admin.views.decorators import staff_member_required
from django.urls import reverse
from .models import City, Location, Phone, Image, Hotel, HotelRequest
from rooms.models import Category, RoomType, RoomStatus, RoomPrice, Availability, RoomImage
from payments.models import HotelPaymentMethod, Currency, PaymentOption, Payment
from reviews.models import HotelReview, RoomReview, Offer as ReviewOffer
from services.models import Service, Offer as ServiceOffer
from blog.models import Category as BlogCategory, Post, Comment

@staff_member_required
def system_setup(request):
    setup_groups = [
        {
            'name': 'إعدادات الموقع',
            'icon': 'fas fa-map-marked-alt',
            'items': [
                {
                    'name': 'المدن',
                    'url': reverse('admin:HotelManagement_city_changelist'),
                    'icon': 'fas fa-city',
                    'count': City.objects.count(),
                    'add_url': reverse('admin:HotelManagement_city_add'),
                },
                {
                    'name': 'المواقع',
                    'url': reverse('admin:HotelManagement_location_changelist'),
                    'icon': 'fas fa-map-marker-alt',
                    'count': Location.objects.count(),
                    'add_url': reverse('admin:HotelManagement_location_add'),
                },
            ]
        },
        {
            'name': 'إعدادات الغرف',
            'icon': 'fas fa-bed',
            'items': [
                {
                    'name': 'تصنيفات الغرف',
                    'url': reverse('admin:rooms_category_changelist'),
                    'icon': 'fas fa-layer-group',
                    'count': Category.objects.count(),
                    'add_url': reverse('admin:rooms_category_add'),
                },
                {
                    'name': 'أنواع الغرف',
                    'url': reverse('admin:rooms_roomtype_changelist'),
                    'icon': 'fas fa-bed',
                    'count': RoomType.objects.count(),
                    'add_url': reverse('admin:rooms_roomtype_add'),
                },
                {
                    'name': 'حالات الغرف',
                    'url': reverse('admin:rooms_roomstatus_changelist'),
                    'icon': 'fas fa-info-circle',
                    'count': RoomStatus.objects.count(),
                    'add_url': reverse('admin:rooms_roomstatus_add'),
                },
            ]
        },
        {
            'name': 'إعدادات المدفوعات',
            'icon': 'fas fa-money-bill-wave',
            'items': [
                {
                    'name': 'طرق الدفع',
                    'url': reverse('admin:payments_hotelpaymentmethod_changelist'),
                    'icon': 'fas fa-credit-card',
                    'count': HotelPaymentMethod.objects.count(),
                    'add_url': reverse('admin:payments_hotelpaymentmethod_add'),
                },
                {
                    'name': 'العملات',
                    'url': reverse('admin:payments_currency_changelist'),
                    'icon': 'fas fa-dollar-sign',
                    'count': Currency.objects.count(),
                    'add_url': reverse('admin:payments_currency_add'),
                },
                {
                    'name': 'خيارات الدفع',
                    'url': reverse('admin:payments_paymentoption_changelist'),
                    'icon': 'fas fa-money-check-alt',
                    'count': PaymentOption.objects.count(),
                    'add_url': reverse('admin:payments_paymentoption_add'),
                },
            ]
        },
        {
            'name': 'إعدادات الخدمات',
            'icon': 'fas fa-concierge-bell',
            'items': [
                {
                    'name': 'الخدمات',
                    'url': reverse('admin:services_service_changelist'),
                    'icon': 'fas fa-concierge-bell',
                    'count': Service.objects.count(),
                    'add_url': reverse('admin:services_service_add'),
                },
                {
                    'name': 'العروض',
                    'url': reverse('admin:services_offer_changelist'),
                    'icon': 'fas fa-gift',
                    'count': ServiceOffer.objects.count(),
                    'add_url': reverse('admin:services_offer_add'),
                },
            ]
        },
        {
            'name': 'إعدادات المدونة',
            'icon': 'fas fa-blog',
            'items': [
                {
                    'name': 'تصنيفات المدونة',
                    'url': reverse('admin:blog_category_changelist'),
                    'icon': 'fas fa-folder',
                    'count': BlogCategory.objects.count(),
                    'add_url': reverse('admin:blog_category_add'),
                },
                {
                    'name': 'المقالات',
                    'url': reverse('admin:blog_post_changelist'),
                    'icon': 'fas fa-file-alt',
                    'count': Post.objects.count(),
                    'add_url': reverse('admin:blog_post_add'),
                },
            ]
        },
    ]
    
    context = {
        'title': 'تهيئة النظام',
        'setup_groups': setup_groups,
    }
    return render(request, 'admin/system_setup.html', context)
