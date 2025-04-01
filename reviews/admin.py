# from django.contrib import admin
# from django.utils.translation import gettext_lazy as _
# from .models import HotelReview, RoomReview

# class HotelReviewAdmin(admin.ModelAdmin):
#     list_display = (
#         'hotel',  
#         'user',  
#         'rating_service', 
#         'rating_location', 
#         'rating_value_for_money', 
#         'rating_cleanliness', 
#         'status', 
#         'created_at'
#     )
#     list_filter = ('hotel', 'created_at')
#     search_fields = ('hotel__name', 'user__username', 'user__email', 'review')
#     ordering = ('-created_at',)
#     readonly_fields = ('created_at', 'updated_at')
    
#     fieldsets = (
#         (None, {
#             'fields': ('hotel', 'user', 'review', 'status')
#         }),
#         (_("Ratings"), {
#             'fields': (
#                 'rating_service',
#                 'rating_location',
#                 'rating_value_for_money',
#                 'rating_cleanliness',
#             )
#         }),
#         (_("Timestamps"), {
#             'fields': ('created_at', 'updated_at')
#         }),
#     )

#     # Custom methods for displaying related fields
#     def hotel_name(self, obj):
#         return obj.hotel.name
#     hotel_name.short_description = _("Hotel Name")

#     def user_full_name(self, obj):
#         return obj.user.get_full_name() or obj.user.username
#     user_full_name.short_description = _("User")

from django.contrib import admin
from .models import HotelReview, RoomReview
from api.admin import admin_site
class AutoUserTrackMixin:
    
    def save_model(self, request, obj, form, change):
        if not obj.pk: 
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)


class HotelReviewAdmin(AutoUserTrackMixin ,admin.ModelAdmin):
    list_display = (
        'hotel', 'user', 'rating_service', 'rating_location',
        'rating_value_for_money', 'rating_cleanliness', 'status', 'created_at'
    )
    list_filter = ('status', 'rating_service', 'rating_location')
    search_fields = ('hotel__name', 'user__username', 'review')
    ordering = ['-created_at']
    actions = ['approve_reviews', 'reject_reviews']

    @admin.action(description="Mark selected reviews as approved")
    def approve_reviews(self, request, queryset):
        queryset.update(status=True)

    @admin.action(description="Mark selected reviews as rejected")
    def reject_reviews(self, request, queryset):
        queryset.update(status=False)
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

class RoomReviewAdmin( AutoUserTrackMixin ,admin.ModelAdmin):
    list_display = (
        'hotel', 'room_type', 'user', 'rating', 'status', 'created_at'
    )
    list_filter = ('status', 'rating')
    search_fields = ('hotel__name', 'room_type__name', 'user__username', 'review')
    ordering = ['-created_at']
    actions = ['approve_reviews', 'reject_reviews']
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

    @admin.action(description="Mark selected reviews as approved")
    def approve_reviews(self, request, queryset):
        queryset.update(status=True)

    @admin.action(description="Mark selected reviews as rejected")
    def reject_reviews(self, request, queryset):
        queryset.update(status=False)


admin_site.register(HotelReview, HotelReviewAdmin)
admin_site.register(RoomReview)