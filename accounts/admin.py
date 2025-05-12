# accounts/admin.py

from django.contrib import admin
from django.template.response import TemplateResponse
from django.urls import reverse
from django.utils import timezone
from django.contrib import admin
from django.db.models import Q

from .models import ChartOfAccounts, JournalEntry
from api.admin import admin_site
from django.contrib import admin

from django.contrib.admin.helpers import ActionForm # Import ActionForm
from django import forms # Import forms for ActionForm

# --- Journal Entry Admin ---
class JournalEntryAdmin(admin.ModelAdmin):
    list_display = (
        "journal_entry_number",
        "journal_entry_date",
        "journal_entry_account",
        "journal_entry_in_amount",  # Credit
        "journal_entry_out_amount", # Debit
        "journal_entry_currency",
        "journal_entry_exchange_rate",
        "journal_entry_tax",
        "created_by",
        "created_at",
    )
    search_fields = ("journal_entry_number", "journal_entry_description", "journal_entry_notes", "journal_entry_account__account_name")
    list_filter = ("journal_entry_date", "journal_entry_currency", "journal_entry_account")
    ordering = ("-journal_entry_date",)
    readonly_fields = ('created_at', 'updated_at', 'created_by', 'updated_by', 'deleted_at')

    def get_readonly_fields(self, request, obj=None):
        # Prevent non-superusers from editing tracking fields
        if not request.user.is_superuser:
            # Ensure base readonly fields are included
            base_readonly = list(super().get_readonly_fields(request, obj))
            return tuple(base_readonly + ['created_by', 'updated_by'])
        return self.readonly_fields

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        # --- Permission logic ---
        if request.user.is_superuser or request.user.user_type == 'admin':
            return queryset
        elif request.user.user_type == 'hotel_manager':
            # Filter entries created by the manager or their staff
            # Or filter based on accounts linked to the manager's hotel if applicable
            return queryset.filter(Q(created_by=request.user) | Q(created_by__chield=request.user)) # Example filter
        elif request.user.user_type == 'hotel_staff':
            # Filter entries created by the staff member
             return queryset.filter(created_by=request.user)
        return queryset.none()
        # --- End Permission logic ---

    def save_model(self, request, obj, form, change):
        # Automatically set user tracking fields
        if not obj.pk:
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)

    def changelist_view(self, request, extra_context=None):
        # Add the report URL to the context for the template button
        extra_context = extra_context or {}
        extra_context['journal_entries_report_url'] = reverse('accounts:journal-entries-report')
        return super().changelist_view(request, extra_context=extra_context)

# --- Chart of Accounts Admin ---
class ChartOfAccountsAdmin(admin.ModelAdmin):
    list_display = ('account_number', 'account_name', 'account_type', 'account_parent', 'account_balance', 'account_status')
    search_fields = ('account_number', 'account_name')
    list_filter = ('account_type', 'account_parent', 'account_status')
    readonly_fields =('created_at', 'updated_at','created_by', 'updated_by','deleted_at')

    def get_readonly_fields(self, request, obj=None):
        # Prevent non-superusers from editing tracking fields
        if not request.user.is_superuser:
             # Ensure base readonly fields are included
            base_readonly = list(super().get_readonly_fields(request, obj))
            return tuple(base_readonly + ['created_by', 'updated_by'])
        return self.readonly_fields

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        # --- Permission logic (adjust filter as needed) ---
        if request.user.is_superuser or request.user.user_type == 'admin':
            pass # Superuser sees all
        elif request.user.user_type == 'hotel_manager':
            # Example: Filter accounts created by the manager or staff,
            # or accounts linked to their hotel (needs a hotel FK on ChartOfAccounts).
            queryset = queryset.filter(Q(created_by=request.user) | Q(created_by__chield=request.user))
        elif request.user.user_type == 'hotel_staff':
             queryset = queryset.filter(created_by=request.user)
        else:
             queryset = queryset.none()
        # --- End Permission logic ---
        queryset = queryset.select_related('account_parent') # Optimization
        return queryset

    def save_model(self, request, obj, form, change):
        # Set timestamps and user tracking
        if not obj.pk:
            obj.created_by = request.user
        obj.updated_by = request.user
        # The original logic for timestamps seemed redundant with BaseModel, removed.
        super().save_model(request, obj, form, change)

    def changelist_view(self, request, extra_context=None):
        # Add the report URL to the context for the template button
        extra_context = extra_context or {}
        extra_context['chart_of_accounts_report_url'] = reverse('accounts:chart-of-accounts-report')
        return super().changelist_view(request, extra_context=extra_context)

# --- Registration with Custom Admin Site ---
admin_site.register(JournalEntry, JournalEntryAdmin)
admin_site.register(ChartOfAccounts, ChartOfAccountsAdmin)