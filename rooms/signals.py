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
    """إنشاء سجلات توفر للأيام القادمة عند إنشاء نوع غرفة جديد"""
    if created:
        room_status, _ = RoomStatus.objects.get_or_create(
            hotel=instance.hotel,
            code="AVAILABLE",
            defaults={
                "name": "Available",
                "description": "Default status for available rooms",
                "is_available": True,
            }
        )

        today = timezone.now().date()
        # إنشاء سجلات للـ 90 يوم القادمة
        availability_records = []
        for i in range(90):  # 90 يوم
            date = today + timedelta(days=i)
            availability_records.append(
                Availability(
                    hotel=instance.hotel,
                    room_type=instance,
                    room_status=room_status,
                    date=date,
                    available_rooms=instance.rooms_count,
                    price=instance.base_price,
                    notes="Initial availability created automatically."
                )
            )
        # إنشاء كل السجلات دفعة واحدة
        Availability.objects.bulk_create(availability_records)

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
    """تطبيق السعر الموسمي على سجلات التوافر"""
    if created:
        # التأكد من وجود سجلات توفر للفترة المطلوبة
        start_date = instance.date_from
        end_date = instance.date_to
        room_type = instance.room_type
        hotel = instance.hotel
        room_status = RoomStatus.objects.get(hotel=hotel, code="AVAILABLE")

        # إنشاء سجلات توفر للأيام غير الموجودة
        existing_dates = set(Availability.objects.filter(
            room_type=room_type,
            date__gte=start_date,
            date__lte=end_date
        ).values_list('date', flat=True))

        new_records = []
        current_date = start_date
        while current_date <= end_date:
            if current_date not in existing_dates:
                new_records.append(
                    Availability(
                        hotel=hotel,
                        room_type=room_type,
                        room_status=room_status,
                        date=current_date,
                        available_rooms=room_type.rooms_count,
                        price=instance.price,
                        notes="Created for seasonal price"
                    )
                )
            current_date += timedelta(days=1)

        if new_records:
            Availability.objects.bulk_create(new_records)

        # تحديث الأسعار للسجلات الموجودة
        Availability.objects.filter(
            room_type=instance.room_type,
            date__gte=instance.date_from,
            date__lte=instance.date_to,
            price=instance.room_type.base_price  # تحديث فقط إذا كان السعر هو الأساسي
        ).update(price=instance.price)
