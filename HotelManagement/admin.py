from django.contrib import admin
from .models import Hotel, Location, Phone, Image, City
from django.contrib.auth import get_user_model
from django import forms



User = get_user_model()

@admin.register(Hotel)
class HotelAdmin(admin.ModelAdmin):
    list_display = ['name', 'location', 'created_at']
    search_fields = ['name']
    list_filter = ['location', 'created_at']

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
       
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(manager=request.user)
        
        return queryset.none()

    def has_add_permission(self, request):
        
        return request.user.is_superuser or request.user.user_type == 'admin'

    def has_view_permission(self, request, obj=None):
        if not obj:
            return True
        
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        
        return request.user.user_type == 'hotel_manager' and request.user in obj.city.all()

    def has_delete_permission(self, request, obj=None):
       
        return request.user.is_superuser or request.user.user_type == 'admin'
# ---------- Hotel -------------

# ----------- Location --------------
@admin.register(Location)
class LocationAdmin(admin.ModelAdmin):
    list_display = ('name', 'address', 'city', 'slug', 'created_at')
    readonly_fields = ('slug',)
    search_fields = ('name', 'city__name')
    list_filter = ('city',)

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
           
            return queryset.filter(hotel__manager=request.user)
        return queryset.none()

    def has_add_permission(self, request):
       
        return request.user.is_superuser or request.user.user_type == 'admin' or request.user.user_type == 'hotel_manager'

    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        
        return request.user.user_type == 'hotel_manager' and obj.hotel_set.filter(manager=request.user).exists()

    def has_delete_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel_set.filter(manager=request.user).exists()

    def has_view_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel_set.filter(manager=request.user).exists()

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
           
            form.base_fields['city'].queryset = City.objects.filter(location__hotel__manager=request.user)
        return form

    def save_model(self, request, obj, form, change):
        if not obj.pk and request.user.user_type == 'hotel_manager':
            # حفظ الموقع وربطه بفندق المدير
            obj.save()
            hotel = Hotel.objects.get(manager=request.user)
            hotel.location = obj
            hotel.save()
        else:
            super().save_model(request, obj, form, change)

# ----------- Phone --------------
@admin.register(Phone)
class PhoneAdmin(admin.ModelAdmin):
    list_display = ('phone_number', 'country_code', 'hotel', 'created_at')
    search_fields = ('phone_number', 'hotel__name')
    list_filter = ('hotel',)

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        return queryset.none()

    def has_add_permission(self, request):
        
        return request.user.is_superuser or request.user.user_type == 'admin' or request.user.user_type == 'hotel_manager'

    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def has_delete_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def has_view_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
           
            hotel = Hotel.objects.get(manager=request.user)
            form.base_fields['hotel'].queryset = Hotel.objects.filter(id=hotel.id)
            form.base_fields['hotel'].initial = hotel
            form.base_fields['hotel'].widget.attrs['disabled'] = True
            form.base_fields['hotel'].required = False
        return form

    def save_model(self, request, obj, form, change):
        if not obj.pk and request.user.user_type == 'hotel_manager':
           
            obj.hotel = Hotel.objects.get(manager=request.user)
        super().save_model(request, obj, form, change)

# ----------- Image --------------


class ImageAdminForm(forms.ModelForm):
    class Meta:
        model = Image
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        request = kwargs.pop('request', None)
        
        if hasattr(request, 'user') and request.user.user_type == 'hotel_manager':
            hotel = Hotel.objects.get(manager=request.user)
            self.fields['hotel_id'].initial = hotel
            self.fields['hotel_id'].disabled = True

@admin.register(Image)
class ImageAdmin(admin.ModelAdmin):
    form = ImageAdminForm
    list_display = ('image_path', 'image_url', 'hotel_id', 'created_at')
    search_fields = ('image_path',)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            
            form.base_fields['hotel_id'].queryset = Hotel.objects.filter(manager=request.user)
            form.base_fields['hotel_id'].initial = Hotel.objects.filter(manager=request.user).first()
            form.base_fields['hotel_id'].widget.attrs['disabled'] = True
            form.base_fields['hotel_id'].required = False

        return form

    def save_model(self, request, obj, form, change):
        if not obj.pk and request.user.user_type == 'hotel_manager':
           
            obj.hotel_id = Hotel.objects.filter(manager=request.user).first()
        super().save_model(request, obj, form, change)

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        return queryset.filter(hotel_id__manager=request.user)

    def has_add_permission(self, request):
        return request.user.is_superuser or request.user.user_type == 'admin' or request.user.user_type == 'hotel_manager'

    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel_id.manager == request.user

    def has_delete_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel_id.manager == request.user

# ----------- City --------------

class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'state', 'country', 'slug', 'created_at')
    readonly_fields = ('slug',)
    search_fields = ('name', 'state', 'country')
    list_filter = ('state', 'country')

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
           
            return queryset.filter(location__hotel__manager=request.user)
        return queryset.none()

    def has_add_permission(self, request):
        return request.user.is_superuser or request.user.user_type == 'admin'

    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.location_set.filter(hotel__manager=request.user).exists()

    def has_delete_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.location_set.filter(hotel__manager=request.user).exists()

    def has_view_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.location_set.filter(hotel__manager=request.user).exists()
admin.site.register(City, CityAdmin)
