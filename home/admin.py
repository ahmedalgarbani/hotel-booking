from django.contrib import admin
from .models import HeroSlider, InfoBox, PrivacyPolicy, RoomTypeHome, Setting, SocialMediaLink, TermsConditions
from .models import TeamMember, Partner, Testimonial, PricingPlan, ContactMessage 
# Register your models here.


class HeroSliderAdmin(admin.ModelAdmin):
    list_display = ('title', 'is_active')
    list_filter = ('is_active',)


class TermsConditionsAdmin(admin.ModelAdmin):
    search_fields = ('content',)


class PrivacyPolicyAdmin(admin.ModelAdmin):
    search_fields = ('content',)

   

class PaymentPolicyAdmin(admin.ModelAdmin):
    search_fields = ('content',)

   

from api.admin import admin_site


# home ----------
admin_site.register(InfoBox)
admin_site.register(PrivacyPolicy,PrivacyPolicyAdmin)
admin_site.register(TermsConditions,TermsConditionsAdmin)
admin_site.register(RoomTypeHome)
admin_site.register(Setting)
admin_site.register(SocialMediaLink)
admin_site.register(HeroSlider)
admin_site.register(TeamMember)
admin_site.register(Partner)
admin_site.register(Testimonial)
admin_site.register(PricingPlan)
admin_site.register(ContactMessage)