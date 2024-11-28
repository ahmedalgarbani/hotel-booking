from django.contrib import admin
from .models import Service

@admin.register(Service)
class ServiceAdmin(admin.ModelAdmin):
    #TODO ------- add room to list display when abdullah done
    list_display = ('name', 'is_active', 'hotel')
    list_filter = ('is_active', 'hotel')
    search_fields = ('name', 'description')
