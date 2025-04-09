from django.contrib import admin
from django import forms
from django.shortcuts import redirect, render
from django.urls import path
from django.http import HttpResponseRedirect
from django.contrib import messages
from django.db.models import Q

from bookings.models import Booking
from notifications.forms import AdminNotificationForm
from users.models import CustomUser
from .models import Notifications

class AutoUserTrackMixin:
    def save_model(self, request, obj, form, change):
        if not obj.pk: 
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)

class NotificationForm(forms.ModelForm):
    class Meta:
        model = Notifications
        fields = '__all__'
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if 'user' in self.fields:
            self.fields['user'].required = False

class NotificationsAdmin(AutoUserTrackMixin, admin.ModelAdmin):
    form = NotificationForm
    list_display = ('sender', 'get_recipient', 'message', 'send_time', 'status', 'notification_type', 'is_active')
    list_filter = ('status', 'notification_type', 'is_active', 'send_time', 'recipient_type')
    search_fields = ('sender__username', 'user__username', 'message')
    ordering = ('-send_time',)
    actions = ['mark_as_read', 'mark_as_unread']
    readonly_fields =('created_at', 'updated_at','sender','created_by', 'updated_by','deleted_at')
    
    def get_recipient(self, obj):
        if obj.user:
            return obj.user
        return obj.get_recipient_type_display()
    get_recipient.short_description = "المستلم"
    
    def get_fields(self, request, obj=None):
        fields = super().get_fields(request, obj)
        if not request.user.is_superuser and not request.user.user_type == 'admin':
            fields.remove('recipient_type')
        return fields
    
    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and not request.user.user_type == 'admin':
            if 'recipient_type' in form.base_fields:
                form.base_fields['recipient_type'].disabled = True
        return form
    
    

    
    def save_model(self, request, obj, form, change):
        if not change: 
            obj.sender = request.user
            
            if obj.recipient_type == 'single_user' and not obj.user:
                messages.error(request, "يجب تحديد مستخدم عند اختيار 'مستخدم واحد'")
                return
            
            if request.user.is_superuser or request.user.user_type == 'admin':
                if obj.recipient_type == 'all_customers':
                    from users.models import CustomUser
                    customers = CustomUser.objects.filter(user_type='customer')
                    for customer in customers:
                        Notifications.objects.create(
                            sender=request.user,
                            user = customer,
                            title=obj.title,
                            recipient_type='all_customers',
                            message=obj.message,
                            notification_type=obj.notification_type,
                            action_url=obj.action_url
                        )
                    messages.success(request, f"تم إرسال الإشعار إلى جميع العملاء ({customers.count()} مستخدم)")
                    return
                elif obj.recipient_type == 'all_hotel_managers':
                    from users.models import CustomUser
                    managers = CustomUser.objects.filter(user_type='hotel_manager')
                    for manager in managers:
                        Notifications.objects.create(
                            sender=request.user,
                            recipient_type='all_hotel_managers',
                            user = manager,
                            title = obj.title,
                            message=obj.message,
                            notification_type=obj.notification_type,
                            action_url=obj.action_url
                        )
                    messages.success(request, f"تم إرسال الإشعار إلى جميع مديري الفنادق ({managers.count()} مستخدم)")
                    return
            
            elif request.user.user_type == 'hotel_manager':
                if obj.recipient_type == 'booked_customers':
                    reservations = Booking.objects.filter(hotel__manager=request.user, status='active')
                    customers = set([res.customer for res in reservations])
                    for customer in customers:
                        Notifications.objects.create(
                            sender=request.user,
                            user=customer,
                                                        title = obj.title,

                            recipient_type='booked_customers',
                            message=obj.message,
                            notification_type=obj.notification_type,
                            action_url=obj.action_url
                        )
                    messages.success(request, f"تم إرسال الإشعار إلى العملاء الحاليين ({len(customers)} مستخدم)")
                    return
                else:
                    obj.recipient_type = 'single_user'
        
        super().save_model(request, obj, form, change)
    
    def mark_as_read(self, request, queryset):
        queryset.update(status='1')
    mark_as_read.short_description = "تحديد كمقروء"

    def mark_as_unread(self, request, queryset):
        queryset.update(status='0')
    mark_as_unread.short_description = "تحديد كغير مقروء"
    
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','sender', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    
    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(Q(user=request.user) | Q(sender=request.user))
        elif request.user.user_type == 'hotel_staff':
            return queryset.filter(user=request.user.chield)
        return queryset.none()

from api.admin import admin_site
admin_site.register(Notifications, NotificationsAdmin)