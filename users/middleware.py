from django.urls import resolve
from django.contrib import admin
from .models import UserPermission

class AdminTablePermissionsMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if request.path.startswith('/admin/') and request.user.is_authenticated:
            try:
                # الحصول على صلاحيات المستخدم
                user_permission = UserPermission.objects.filter(
                    user=request.user,
                    is_active=True
                ).first()
                
                if user_permission:
                    permission_group = user_permission.permission_group
                    
                    # قائمة الجداول المخفية
                    hidden_models = []
                    
                    # التحقق من صلاحيات عرض كل جدول
                    if not permission_group.can_view_hotel_model:
                        hidden_models.append('hotel')
                    if not permission_group.can_view_image_model:
                        hidden_models.append('image')
                    if not permission_group.can_view_location_model:
                        hidden_models.append('location')
                    if not permission_group.can_view_city_model:
                        hidden_models.append('city')
                    if not permission_group.can_view_room_model:
                        hidden_models.append('room')
                    if not permission_group.can_view_booking_model:
                        hidden_models.append('booking')
                    if not permission_group.can_view_review_model:
                        hidden_models.append('review')
                    if not permission_group.can_view_service_model:
                        hidden_models.append('service')
                    if not permission_group.can_view_payment_model:
                        hidden_models.append('payment')
                    if not permission_group.can_view_offer_model:
                        hidden_models.append('offer')
                    
                    # إخفاء الجداول غير المصرح بها
                    for model_name in hidden_models:
                        admin.site.unregister(model_name)
            except Exception as e:
                # تسجيل الخطأ إذا حدث
                print(f"Error in AdminTablePermissionsMiddleware: {e}")
        
        return self.get_response(request)
