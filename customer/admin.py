from django.contrib import admin

# Register your models here.
from api.admin import admin_site
from customer.models import Favourites


class AutoUserTrackMixin:
    
    def save_model(self, request, obj, form, change):
        if not obj.pk: 
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)


class FavouritesAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ('user', 'hotel') 
    search_fields = ('user__username', 'hotel__name') 
    list_filter = ('hotel',)  
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at', 'created_by', 'updated_by','hotel','deleted_at')
        return self.readonly_fields
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(hotel__manager=request.user.chield)
        return queryset.none()
    



admin_site.register(Favourites,FavouritesAdmin)