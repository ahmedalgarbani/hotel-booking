from django.db import models
from django.utils.translation import gettext_lazy as _

# Create your models here.


class InfoBox(models.Model):
    icon = models.CharField(max_length=255)  
    title = models.CharField(max_length=255)  
    description = models.TextField()  
    description = models.TextField()  
    show_at_home = models.BooleanField(default=True) 

    def __str__(self):
        return self.title
    

class RoomTypeHome(models.Model):
    name = models.CharField(max_length=100, verbose_name="اسم الغرفة")  
    image = models.ImageField(upload_to='room_types/', verbose_name="صورة الغرفة")
    link = models.URLField(blank=True, null=True, verbose_name="رابط الغرفة")
    show_at_home = models.BooleanField(default=True) 

    def __str__(self):
        return self.name    
    

class Setting(models.Model):
    STATUS_LEFT = 0
    STATUS_RIGHT = 1

    STATUS_CHOICES = [
        (STATUS_LEFT,'left'),
        (STATUS_RIGHT, 'right'),
    ]
    site_name = models.CharField(max_length=100)
    email = models.EmailField(
        verbose_name=_("البريد الإلكتروني"),
        max_length=100,
        unique=True,
        error_messages={'invalid': _("يرجى إدخال بريد إلكتروني صالح")}
    )

    phone_number = models.CharField(
        verbose_name=_("رقم الهاتف"),
        max_length=15,
        
    )
    description = models.CharField(max_length=255)
    address = models.CharField(max_length=255)
    default_currency = models.CharField(max_length=100)
    color = models.CharField(max_length=100)
    currency_icon = models.CharField(max_length=10)
    default_language = models.CharField(max_length=100)
    currency_Icon_position = models.IntegerField(
        choices=STATUS_CHOICES,
        default=STATUS_LEFT,
    )
    logo = models.ImageField(upload_to='home/components/setting/',null=True,blank=True)
    favicon = models.ImageField(upload_to='home/components/setting/',null=True,blank=True)
    footer_logo = models.ImageField(upload_to='home/components/setting/',null=True,blank=True)
    seo_title = models.CharField(max_length=255)
    seo_description = models.TextField()
    seo_keywords = models.TextField()

    def __str__(self):
        return f"setting {self.site_name}"



class SocialMediaLink(models.Model):
    name = models.CharField(max_length=100)
    link = models.CharField(max_length=255)
    icon = models.CharField(max_length=100)
    status = models.BooleanField(default=True)
    def __str__(self):
        return f"socialmedia {self.name}"  
    


class HeroSlider(models.Model):
    image1 = models.ImageField(
        upload_to='slider_images/',
        verbose_name=_("صورة السلايدر")
    )
    image2 = models.ImageField(
        upload_to='slider_images/',
        verbose_name=_("صورة السلايدر")
    )
    image3 = models.ImageField(
        upload_to='slider_images/',
        verbose_name=_("صورة السلايدر")
    )
    title = models.CharField(
        max_length=255,
        verbose_name=_("العنوان")
    )
    description = models.TextField(
        verbose_name=_("الوصف"),
        blank=True,
        null=True
    )
    is_active = models.BooleanField(
        default=True,
        verbose_name=_("نشط")
    )

    def __str__(self):
        return self.title









class TeamMember(models.Model):
    name = models.CharField(max_length=100)
    position = models.CharField(max_length=100)
    bio = models.TextField()
    image = models.ImageField(upload_to='team/')
    facebook = models.URLField(blank=True, null=True)
    twitter = models.URLField(blank=True, null=True)
    instagram = models.URLField(blank=True, null=True)
    linkedin = models.URLField(blank=True, null=True)

    def str(self):
        return self.name

class Partner(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    image = models.ImageField(upload_to='partners/')

    def str(self):
        return self.name

class Testimonial(models.Model):
    name = models.CharField(max_length=100)
    position = models.CharField(max_length=100)
    content = models.TextField()
    image = models.ImageField(upload_to='testimonials/')

    def str(self):
        return self.name
    

class PricingPlan(models.Model):
    title = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    duration = models.CharField(max_length=50)  # مثال: "كل شهر"
    features = models.TextField()  # تخزين الميزات كسلسلة مفصولة بفواصل
    is_active = models.BooleanField(default=False)
    def __str__(self):
        return self.title

    def get_features_list(self):
        return self.features.split(',')

    def __str__(self):
        return self.title

    






   

class ContactMessage(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)
    def __str__(self):
        return f"Message from {self.name} - {self.created_at}"

    def __str__(self):
        return self.name