from datetime import timezone
from django.contrib import admin
from .models import ChartOfAccounts
from api.admin import admin_site
# Register your models here.

class ChartOfAccountsAdmin(admin.ModelAdmin):
    list_display = ('account_number', 'account_name', 'account_type', 'account_parent')
    search_fields = ('account_number', 'account_name')
    list_filter = ('account_type', 'account_parent')
    readonly_fields = ('account_created_at', 'account_updated_at')
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
