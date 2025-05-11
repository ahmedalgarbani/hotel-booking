from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _
from payments.models import Payment
from users.utils import send_whatsapp_via_sadeem
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
            if instance.payment_status == '1':  # تم الدفع
                print("hi ahmed signals status 1")
                
                notification_type = '2'  
                title = _("تم تأكيد دفعة جديدة")
                message = _(f"تم تأكيد دفعة بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}")
            elif instance.payment_status == '0':  # قيد الانتظار
                print("hi ahmed signals status 0")
                notification_type = '1'  
                title = _("دفعة جديدة قيد الانتظار")
                message = _(f"هناك دفعة جديدة قيد الانتظار بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}")
            elif instance.payment_status == '2':  # مرفوض
                print("hi ahmed signals status 2")
                notification_type = '3' 
                title = _("تم رفض دفعة")
                message = _(f"تم رفض دفعة بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}")
            else:
                print("hi ahmed signals status else")
                notification_type = '0'
                title = _("دفعة غير معروفة")
                message = _(f"تم تغيير حالة دفعة غير معروفة للحجز رقم ")
            if not created:
                Notifications.objects.create(
                    sender=instance.user if instance.user else hotel_manager,
                    user=hotel_manager,
                    title=title,
                    message=message,
                    notification_type=notification_type,
                    action_url=f"admin/payments/payment-detail/{instance.id}/",
                    is_active=True
                )
            
            if instance.user and instance.user != hotel_manager:
                user_title = ""
                user_message = ""
                if pre_instance:
                    if pre_instance.payment_status in [0,2] and instance.payment_status == 1:
                        user_title = _("تم تأكيد الدفع")
                        user_message = _(
                            f"تم تأكيد دفعتك بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}"
                        )
                    
                        send_whatsapp_via_sadeem(
    phone_number=f"+{instance.user.phone}",
    message=(
        f"✅ *تم تأكيد الدفعة بنجاح!*\n"
        f"💵 المبلغ: {instance.payment_totalamount} {instance.payment_currency}\n"
        f"📄 رقم الحجز: {instance.booking.id}\n\n"
        f"🎉 شكرًا لاختيارك لنا.\n"
        f"نتمنى لك إقامة رائعة ومليئة بالراحة والمتعة! 🏨✨\n"
        f"📞 لا تتردد في التواصل معنا لأي استفسار."
    )
)   
                    elif instance.payment_status == '1':
                        user_title = _("تم تأكيد الدفع")
                        user_message = _(
                                    f"تم تأكيد دفعتك بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}"
                                )
                            
                        send_whatsapp_via_sadeem(
    phone_number=f"+{instance.user.phone}",
    message=(
        f"✅ *تم تأكيد الدفعة بنجاح!*\n"
        f"💵 المبلغ: {instance.payment_totalamount} {instance.payment_currency}\n"
        f"📄 رقم الحجز: {instance.booking.id}\n\n"
        f"🎉 شكرًا لاختيارك لنا.\n"
        f"نتمنى لك إقامة رائعة ومليئة بالراحة والمتعة! 🏨✨\n"
        f"📞 لا تتردد في التواصل معنا لأي استفسار."
    )
)          



                    elif instance.payment_status == '0':  # قيد الانتظار
                            user_title = _("دفعتك قيد المراجعة")
                            send_whatsapp_via_sadeem(
            phone_number=f"+{instance.user.phone}",
        message=(
            f"⏳ *دفعتك قيد المراجعة*\n"
            f"المبلغ: {instance.payment_totalamount} {instance.payment_currency}\n"
            f"رقم الحجز: {instance.booking.id}\n\n"
            f"سنقوم بإبلاغك فور الانتهاء من المراجعة."
        )
    )

                            user_message = _(f"دفعتك بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id} قيد المراجعة")
                    else:  # مرفوض
                            print(instance.payment_status)
                            print(instance.payment_status)
                            
                            user_title = _("تم رفض الدفع")
                            user_message = _(f"تم رفض دفعتك بقيمة {instance.payment_totalamount} {instance.payment_currency} للحجز رقم {instance.booking.id}. يرجى التواصل مع إدارة الفندق")
                            
                            send_whatsapp_via_sadeem(
        phone_number=f"+{instance.user.phone}",
        message=(
            f"❌ *تم رفض الدفعة*\n"
            f"المبلغ: {instance.payment_totalamount} {instance.payment_currency}\n"
            f"رقم الحجز: {instance.booking.id}\n\n"
            f"يرجى التواصل مع إدارة الفندق لمزيد من التفاصيل."
        )
    )

                if user_message :
                    Notifications.objects.create(
                        sender=hotel_manager,
                        user=instance.user,
                        title=user_title,
                        message=user_message,
                        notification_type=notification_type,
                        action_url=f"/bookings/details/{instance.booking.id}/",
                        is_active=True
                    )
