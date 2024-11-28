from django.contrib import admin
from .models import Hotel, Location, Phone, Image, City

# ---------- Hotel -------------
class HotelAdmin(admin.ModelAdmin):
    list_display = ('name', 'location', 'rating', 'is_verified', 'slug', 'created_at')
    readonly_fields = ('slug',)  
    search_fields = ('name', 'location__name')  
    list_filter = ('rating', 'is_verified') 

admin.site.register(Hotel, HotelAdmin)

# ----------- Location --------------
class LocationAdmin(admin.ModelAdmin):
    list_display = ('name', 'address', 'city', 'slug', 'created_at')
    readonly_fields = ('slug',) 
    search_fields = ('name', 'city__name')  
    list_filter = ('city',)

admin.site.register(Location, LocationAdmin)

# ----------- Phone --------------
class PhoneAdmin(admin.ModelAdmin):
    list_display = ('phone_number', 'country_code', 'created_at')
    search_fields = ('phone_number',)

admin.site.register(Phone, PhoneAdmin)

# ----------- Image --------------

class ImageAdmin(admin.ModelAdmin):
    list_display = ('image_path', 'image_url','hotel_id', 'created_at')
    search_fields = ('image_path',) 

admin.site.register(Image, ImageAdmin)

# ----------- City --------------
class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'state', 'country', 'slug', 'created_at')
    readonly_fields = ('slug',)  
    search_fields = ('name', 'state', 'country') 
    list_filter = ('state', 'country') 

admin.site.register(City, CityAdmin)
