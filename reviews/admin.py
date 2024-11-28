from django.contrib import admin
from .models import Review
# Register your models here.

class ReviewAdmin(admin.ModelAdmin):
    list_display = ('id', 'user_id','hotel_id','has_res', 'rating', 'created_at')
    list_filter = ('has_res','id')
    search_fields = ('id', 'user_id','hotel_id')


admin.site.register(Review,ReviewAdmin)