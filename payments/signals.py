import random
from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver
from django.core.exceptions import ObjectDoesNotExist
from django.utils import timezone
from .models import Payment, PaymentHistory 
from accounts.services import *

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



def perform_confirmation_action(payment_instance):
    """
    Custom logic to execute when payment is confirmed.
        journal_entry_number=kwargs["journal_entry_number"],
        journal_entry_account=kwargs["journal_entry_account"],
    )
    """
    random_number = random.randint(1000, 9999)

    create_journal_entry(
        journal_entry_number = F"ENT-{random_number}",
        journal_entry_account = payment_instance.user.chart,
        journal_entry_in_amount=0,
        journal_entry_out_amount=payment_instance.payment_totalamount,
        journal_entry_notes = "مقابل دفع حجز"
    )
    create_journal_entry(
        journal_entry_number = F"ENT-{random_number}",
        journal_entry_account = ChartOfAccounts.objects.get(account_number="1102") if payment_instance.payment_type == 'chache' else ChartOfAccounts.objects.get(account_number="1103"),
        journal_entry_in_amount=payment_instance.payment_totalamount,
        journal_entry_out_amount=0,
        journal_entry_notes = "مقابل دفع حواله"
    )
    booking = payment_instance.booking
    booking.status = '1'  
    booking.save()

@receiver(pre_save, sender=Payment)
def capture_old_payment_status(sender, instance, **kwargs):
    """
    Captures the payment_status value before saving the instance.
    """
    if instance.pk: 
        try:
            old_instance = Payment.objects.get(pk=instance.pk)
            instance._old_payment_status = old_instance.payment_status
        except Payment.DoesNotExist:
            instance._old_payment_status = None
    else: 
        instance._old_payment_status = None

@receiver(post_save, sender=Payment)
def handle_payment_confirmation(sender, instance, created, **kwargs):
    """
    Triggers an action when payment_status changes to 1 (confirmed).
    """
    if instance.payment_status == 1:
        if created:
            perform_confirmation_action(instance)
        else:
            old_status = getattr(instance, '_old_payment_status', None)
            if old_status != 1:
                perform_confirmation_action(instance)