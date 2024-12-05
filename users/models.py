from django.db import models

from HotelManagement.models import BaseModel
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.models import User

from django.conf import settings

class CustomUser(AbstractUser):
    

    USER_TYPE_CHOICES=[
        ('admin','System Admin'),
        ('hotel_manager','Hotel Manager'),
        ('customer','Customer'),

    ]
    user_type=models.CharField(max_length=20,choices=USER_TYPE_CHOICES)
    phone=models.CharField(max_length=20,blank=True)

    image = models.ImageField(upload_to='user/%y/%m/%d',default=None)  

    # , default='accounts/24/07/29/home4.png'
    
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return f"{self.username} ({self.get_user_type_display()})" 

class HotelAccountRequest(BaseModel):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected'),
    ]

    hotel_name = models.CharField(max_length=255, verbose_name="اسم الفندق")
    owner_name = models.CharField(max_length=255, verbose_name="اسم المالك")
    email = models.EmailField(verbose_name="البريد الإلكتروني")
    phone = models.CharField(max_length=20, verbose_name="رقم الهاتف")
    hotel_description = models.TextField(verbose_name="وصف الفندق")
    business_license_number = models.CharField(max_length=100, verbose_name="رقم الرخصة التجارية")
    document_path = models.FileField(upload_to='hotel_documents/', verbose_name="مسار مستند الفندق")
    verify_number = models.CharField(max_length=50, verbose_name="رقم التحقق")
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending', verbose_name="حالة الطلب")
    admin_notes = models.TextField(blank=True, default=None, verbose_name="ملاحظات المسؤول")
    password= models.CharField(max_length=255, verbose_name="كلمه السر ")
    # user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='hotel_requests')
   
    def __str__(self):
        return f"Request for {self.hotel_name}"

    from django.db import models

class ActivityLog(models.Model):
    log_id = models.AutoField(primary_key=True)
    custom_user_id = models.ForeignKey('CustomUser', on_delete=models.CASCADE)
    table_name = models.CharField(max_length=100)
    record_id = models.IntegerField()
    action = models.CharField(max_length=50)
    changed_at = models.DateTimeField(auto_now_add=True)
