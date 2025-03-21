from django.contrib import admin
from .models import HeroSlider, InfoBox, RoomTypeHome, Setting, SocialMediaLink
from .models import TeamMember, Partner, Testimonial
# Register your models here.


class HeroSliderAdmin(admin.ModelAdmin):
    list_display = ('title', 'is_active')
    list_filter = ('is_active',)



   

from api.admin import admin_site


# home ----------
admin_site.register(InfoBox)
admin_site.register(RoomTypeHome)
admin_site.register(Setting)
admin_site.register(SocialMediaLink)
admin_site.register(HeroSlider)
admin_site.register(TeamMember)
admin_site.register(Partner)
admin_site.register(Testimonial)