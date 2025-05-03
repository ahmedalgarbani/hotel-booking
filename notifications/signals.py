from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _
from payments.models import Payment
from .models import Notifications

@receiver(post_save, sender=Payment)
def create_payment_notification(sender, instance, created, **kwargs):
    """
    إنشاء إشعارات عند تغيير حالة الدفع
    """
    # الحصول على النسخة السابقة من الدفع (إذا كانت موجودة)
    pre_instance = getattr(instance, '_pre_save_instance', None)
    
    # إذا كان هناك تغيير في حالة الدفع أو تم إنشاء دفعة جديدة
    if created or (pre_instance and pre_instance.payment_status != instance.payment_status):
        # إرسال إشعار لمدير الفندق
        hotel_manager = instance.booking.hotel.manager
        
        if hotel_manager:
            # تحديد نوع الإشعار ونص الرسالة بناءً على حالة الدفع
            if instance.payment_status == 1:  # تم الدفع
                notification_type = '2'  # نجاح
                title = _("تم تأكيد دفعة جديدة")
                message = _(f"تم تأكيد دفعة بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}")
            elif instance.payment_status == 0:  # قيد الانتظار
                notification_type = '1'  # تحذير
                title = _("دفعة جديدة قيد الانتظار")
                message = _(f"هناك دفعة جديدة قيد الانتظار بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}")
            else:  # مرفوض
                notification_type = '3'  # خطأ
                title = _("تم رفض دفعة")
                message = _(f"تم رفض دفعة بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}")
            
            # إنشاء الإشعار
            Notifications.objects.create(
                sender=instance.user if instance.user else hotel_manager,
                user=hotel_manager,
                title=title,
                message=message,
                notification_type=notification_type,
                action_url=f"/admin/payments/payment/{instance.id}/change/",
                is_active=True
            )
            
            # إرسال إشعار للعميل أيضًا إذا كان موجودًا
            if instance.user and instance.user != hotel_manager:
                if instance.payment_status == 1:  # تم الدفع
                    user_title = _("تم تأكيد الدفع")
                    user_message = _(f"تم تأكيد دفعتك بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}")
                elif instance.payment_status == 0:  # قيد الانتظار
                    user_title = _("دفعتك قيد المراجعة")
                    user_message = _(f"دفعتك بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id} قيد المراجعة")
                else:  # مرفوض
                    user_title = _("تم رفض الدفع")
                    user_message = _(f"تم رفض دفعتك بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}. يرجى التواصل مع إدارة الفندق")
                
                Notifications.objects.create(
                    sender=hotel_manager,
                    user=instance.user,
                    title=user_title,
                    message=user_message,
                    notification_type=notification_type,
                    action_url=f"/bookings/details/{instance.booking.id}/",
                    is_active=True
                )
