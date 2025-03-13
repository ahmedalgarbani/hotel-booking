from django.db import models

from users.models import CustomUser

# Create your models here.
class Favourites(models.Model):
    user = models.ForeignKey( 
        CustomUser,
        on_delete=models.CASCADE,
        related_name='favourites',
        verbose_name="المستخدم"
    )
    hotel = models.ForeignKey(
        'HotelManagement.Hotel',
        on_delete=models.CASCADE,
        related_name='favourited_by',
        verbose_name="hotel"
    )

    class Meta:
        verbose_name = "المفضلات"
        verbose_name_plural = "المفضلات"
        constraints = [
            models.UniqueConstraint(fields=['user', 'hotel'], name='unique_user_hotel')
        ]

    def __str__(self):
        return f"{self.user.name} - {self.hotel}"
