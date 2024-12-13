from django.contrib import admin
from django.utils.translation import gettext_lazy as _
from .models import Guest
from django import forms

class GuestAdminForm(forms.ModelForm):
    class Meta:
        model = Guest
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        request = kwargs.pop('request', None)
        super().__init__(*args, **kwargs)
        
        if request and hasattr(request, 'user') and request.user.user_type == 'hotel_manager':
            hotel = request.user.hotel
            self.fields['hotel'].initial = hotel
            self.fields['hotel'].disabled = True
            
            if 'created_by' in self.fields:
                self.fields['created_by'].initial = request.user
                self.fields['created_by'].disabled = True
            
            if 'updated_by' in self.fields:
                self.fields['updated_by'].initial = request.user
                self.fields['updated_by'].disabled = True

@admin.register(Guest)
class GuestAdmin(admin.ModelAdmin):
    form = GuestAdminForm
    list_display = ['guest_name', 'guest_phone', 'hotel', 'created_at']
    search_fields = ['guest_name', 'guest_phone', 'guest_email']
    list_filter = ['hotel', 'guest_nationality']
    fieldsets = (
        (_('معلومات أساسية'), {
            'fields': ('guest_name', 'guest_phone', 'guest_email', 'hotel')
        }),
        (_('معلومات شخصية'), {
            'fields': ('guest_nationality', 'guest_dob', 'guest_address','special_requests')
        }),
        (_('معلومات الهوية'), {
            'fields': ('guest_id_type', 'guest_id_number')
        }),
        
        (_('ملاحظات'), {
            'fields': ('notes',)
        }),
    )

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        return queryset.none()

    def has_add_permission(self, request):
        return request.user.is_superuser or request.user.user_type in ['admin', 'hotel_manager']

    def has_change_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def has_delete_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def has_view_permission(self, request, obj=None):
        if not obj:
            return True
        if request.user.is_superuser or request.user.user_type == 'admin':
            return True
        return request.user.user_type == 'hotel_manager' and obj.hotel.manager == request.user

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        form.request = request
        return form

    def save_model(self, request, obj, form, change):
        if not change:  # If creating new object
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)