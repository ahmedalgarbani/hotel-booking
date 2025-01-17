from django.contrib import admin
from django.db.models import Count
from django.http import HttpResponse
import xlwt
from django.utils import timezone
from users.models import CustomUser
from .models import Hotel, Location, Phone, Image, City
from django.contrib.auth import get_user_model
from django import forms
from django.utils.html import format_html

User = get_user_model()

def export_to_excel(modeladmin, request, queryset):
    response = HttpResponse(content_type='application/ms-excel')
    response['Content-Disposition'] = 'attachment; filename="hotels_report.xls"'
    
    wb = xlwt.Workbook(encoding='utf-8')
    ws = wb.add_sheet('Hotels Report')
    
    # العناوين
    row_num = 0
    columns = ['اسم الفندق', 'الموقع', 'المدينة', 'البريد الإلكتروني', 'حالة التحقق', 'تاريخ الإنشاء']
    
    for col_num in range(len(columns)):
        ws.write(row_num, col_num, columns[col_num])
        
    # البيانات
    rows = queryset.values_list('name', 'location__name', 'location__city__name', 'email', 'is_verified', 'created_at')
    for row in rows:
        row_num += 1
        for col_num in range(len(row)):
            ws.write(row_num, col_num, str(row[col_num]))
            
    wb.save(response)
    return response

export_to_excel.short_description = "تصدير الفنادق المحددة إلى Excel"

@admin.register(Hotel)
class HotelAdmin(admin.ModelAdmin):
    list_display = ['name', 'location', 'email', 'verification_status', 'phone_count', 'created_at']
    search_fields = ['name', 'email', 'location__name']
    list_filter = ['location__city', 'is_verified', 'created_at']
    actions = [export_to_excel]
    
    def verification_status(self, obj):
        if obj.is_verified:
            return format_html('<span style="color: green;">✓ تم التحقق</span>')
        return format_html('<span style="color: red;">✗ لم يتم التحقق</span>')
    verification_status.short_description = "حالة التحقق"

    def phone_count(self, obj):
        return obj.phones.count()
    phone_count.short_description = "عدد أرقام الهاتف"

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(manager=request.user)
        return queryset.none()
    
    def changelist_view(self, request, extra_context=None):
        if not extra_context:
            extra_context = {}

        # إحصائيات للأدمن
        if request.user.is_superuser or request.user.user_type == 'admin':
            stats = {
                'total_hotels': self.get_queryset(request).count(),
                'verified_hotels': self.get_queryset(request).filter(is_verified=True).count(),
                'unverified_hotels': self.get_queryset(request).filter(is_verified=False).count(),
                'hotels_by_city': self.get_queryset(request).values('location__city__name').annotate(count=Count('id')),
                'recent_hotels': self.get_queryset(request).order_by('-created_at')[:5],
                'user_type': 'admin'
            }
        # إحصائيات لمدير الفندق
        elif request.user.user_type == 'hotel_manager':
            hotel = self.get_queryset(request).first()
            if hotel:
                stats = {
                    'hotel_name': hotel.name,
                    'verification_status': hotel.is_verified,
                    'verification_date': hotel.verification_date,
                    'total_phones': hotel.phones.count(),
                    'location_info': {
                        'city': hotel.location.city.name if hotel.location and hotel.location.city else '',
                        'address': hotel.location.address if hotel.location else '',
                    },
                    'total_images': Image.objects.filter(hotel_id=hotel).count(),
                    'user_type': 'hotel_manager'
                }
            else:
                stats = {
                    'message': 'لا يوجد فندق مرتبط بحسابك',
                    'user_type': 'hotel_manager'
                }
        
        extra_context['stats'] = stats
        return super().changelist_view(request, extra_context=extra_context)

# ---------- Hotel -------------


# ----------- Location --------------
@admin.register(Location)
class LocationAdmin(admin.ModelAdmin):
    list_display = ('name', 'address', 'city', 'slug', 'created_at')
    readonly_fields = ('slug',)
    search_fields = ('name', 'city__name')
    list_filter = ('city',)

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
           
            return queryset.filter(hotel__manager=request.user)
        return queryset.none()

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
           
            form.base_fields['city'].queryset = City.objects.filter(location__hotel__manager=request.user)
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user
                form.base_fields['updated_by'].widget.attrs['readonly'] = False
                form.base_fields['updated_by'].required = False
            
            if 'created_by' in form.base_fields:
                form.base_fields['created_by'].initial = request.user
                form.base_fields['created_by'].widget.attrs['readonly'] = True
                form.base_fields['created_by'].required = False
        return form

    def save_model(self, request, obj, form, change):
        if not obj.pk and request.user.user_type == 'hotel_manager':
           
            obj.save()
            hotel = Hotel.objects.get(manager=request.user)
            obj.hotel = hotel
            obj.created_by = request.user
            obj.updated_by = request.user
            obj.save()
        else:
            obj.updated_by = request.user
            super().save_model(request, obj, form, change)

# ----------- Phone --------------
@admin.register(Phone)
class PhoneAdmin(admin.ModelAdmin):
    list_display = ('phone_number', 'country_code', 'hotel', 'created_at')
    search_fields = ('phone_number', 'hotel__name')
    list_filter = ('hotel',)

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            return queryset.filter(hotel__manager=request.user)
        return queryset.none()

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            
            hotel = Hotel.objects.get(manager=request.user)
            form.base_fields['hotel'].queryset = Hotel.objects.filter(id=hotel.id)
            form.base_fields['hotel'].initial = hotel
            form.base_fields['hotel'].widget.attrs['readonly'] = True
            
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user
                form.base_fields['updated_by'].widget.attrs['readonly'] = True
                form.base_fields['updated_by'].required = False
            
            if 'created_by' in form.base_fields:
                form.base_fields['created_by'].initial = request.user
                form.base_fields['created_by'].widget.attrs['readonly'] = True
                form.base_fields['created_by'].required = False
        return form

    def save_model(self, request, obj, form, change):
        if not change: 
            if request.user.user_type == 'hotel_manager':
                obj.hotel = Hotel.objects.get(manager=request.user)
            obj.created_by = request.user
            obj.updated_by = request.user
        else:  
            if request.user.user_type == 'hotel_manager':
                
                if not obj.hotel:
                    obj.hotel = Hotel.objects.get(manager=request.user)
            obj.updated_by = request.user
        
        super().save_model(request, obj, form, change)

# ----------- Image --------------

class ImageAdminForm(forms.ModelForm):
    class Meta:
        model = Image
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        request = kwargs.pop('request', None)
        super().__init__(*args, **kwargs)
        
        if request and hasattr(request, 'user') and request.user.user_type == 'hotel_manager':
            hotel = Hotel.objects.get(manager=request.user)
            self.fields['hotel_id'].initial = request.user
            self.fields['hotel_id'].disabled = True
            
            if 'updated_by' in self.fields:
                self.fields['updated_by'].initial = request.user
                self.fields['updated_by'].disabled = True
                self.fields['updated_by'].required = False
            
            if 'created_by' in self.fields:
                self.fields['created_by'].initial = request.user
                self.fields['created_by'].disabled = True
                self.fields['created_by'].required = False

@admin.register(Image)
class ImageAdmin(admin.ModelAdmin):
    form = ImageAdminForm
    list_display = ('image_path', 'image_url', 'hotel_id', 'created_at')
    search_fields = ('image_path',)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        if not request.user.is_superuser and request.user.user_type == 'hotel_manager':
            
            form.base_fields['hotel_id'].queryset = Hotel.objects.filter(manager=request.user)
            form.base_fields['hotel_id'].initial = Hotel.objects.filter(manager=request.user).first()
            form.base_fields['hotel_id'].widget.attrs['readonly'] = True
            form.base_fields['hotel_id'].required = False
            
            if 'updated_by' in form.base_fields:
                form.base_fields['updated_by'].initial = request.user
                form.base_fields['updated_by'].widget.attrs['disabled'] = True
                form.base_fields['updated_by'].required = False
            
            if 'created_by' in form.base_fields:
                
                form.base_fields['created_by'].widget.attrs['disabled'] = True
                form.base_fields['created_by'].initial = request.user
                form.base_fields['created_by'].required = False
        return form

    def save_model(self, request, obj, form, change):
        
        
        if not obj.pk and request.user.user_type == 'hotel_manager':
           
            obj.hotel_id = Hotel.objects.filter(manager=request.user).first()
            obj.created_by = request.user
            obj.updated_by = request.user
        else:
            obj.updated_by = request.user
        super().save_model(request, obj, form, change)

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
             return queryset.filter(hotel_id__manager=request.user)
        
        return queryset.none()
       

# ----------- City --------------

class CityAdmin(admin.ModelAdmin):
    list_display = ('name', 'state', 'country', 'slug', 'created_at')
    readonly_fields = ('slug',)
    search_fields = ('name', 'state', 'country')
    list_filter = ('state', 'country')

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
           
            return queryset.filter(location__hotel__manager=request.user)
        return queryset.none()
admin.site.register(City, CityAdmin)
