from django.db import models

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



class HotelAccountRequest(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected'),
    ]

    hotel_name = models.CharField(max_length=255)
    owner_name = models.CharField(max_length=255)
    email = models.EmailField()
    phone = models.CharField(max_length=20)
    hotel_description = models.TextField()
    business_license_number = models.CharField(max_length=100)
    document_path = models.FileField(upload_to='hotel_documents/')
    verify_number = models.CharField(max_length=50)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    admin_notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Request for {self.hotel_name}"
