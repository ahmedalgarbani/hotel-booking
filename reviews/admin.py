from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from .models import HotelReview, RoomReview


@admin.register(HotelReview)
class HotelReviewAdmin(admin.ModelAdmin):
    list_display = ('hotel', 'user', 'rating_service', 'rating_location', 
                    'rating_value_for_money', 'rating_cleanliness', 
                     'status', 'created_at')
    list_filter = ('hotel', 'status', 'created_at')
    search_fields = ('hotel__name', 'user__username', 'user__email', 'review')
    ordering = ('-created_at',)
    readonly_fields = ('created_at', 'updated_at')
    fieldsets = (
        (None, {
            'fields': ('hotel', 'user', 'review', 'status')
        }),
        (_("Ratings"), {
            'fields': (
                'rating_service',
                'rating_location',
                'rating_value_for_money',
                'rating_cleanliness',
            )
        }),
        (_("Timestamps"), {
            'fields': ('created_at', 'updated_at')
        }),
    )


@admin.register(RoomReview)
class RoomReviewAdmin(admin.ModelAdmin):
    list_display = ('hotel', 'room_type', 'user', 'rating', 'status', 'created_at')
    list_filter = ('hotel', 'room_type', 'status', 'created_at')
    search_fields = ('hotel__name', 'room_type__name', 'user__username', 'user__email', 'review')
    ordering = ('-created_at',)
    readonly_fields = ('created_at', 'updated_at')
    fieldsets = (
        (None, {
            'fields': ('hotel', 'room_type', 'user', 'review', 'status')
        }),
        (_("Rating"), {
            'fields': ('rating',)
        }),
        (_("Timestamps"), {
            'fields': ('created_at', 'updated_at')
        }),
    )

