from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver
from django.core.exceptions import ObjectDoesNotExist
from django.utils import timezone
from .models import Payment, PaymentHistory 

@receiver(pre_save, sender=Payment)
def store_payment_pre_save(sender, instance, **kwargs):
    """
    Store a copy of the Payment instance before saving (if it exists)
    """
    if instance.pk:
        try:
            instance._pre_save_instance = sender.objects.get(pk=instance.pk)
        except ObjectDoesNotExist:
            instance._pre_save_instance = None
    else:
        instance._pre_save_instance = None

@receiver(post_save, sender=Payment)
def create_payment_history_on_change(sender, instance, created, **kwargs):

    pre_instance = getattr(instance, '_pre_save_instance', None)
    if not pre_instance:
        return

    changes_detected = (
        pre_instance.payment_status != instance.payment_status or
        pre_instance.payment_totalamount != instance.payment_totalamount or
        pre_instance.payment_discount != instance.payment_discount or
        pre_instance.payment_discount_code != instance.payment_discount_code or
        pre_instance.booking != instance.booking 
    )


    if changes_detected:
        PaymentHistory.objects.create(
            payment=instance,
            changed_by=instance.user,
            previous_status=str(pre_instance.payment_status),
            new_status=str(instance.payment_status),
            previous_payment_status=pre_instance.payment_status,
            new_payment_status=instance.payment_status,
            previous_payment_totalamount=pre_instance.payment_totalamount,
            new_payment_totalamount=instance.payment_totalamount,
            previous_payment_discount=pre_instance.payment_discount,
            new_payment_discount=instance.payment_discount,
            previous_payment_discount_code=pre_instance.payment_discount_code,
            new_payment_discount_code=instance.payment_discount_code,
            note=f"Payment updated on {timezone.now()}"
        )
