from django.conf import settings
from django.db import models
from users.models import CustomUser 
from django.utils.translation import gettext_lazy as _ 

from rooms.models import RoomType 
from services.models import HotelService, RoomTypeService 


class ShoppingCart(models.Model):
    
    user=models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        verbose_name=_("المستخدم"),
        related_name='shopping_carts',
       
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    deleted_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"ShoppingCart for user: {self.user.email if self.user else 'Guest'} (ID: {self.id})"

    class Meta:
        db_table = 'shopping_cart' # اسم الجدول في قاعدة البيانات
        # verbose_name = 'عربة التسوق'
        # verbose_name_plural = 'عربات التسوق'




class ShoppingCartItem(models.Model):
    cart = models.ForeignKey(ShoppingCart, on_delete=models.CASCADE, related_name='items')
    item_type = models.CharField(max_length=20, choices=[('room', 'Room'), ('service', 'Service')])
    # item_id = models.PositiveBigIntegerField() # أو models.BigIntegerField() حسب نوع item_id الفعلي
    room_type = models.ForeignKey(RoomType, on_delete=models.SET_NULL, null=True, blank=True, related_name='cart_items')
    hotel_service = models.ForeignKey(HotelService, on_delete=models.SET_NULL, null=True, blank=True, related_name='cart_items')
    quantity = models.PositiveIntegerField(default=1)
    Total_price = models.DecimalField(max_digits=10, decimal_places=2)
    check_in_date = models.DateTimeField(null=True, blank=True)
    check_out_date = models.DateTimeField(null=True, blank=True)
    notes = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    deleted_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        item_desc = f"{self.item_type} ID: {self.item_id}"
        if self.item_type == 'room' and self.room_type:
            item_desc = f"Room Type: {self.room_type.name} (ID: {self.room_type.id})"
        elif self.item_type == 'service' and self.hotel_service:
            item_desc = f"Service: {self.hotel_service.name} (ID: {self.hotel_service.id})"
        return f"Cart Item (ID: {self.id}) in Cart ID: {self.cart_id} - {item_desc}"

    class Meta:
        db_table = 'shopping_cart_item' # اسم الجدول في قاعدة البيانات
        # verbose_name = 'عنصر عربة التسوق' # الاسم المستعار للنموذج


class AdditionalService(models.Model):
    services = models.ForeignKey(RoomTypeService,related_name = 'item_services',on_delete=models.CASCADE,null=True)
    shoppingcartitem = models.ForeignKey(ShoppingCartItem,related_name = 'shopping_services',on_delete=models.CASCADE,null=True)

    def __str__(self):
        return f"{self.name} (${self.price})"

    class Meta:
        db_table = 'additional_services'
        verbose_name = _("خدمة إضافية")
        verbose_name_plural = _("الخدمات الإضافية")