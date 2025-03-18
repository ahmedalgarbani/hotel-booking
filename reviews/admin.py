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


