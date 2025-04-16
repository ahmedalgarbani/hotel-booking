# accounts/services/reports.py

import logging # Import logging
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.template.response import TemplateResponse
from django.urls import reverse
from django.db.models import Q, Sum, Count
from django.shortcuts import get_object_or_404
from datetime import date, timedelta
from reportlab.lib.pagesizes import landscape, A4

from django.contrib.auth import get_user_model
from accounts.models import JournalEntry, ChartOfAccounts
from bookings.admin_classes.mixins import generate_pdf_report # Reuse the PDF helper

logger = logging.getLogger(__name__) # Setup logger
User = get_user_model()

# --- Journal Entry Report ---

def get_filtered_journal_entries(request):
    """
    Get filtered journal entry data for the report.
    (Keeping this function as it was previously, assuming it works correctly)
    """
    today = date.today()
    default_start_date = today - timedelta(days=30)
    start_date_str = request.GET.get('start_date', default_start_date.strftime('%Y-%m-%d'))
    end_date_str = request.GET.get('end_date', today.strftime('%Y-%m-%d'))
    account_id = request.GET.get('account_id')
    currency_filter = request.GET.get('currency')

    try:
        start_date = date.fromisoformat(start_date_str)
        end_date = date.fromisoformat(end_date_str) + timedelta(days=1)
    except ValueError:
        start_date = default_start_date
        end_date = today + timedelta(days=1)
        start_date_str = start_date.strftime('%Y-%m-%d')
        end_date_str = (end_date - timedelta(days=1)).strftime('%Y-%m-%d')

    # --- Permission Filtering (Adjust as needed for Journal Entries) ---
    queryset = JournalEntry.objects.all()
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                 queryset = queryset.filter(Q(created_by=request.user) | Q(created_by__chield=request.user))
            elif request.user.user_type == 'hotel_staff':
                 queryset = queryset.filter(created_by=request.user)
        else:
             queryset = queryset.none()

    # --- Apply Request Filters ---
    filters = Q(journal_entry_date__gte=start_date) & Q(journal_entry_date__lt=end_date)

    if account_id and account_id.isdigit():
        filters &= Q(journal_entry_account_id=int(account_id))
        selected_account_id_int = int(account_id) # Keep track for context
    else:
        account_id = '' # Reset for context if invalid
        selected_account_id_int = None

    if currency_filter:
        filters &= Q(journal_entry_currency__iexact=currency_filter)
    else:
        currency_filter = ''

    filtered_entries_qs = queryset.filter(filters)\
        .select_related('journal_entry_account', 'created_by')\
        .order_by('journal_entry_date', 'journal_entry_number')

    # Calculate totals
    totals = filtered_entries_qs.aggregate(
        total_debit=Sum('journal_entry_out_amount'),
        total_credit=Sum('journal_entry_in_amount')
    )
    total_debit = totals.get('total_debit') or 0.00
    total_credit = totals.get('total_credit') or 0.00
    net_balance = total_credit - total_debit

    return (
        filtered_entries_qs, start_date_str, end_date_str,
        account_id, # Pass back the potentially reset string version for the select box
        currency_filter,
        total_debit, total_credit, net_balance
    )


def journal_entries_report_view(request):
    """
    Display the journal entries report view.
    (Keeping this function as it was previously)
    """
    (
        filtered_entries, start_date_str, end_date_str,
        selected_account_id_str, selected_currency, # Use string version for template selection
        total_debit, total_credit, net_balance
    ) = get_filtered_journal_entries(request)

    # Fetch accounts and currencies for dropdowns (apply permissions if needed)
    accounts_qs = ChartOfAccounts.objects.all().order_by('account_number')
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type') and request.user.user_type in ['hotel_manager', 'hotel_staff']:
             # Apply appropriate permission filter if managers/staff should only see certain accounts
             manager_filter = Q(created_by=request.user)
             if request.user.user_type == 'hotel_staff':
                 manager_filter = Q(created_by=request.user.chield)
             accounts_qs = accounts_qs.filter(manager_filter)
        else:
             accounts_qs = ChartOfAccounts.objects.none()

    currencies = JournalEntry.objects.order_by('journal_entry_currency').values_list('journal_entry_currency', flat=True).distinct()

    from django.contrib import admin
    base_context = {
        'site_title': admin.site.site_title, 'site_header': admin.site.site_header, 'site_url': admin.site.site_url,
        'has_permission': True, 'available_apps': [], 'is_popup': False, 'is_nav_sidebar_enabled': True, 'app_list': []
    }
    context = {
        **base_context,
        'title': _('تقرير قيود اليومية'),
        'entries': filtered_entries,
        'start_date': start_date_str, 'end_date': end_date_str,
        'accounts': accounts_qs, 'selected_account_id': selected_account_id_str, # Use string version here
        'currencies': currencies, 'selected_currency': selected_currency,
        'total_debit': total_debit, 'total_credit': total_credit, 'net_balance': net_balance,
        'opts': JournalEntry._meta, 'has_view_permission': True,
        'pdf_export_url': reverse('accounts:journal-entries-report-export-pdf')
    }
    return TemplateResponse(request, 'admin/accounts/journal_entries_report.html', context)

def export_journal_entries_pdf(request):
    """
    Export the journal entries report as a PDF.
    (Keeping this function as it was previously)
    """
    (
        filtered_entries, start_date_str, end_date_str,
        selected_account_id, selected_currency,
        total_debit, total_credit, net_balance
    ) = get_filtered_journal_entries(request)

    headers = [
        _("رقم القيد"), _("التاريخ"), _("الحساب"), _("الوصف"),
        _("مدين"), _("دائن"), _("العملة"), _("المستخدم")
    ]
    data = [[
        e.journal_entry_number,
        e.journal_entry_date.strftime('%Y-%m-%d') if e.journal_entry_date else '',
        f"{e.journal_entry_account.account_number} - {e.journal_entry_account.account_name}" if e.journal_entry_account else _("غير محدد"),
        e.journal_entry_description,
        f"{e.journal_entry_out_amount:.2f}",
        f"{e.journal_entry_in_amount:.2f}",
        e.journal_entry_currency,
        e.created_by.username if e.created_by else _("غير محدد")
    ] for e in filtered_entries]
    report_title = _('تقرير قيود اليومية') + f" ({start_date_str} - {end_date_str})"
    if selected_account_id:
         try:
             account = ChartOfAccounts.objects.get(id=int(selected_account_id))
             report_title += f" - {_('الحساب')}: {account.account_name}"
         except (ChartOfAccounts.DoesNotExist, ValueError): pass
    if selected_currency: report_title += f" - {_('العملة')}: {selected_currency}"
    summary = f"\n{_('إجمالي المدين')}: {total_debit:.2f} | {_('إجمالي الدائن')}: {total_credit:.2f} | {_('صافي الرصيد')}: {net_balance:.2f}"
    report_title += summary
    available_width = landscape(A4)[0] - 60
    col_widths = [
        available_width * 0.10, available_width * 0.10, available_width * 0.20, available_width * 0.25,
        available_width * 0.10, available_width * 0.10, available_width * 0.05, available_width * 0.10
    ]
    return generate_pdf_report(report_title, headers, data, col_widths=col_widths)


# --- Chart of Accounts Report (REVISED) ---

def get_filtered_chart_of_accounts(request):
    """
    Get filtered chart of accounts data, applying request filters reliably.
    Permissions filtering for dropdowns is handled separately in the view.
    """
    account_type_filter = request.GET.get('account_type', '').strip()
    parent_id_filter = request.GET.get('parent_id', '').strip()
    status_filter = request.GET.get('status', '').strip() # 'True', 'False', or ''

    logger.debug(f"Raw filters received: Type='{account_type_filter}', Parent='{parent_id_filter}', Status='{status_filter}'")

    # Base queryset for the report results - Apply permissions here
    queryset = ChartOfAccounts.objects.select_related('account_parent', 'created_by').order_by('account_number')
    # Apply permission filtering for the main result queryset
    if hasattr(request, 'user') and not request.user.is_superuser:
        if hasattr(request.user, 'user_type'):
            if request.user.user_type == 'hotel_manager':
                 # Modify this based on how accounts relate to managers/hotels
                 queryset = queryset.filter(Q(created_by=request.user) | Q(created_by__chield=request.user)) # Example
            elif request.user.user_type == 'hotel_staff':
                 queryset = queryset.filter(created_by=request.user) # Example
            else: # Other non-superuser types see nothing
                 queryset = queryset.none()
        else: # Authenticated users without a type see nothing
             queryset = queryset.none()

    # --- Apply Request Filters to the permission-filtered queryset ---
    filters = Q() # Start with an empty Q object

    if account_type_filter:
        filters &= Q(account_type__iexact=account_type_filter)

    if parent_id_filter and parent_id_filter.isdigit():
        filters &= Q(account_parent_id=int(parent_id_filter))
        selected_parent_id_int = int(parent_id_filter) # Keep track for context
    else:
        parent_id_filter = '' # Reset for context if invalid
        selected_parent_id_int = None

    if status_filter in ['True', 'False']:
        filters &= Q(account_status=(status_filter == 'True'))
    else:
        status_filter = '' # Reset for context if invalid

    # Apply the combined filters
    if filters:
        queryset = queryset.filter(filters)

    logger.debug(f"Final filtered queryset count: {queryset.count()}")

    # --- Calculate Counts (Based on permission-filtered accounts, *before* request filters) ---
    all_accounts_qs = ChartOfAccounts.objects.all() # Start with all
    # Apply permission filter for counts
    if hasattr(request, 'user') and not request.user.is_superuser:
         if hasattr(request.user, 'user_type'):
             if request.user.user_type == 'hotel_manager':
                  all_accounts_qs = all_accounts_qs.filter(Q(created_by=request.user) | Q(created_by__chield=request.user))
             elif request.user.user_type == 'hotel_staff':
                  all_accounts_qs = all_accounts_qs.filter(created_by=request.user)
             else:
                  all_accounts_qs = all_accounts_qs.none()
         else:
              all_accounts_qs = all_accounts_qs.none()

    type_counts = all_accounts_qs.values('account_type').annotate(count=Count('id')).order_by('account_type')
    logger.debug(f"Type counts: {list(type_counts)}")

    return (
        queryset, # The final filtered list of accounts for display
        account_type_filter, # Selected type for the dropdown
        parent_id_filter,    # Selected parent ID (string) for the dropdown
        status_filter,       # Selected status ('True'/'False'/'') for the dropdown
        list(type_counts)    # Counts based on user permissions
    )

def chart_of_accounts_report_view(request):
    """
    Display the chart of accounts report view.
    """
    (
        filtered_accounts, selected_type, selected_parent_id_str,
        selected_status, type_counts
    ) = get_filtered_chart_of_accounts(request)

    # --- Get Filter Options (Apply permissions here if needed) ---
    # Fetch all possible types/parents that the *current user* is allowed to see
    # This ensures dropdowns only show relevant options
    visible_accounts_qs = ChartOfAccounts.objects.all() # Start with all
    parent_filter_qs = ChartOfAccounts.objects.filter(account_parent__isnull=True) # Start with top-level

    if hasattr(request, 'user') and not request.user.is_superuser:
         if hasattr(request.user, 'user_type'):
             if request.user.user_type == 'hotel_manager':
                  manager_filter = Q(created_by=request.user) | Q(created_by__chield=request.user) # Example
                  visible_accounts_qs = visible_accounts_qs.filter(manager_filter)
                  parent_filter_qs = parent_filter_qs.filter(manager_filter)
             elif request.user.user_type == 'hotel_staff':
                  staff_filter = Q(created_by=request.user) # Example
                  visible_accounts_qs = visible_accounts_qs.filter(staff_filter)
                  parent_filter_qs = parent_filter_qs.filter(staff_filter)
             else:
                  visible_accounts_qs = visible_accounts_qs.none()
                  parent_filter_qs = parent_filter_qs.none()
         else:
              visible_accounts_qs = visible_accounts_qs.none()
              parent_filter_qs = parent_filter_qs.none()

    account_types = visible_accounts_qs.order_by('account_type').values_list('account_type', flat=True).distinct()
    parent_accounts = parent_filter_qs.order_by('account_name') # Filtered parent accounts

    from django.contrib import admin
    base_context = {
        'site_title': admin.site.site_title, 'site_header': admin.site.site_header, 'site_url': admin.site.site_url,
        'has_permission': True, 'available_apps': [], 'is_popup': False, 'is_nav_sidebar_enabled': True, 'app_list': []
    }
    context = {
        **base_context,
        'title': _('تقرير دليل الحسابات'),
        'accounts': filtered_accounts,
        'account_types': account_types,
        'selected_type': selected_type,
        'parent_accounts': parent_accounts,
        'selected_parent_id': selected_parent_id_str, # Use string version for template comparison
        'status_choices': [('', _('الكل')), ('True', _('نشط')), ('False', _('غير نشط'))],
        'selected_status': selected_status,
        'type_counts': type_counts,
        'opts': ChartOfAccounts._meta,
        'has_view_permission': True,
        'pdf_export_url': reverse('accounts:chart-of-accounts-report-export-pdf')
    }

    return TemplateResponse(request, 'admin/accounts/chart_of_accounts_report.html', context)

def export_chart_of_accounts_pdf(request):
    """
    Export the chart of accounts report as a PDF.
    Uses the same filtering logic as the view.
    """
    (
        filtered_accounts, selected_type, selected_parent_id,
        selected_status, type_counts
    ) = get_filtered_chart_of_accounts(request) # Reuse the same filtering logic

    headers = [
        _("رقم الحساب"), _("اسم الحساب"), _("النوع"), _("الحساب الرئيسي"),
        _("الرصيد"), _("الحالة")
    ]

    data = [[
        acc.account_number,
        acc.account_name,
        acc.account_type,
        acc.account_parent.account_name if acc.account_parent else '-',
        f"{acc.account_balance:.2f}",
        _("نشط") if acc.account_status else _("غير نشط")
    ] for acc in filtered_accounts]

    report_title = _('تقرير دليل الحسابات')

    # Add Filter Info
    if selected_type: report_title += f" - {_('النوع')}: {selected_type}"
    if selected_parent_id:
        try:
            parent = ChartOfAccounts.objects.get(id=int(selected_parent_id))
            report_title += f" - {_('الرئيسي')}: {parent.account_name}"
        except (ChartOfAccounts.DoesNotExist, ValueError): pass
    if selected_status: report_title += f" - {_('الحالة')}: {_('نشط') if selected_status == 'True' else _('غير نشط')}"

    # Add Summary
    summary = "\n" + _('ملخص الأنواع') + ": "
    summary += " | ".join([f"{item['account_type']}: {item['count']}" for item in type_counts])
    report_title += summary

    # Define column widths
    available_width = landscape(A4)[0] - 60
    col_widths = [
        available_width * 0.15, available_width * 0.25, available_width * 0.15, available_width * 0.20,
        available_width * 0.15, available_width * 0.10
    ]

    return generate_pdf_report(report_title, headers, data, col_widths=col_widths)