from datetime import timezone
from django.contrib import admin
from django.db.models import Q

from .models import ChartOfAccounts, JournalEntry
from api.admin import admin_site
# Register your models here.
from django.contrib import admin

class JournalEntryAdmin(admin.ModelAdmin):
    list_display = (
        "journal_entry_number",
        "journal_entry_date",
        "journal_entry_account",
        "journal_entry_in_amount",
        "journal_entry_out_amount",
        "journal_entry_currency",
        "journal_entry_exchange_rate",
        "journal_entry_tax",
    )
    search_fields = ("journal_entry_number", "journal_entry_description", "journal_entry_notes")
    list_filter = ("journal_entry_date", "journal_entry_currency", "journal_entry_account")
    ordering = ("-journal_entry_date",)
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
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
    
admin_site.register(JournalEntry, JournalEntryAdmin)

class ChartOfAccountsAdmin(admin.ModelAdmin):
    list_display = ('account_number', 'account_name', 'account_type', 'account_parent')
    search_fields = ('account_number', 'account_name')
    list_filter = ('account_type', 'account_parent')
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at','created_by', 'updated_by','deleted_at')
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
    
    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.account_created_at = timezone.now()
        obj.account_updated_at = timezone.now()
        super().save_model(request, obj, form, change)

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        queryset = queryset.select_related('account_parent')
        return queryset

    # def get_total_balance(account):
    #     total = account.account_balance
    #     for child in account.get_children():
    #         total += get_total_balance(child)
    #     return total



admin_site.register(ChartOfAccounts,ChartOfAccountsAdmin)
