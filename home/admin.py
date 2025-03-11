from django.contrib import admin
from .models import HeroSlider, InfoBox, RoomTypeHome, Setting, SocialMediaLink

# Register your models here.

admin.site.register(InfoBox)
admin.site.register(RoomTypeHome)
admin.site.register(Setting)
admin.site.register(SocialMediaLink)
admin.site.register(HeroSlider)
class HeroSliderAdmin(admin.ModelAdmin):
    list_display = ('title', 'is_active')
    list_filter = ('is_active',)