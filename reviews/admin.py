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
class HotelReviewAdmin(admin.ModelAdmin):
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

@admin.register(RoomReview)
class RoomReviewAdmin(admin.ModelAdmin):
    list_display = (
        'hotel', 'room_type', 'user', 'rating', 'status', 'created_at'
    )
    list_filter = ('status', 'rating')
    search_fields = ('hotel__name', 'room_type__name', 'user__username', 'review')
    ordering = ['-created_at']
    actions = ['approve_reviews', 'reject_reviews']

    @admin.action(description="Mark selected reviews as approved")
    def approve_reviews(self, request, queryset):
        queryset.update(status=True)

    @admin.action(description="Mark selected reviews as rejected")
    def reject_reviews(self, request, queryset):
        queryset.update(status=False)


admin_site.register(HotelReview, HotelReviewAdmin)
admin_site.register(RoomReview)