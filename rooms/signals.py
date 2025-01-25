from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _
from .models import RoomType, Availability, RoomStatus, RoomPrice
from django.utils import timezone
from datetime import timedelta

@receiver(pre_save, sender=RoomType)
def store_old_price(sender, instance, **kwargs):
    """حفظ السعر القديم قبل التحديث"""
    if instance.id:
        try:
            instance._original_base_price = RoomType.objects.get(id=instance.id).base_price
        except RoomType.DoesNotExist:
            instance._original_base_price = instance.base_price

@receiver(post_save, sender=RoomType)
def create_availability_for_room_type(sender, instance, created, **kwargs):
    """إنشاء سجل توفر عند إنشاء نوع غرفة جديد"""
    if created:
        available_status = RoomStatus.objects.get(
            hotel=instance.hotel,
            code='AVAILABLE'
        )
        
        # إنشاء سجل توفر أولي بالسعر الأساسي
        Availability.objects.create(
            hotel=instance.hotel,
            room_type=instance,
            room_status=available_status,
            date=timezone.now().date(),
            available_rooms=instance.rooms_count,
            price=instance.base_price  # السعر الأساسي من RoomType
        )

@receiver(post_save, sender=RoomType)
def update_future_availability_prices(sender, instance, **kwargs):
    """تحديث أسعار التوافر المستقبلية عند تغيير السعر الأساسي"""
    if not kwargs.get('created') and hasattr(instance, '_original_base_price'):
        if instance.base_price != instance._original_base_price:
            today = timezone.now().date()
            # تحديث فقط السجلات التي تستخدم السعر الأساسي القديم
            Availability.objects.filter(
                room_type=instance,
                date__gte=today,
                price=instance._original_base_price
            ).update(price=instance.base_price)

@receiver(post_save, sender=RoomType)
def update_room_availability_count(sender, instance, **kwargs):
    """تحديث عدد الغرف المتاحة عند تغيير العدد الكلي"""
    if not kwargs.get('created'):
        today = timezone.now().date()
        Availability.objects.filter(
            room_type=instance,
            date__gte=today
        ).update(
            available_rooms=instance.rooms_count
        )

@receiver(pre_save, sender=RoomPrice)
def check_price_overlap(sender, instance, **kwargs):
    """التحقق من عدم تداخل فترات الأسعار"""
    if RoomPrice.objects.filter(
        room_type=instance.room_type,
        date_from__lte=instance.date_to,
        date_to__gte=instance.date_from
    ).exclude(id=instance.id).exists():
        raise ValidationError(
            _("يوجد تداخل مع فترة سعر أخرى لنفس نوع الغرفة")
        )

@receiver(post_save, sender=RoomPrice)
def apply_seasonal_price(sender, instance, created, **kwargs):
    """تطبيق السعر الموسمي على سجلات التوفر"""
    if created:
        # نتحقق من وجود سجل توفر لهذا اليوم
        availability = Availability.objects.filter(
            hotel=instance.hotel,
            room_type=instance.room_type,
            date=instance.date_from
        ).first()

        if availability:
            # تحديث السعر بالسعر الموسمي
            availability.price = instance.price
            availability.save()
        else:
            # إنشاء سجل توفر جديد بالسعر الموسمي
            available_status = RoomStatus.objects.get(
                hotel=instance.hotel,
                code='AVAILABLE'
            )
            Availability.objects.create(
                hotel=instance.hotel,
                room_type=instance.room_type,
                room_status=available_status,
                date=instance.date_from,
                available_rooms=instance.room_type.rooms_count,
                price=instance.price  # السعر الموسمي من RoomPrice
            )
