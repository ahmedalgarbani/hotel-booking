from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
from django import forms
from django.contrib import messages
from datetime import timedelta
from django.urls import path, reverse
from django.utils.html import format_html
from django.contrib.admin import widgets
from django.contrib.admin.widgets import AdminDateWidget
from django.db.models import Q, Sum
from django.utils.safestring import mark_safe
from HotelManagement.models import Hotel
from .models import RoomType, Category, Availability, RoomPrice, RoomImage, RoomStatus

class HotelManagerAdminMixin:
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if not request.user.is_superuser:
            qs = qs.filter(hotel__manager=request.user)
        return qs

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if not request.user.is_superuser:
            if db_field.name == "hotel":
                kwargs["queryset"] = Hotel.objects.filter(manager=request.user)
            elif db_field.name == "room_type":
                kwargs["queryset"] = RoomType.objects.filter(hotel__manager=request.user)
            elif db_field.name == "room_status":
                kwargs["queryset"] = RoomStatus.objects.filter(hotel__manager=request.user)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

@admin.register(Category)
class CategoryAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['name', 'hotel', 'description', 'get_room_types_count']
    search_fields = ['name', 'hotel__name']
    list_filter = ['hotel']

    def get_room_types_count(self, obj):
        return obj.room_types.count()
    get_room_types_count.short_description = _("عدد أنواع الغرف")

@admin.register(RoomType)
class RoomTypeAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['name', 'hotel', 'category', 'default_capacity', 'max_capacity', 'rooms_count', 'base_price', 'is_active', 'get_available_rooms', 'preview_image']
    search_fields = ['name', 'hotel__name']
    list_filter = ['hotel', 'category', 'is_active']
    list_editable = ['is_active', 'base_price']
    
    def get_available_rooms(self, obj):
        today = timezone.now().date()
        availability = Availability.objects.filter(
            room_type=obj,
            date=today
        ).first()
        if availability:
            return f"{availability.available_rooms}/{obj.rooms_count}"
        return f"0/{obj.rooms_count}"
    get_available_rooms.short_description = _("الغرف المتوفرة اليوم")

    def preview_image(self, obj):
        main_image = obj.images.filter(is_main=True).first()
        if main_image:
            return mark_safe(f'<img src="{main_image.image.url}" width="50" height="50" />')
        return ""
    preview_image.short_description = _("الصورة")

@admin.register(RoomStatus)
class RoomStatusAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['name', 'code', 'hotel', 'is_available', 'get_rooms_count']
    search_fields = ['name', 'code', 'hotel__name']
    list_filter = ['hotel', 'is_available']

    def get_rooms_count(self, obj):
        today = timezone.now().date()
        return Availability.objects.filter(
            room_status=obj,
            date=today
        ).aggregate(total=Sum('available_rooms'))['total'] or 0
    get_rooms_count.short_description = _("عدد الغرف اليوم")

@admin.register(Availability)
class AvailabilityAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    change_list_template = 'admin/rooms/availability/change_list.html'
    list_display = ['room_type', 'hotel', 'availability_date', 'available_rooms', 'room_status', 'bulk_create_button']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'availability_date', 'room_type', 'room_status']
    list_editable = ['available_rooms']
    date_hierarchy = 'availability_date'
    
    def bulk_create_button(self, obj=None):
        url = reverse('admin:rooms_availability_bulk_create')
        return format_html(
            '<a class="button" href="{}">{}</a>',
            url,
            _('إنشاء جماعي')
        )
    bulk_create_button.short_description = ''
    bulk_create_button.allow_tags = True

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('bulk-create/', self.bulk_create_view, name='rooms_availability_bulk_create'),
        ]
        return custom_urls + urls
    
    def bulk_create_view(self, request):
        from django.shortcuts import render, redirect
        if request.method == 'POST':
            form = BulkAvailabilityAdminForm(request.POST, user=request.user)
            if form.is_valid():
                start_date = form.cleaned_data['start_date']
                end_date = form.cleaned_data['end_date']
                available_rooms = form.cleaned_data['available_rooms']
                price = form.cleaned_data['price']
                room_status = form.cleaned_data['room_status']
                
                room_type = RoomType.objects.get(
                    id=request.POST.get('room_type'),
                    hotel__manager=request.user
                )
                
                current_date = start_date
                bulk_list = []
                
                while current_date <= end_date:
                    bulk_list.append(
                        Availability(
                            hotel=room_type.hotel,
                            room_type=room_type,
                            date=current_date,
                            available_rooms=available_rooms,
                            price=price,
                            room_status=room_status
                        )
                    )
                    current_date += timedelta(days=1)
                
                Availability.objects.bulk_create(bulk_list, ignore_conflicts=True)
                self.message_user(request, _("تم إنشاء توفر الغرف بنجاح"), messages.SUCCESS)
                return redirect('admin:rooms_availability_changelist')
        else:
            form = BulkAvailabilityAdminForm(user=request.user)
        
        # فلترة أنواع الغرف حسب الفندق
        room_types = RoomType.objects.filter(hotel__manager=request.user) if not request.user.is_superuser else RoomType.objects.all()
        
        context = {
            'form': form,
            'title': _("إنشاء توفر الغرف بشكل جماعي"),
            'room_types': room_types,
        }
        return render(request, 'admin/rooms/availability/bulk_create.html', context)

    actions = ['copy_to_next_day']
    
    def copy_to_next_day(self, request, queryset):
        for availability in queryset:
            next_day = availability.date + timedelta(days=1)
            Availability.objects.get_or_create(
                hotel=availability.hotel,
                room_type=availability.room_type,
                date=next_day,
                defaults={
                    'available_rooms': availability.available_rooms,
                    'price': availability.price,
                    'room_status': availability.room_status
                }
            )
        self.message_user(request, _("تم نسخ التوفر إلى اليوم التالي بنجاح"))
    copy_to_next_day.short_description = _("نسخ التوفر إلى اليوم التالي")

class BulkAvailabilityAdminForm(forms.Form):
    start_date = forms.DateField(
        label=_("تاريخ البدء"),
        widget=forms.DateInput(attrs={'type': 'date'})
    )
    end_date = forms.DateField(
        label=_("تاريخ الانتهاء"),
        widget=forms.DateInput(attrs={'type': 'date'})
    )
    available_rooms = forms.IntegerField(
        label=_("عدد الغرف المتوفرة"), 
        min_value=0
    )
    price = forms.DecimalField(
        label=_("السعر"), 
        min_value=0
    )
    room_status = forms.ModelChoiceField(
        queryset=RoomStatus.objects.all(),
        label=_("حالة الغرفة")
    )

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)
        super().__init__(*args, **kwargs)
        if user and not user.is_superuser:
            self.fields['room_status'].queryset = RoomStatus.objects.filter(hotel__manager=user)

@admin.register(RoomPrice)
class RoomPriceAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['room_type', 'hotel', 'price', 'date_from', 'date_to', 'is_special_offer', 'get_days_remaining']
    search_fields = ['room_type__name', 'hotel__name']
    list_filter = ['hotel', 'room_type', 'is_special_offer']
    list_editable = ['price', 'is_special_offer']

    def get_days_remaining(self, obj):
        today = timezone.now().date()
        if obj.date_to >= today:
            days = (obj.date_to - today).days
            return _("متبقي {} يوم").format(days)
        return _("منتهي")
    get_days_remaining.short_description = _("المدة المتبقية")

@admin.register(RoomImage)
class RoomImageAdmin(HotelManagerAdminMixin, admin.ModelAdmin):
    list_display = ['room_type', 'hotel', 'preview_image', 'is_main', 'caption']
    search_fields = ['room_type__name', 'hotel__name', 'caption']
    list_filter = ['hotel', 'room_type', 'is_main']
    list_editable = ['is_main', 'caption']

    def preview_image(self, obj):
        if obj.image:
            return mark_safe(f'<img src="{obj.image.url}" width="50" height="50" />')
        return ""
    preview_image.short_description = _("معاينة")