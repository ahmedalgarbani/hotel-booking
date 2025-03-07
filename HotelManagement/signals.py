from django.db.models.signals import pre_save
from django.dispatch import receiver
from django.utils import timezone
from .models import BaseModel

@receiver(pre_save, sender=BaseModel)
def set_created_by_updated_by(sender, instance, **kwargs):
    request = kwargs.get('request', None)
    if request:
        if not instance.pk:
            instance.created_by = request.user
        instance.updated_by = request.user