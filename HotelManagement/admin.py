from django.contrib import admin
from django.db.models import Count
from django.http import HttpResponse
from django.utils import timezone
from django.template.loader import get_template
from django.conf import settings
import os
from django.template.loader import render_to_string
from io import BytesIO
from users.models import CustomUser
from .models import Hotel, Location, Phone, Image, City , HotelRequest
from django.contrib.auth import get_user_model
from django import forms
from django.utils.html import format_html
import arabic_reshaper
from bidi.algorithm import get_display
import xlwt
from reportlab.pdfgen import canvas
from reportlab.lib import colors
from reportlab.lib.pagesizes import landscape, A4
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

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
    rows = queryset.values_list('name', 'email', 'is_verified', 'created_at')
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
    search_fields = ['name', 'email']
    list_filter = ['location__city', 'is_verified', 'created_at']
    actions = [export_to_excel, 'export_to_pdf']
    
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
                'hotels_by_city': self.get_queryset(request).values('location__city__state').annotate(count=Count('id')),
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

    def export_to_pdf(self, request, queryset):
        # إعداد استجابة PDF
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = 'attachment; filename="hotels_report.pdf"'

        # إنشاء مستند PDF
        doc = SimpleDocTemplate(
            response,
            pagesize=landscape(A4),
            rightMargin=30,
            leftMargin=30,
            topMargin=30,
            bottomMargin=30
        )

        # تسجيل الخط العربي
        font_path = os.path.join(settings.BASE_DIR, 'static', 'fonts', 'NotoKufiArabic-Regular.ttf')
        pdfmetrics.registerFont(TTFont('NotoKufiArabic', font_path))

        # تحضير البيانات
        elements = []
        data = []

        # إضافة العناوين
        headers = [
            get_display(arabic_reshaper.reshape('#')),
            get_display(arabic_reshaper.reshape('اسم الفندق')),
            get_display(arabic_reshaper.reshape('الموقع')),
            get_display(arabic_reshaper.reshape('المدينة')),
            get_display(arabic_reshaper.reshape('البريد الإلكتروني')),
            get_display(arabic_reshaper.reshape('حالة التحقق')),
            get_display(arabic_reshaper.reshape('عدد الهواتف')),
            get_display(arabic_reshaper.reshape('تاريخ الإنشاء'))
        ]
        data.append(headers)

        # إضافة بيانات الفنادق
        for index, hotel in enumerate(queryset, 1):
            row = [
                str(index),
                get_display(arabic_reshaper.reshape(str(hotel.name))),
                get_display(arabic_reshaper.reshape(str(hotel.location.name if hotel.location else ''))),
                get_display(arabic_reshaper.reshape(str(hotel.location.city.name if hotel.location and hotel.location.city else ''))),
                hotel.email,
                get_display(arabic_reshaper.reshape('تم التحقق' if hotel.is_verified else 'لم يتم التحقق')),
                str(hotel.phones.count()),
                hotel.created_at.strftime('%Y-%m-%d')
            ]
            data.append(row)

        # إنشاء الجدول
        table = Table(data)
        table.setStyle(TableStyle([
            ('FONT', (0, 0), (-1, -1), 'NotoKufiArabic'),
            ('FONTSIZE', (0, 0), (-1, 0), 14),  # حجم خط العناوين
            ('FONTSIZE', (0, 1), (-1, -1), 12),  # حجم خط البيانات
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#2d3748')),  # لون خلفية العناوين
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),  # لون نص العناوين
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),  # محاذاة النص
            ('GRID', (0, 0), (-1, -1), 1, colors.black),  # إطار الجدول
            ('BOTTOMPADDING', (0, 0), (-1, 0), 12),  # تباعد أسفل العناوين
            ('BACKGROUND', (0, 1), (-1, -1), colors.white),  # لون خلفية البيانات
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.HexColor('#f7fafc')]),  # تناوب لون الصفوف
            ('LEFTPADDING', (0, 0), (-1, -1), 10),
            ('RIGHTPADDING', (0, 0), (-1, -1), 10),
        ]))

        elements.append(table)
        
        # إنشاء المستند
        doc.build(elements)
        return response

    export_to_pdf.short_description = "تصدير المحدد إلى PDF"
    
# ---------- Hotel -------------


# ----------- Location --------------
@admin.register(Location)
class LocationAdmin(admin.ModelAdmin):
    list_display = ( 'address', 'city', 'slug', 'created_at')
    readonly_fields = ('slug',)
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
    list_display = ( 'state', 'country', 'slug', 'created_at')
    readonly_fields = ('slug',)
    search_fields = ( 'state', 'country')
    list_filter = ('state', 'country')

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
           
            return queryset.filter(location__hotel__manager=request.user)
        return queryset.none()
admin.site.register(City, CityAdmin)

class HotelRequestAdmin(admin.ModelAdmin):
    # define your admin model here
    pass

admin.site.register(HotelRequest, HotelRequestAdmin)