# accounts/views.py

import json # Import json
from django.shortcuts import render
from django.views import View
from django.http import JsonResponse
from .models import ChartOfAccounts

# --- Existing View (Keep if needed for other purposes) ---
def account_to_dict(account):
    """Helper function to convert account object to dictionary."""
    return {
        'id': account.id,
        'account_number': account.account_number,
        'account_name': account.account_name,
        'account_type': account.account_type,
        'children': [],
        'isExpanded': False # Example property for frontend tree view
    }

class ChartOfAccountsView(View):
    """
    This view seems designed for a specific frontend representation (like test.html).
    It's kept here but is separate from the admin reports.
    """
    def get(self, request):
        # Fetch all accounts (consider permission filtering if needed here too)
        accounts = ChartOfAccounts.objects.all()

        # Build hierarchical structure (this logic might be heavy for large charts)
        account_dict = {}
        root_accounts = []

        for account in accounts:
            account_dict[account.id] = account_to_dict(account)
            if not account.account_parent:
                root_accounts.append(account_dict[account.id])
            else:
                # Ensure parent exists in the dict before appending
                parent_dict = account_dict.get(account.account_parent.id)
                if parent_dict:
                    # Initialize 'children' if not present
                    if 'children' not in parent_dict:
                        parent_dict['children'] = []
                    parent_dict['children'].append(account_dict[account.id])
                # else: Handle orphaned accounts if necessary

        # Convert the Python list to a JSON string safely
        accounts_json_data = json.dumps(root_accounts, ensure_ascii=False) # Use ensure_ascii=False for Arabic

        return render(request, "admin/HotelManagement/hotel/test.html", {
            'accounts_json': accounts_json_data # Pass JSON string
        })

# --- Note ---
# The report views (journal_entries_report_view, chart_of_accounts_report_view,
# and their PDF export counterparts) are defined in accounts/services/reports.py
# and are called directly via the URLs defined in accounts/urls.py within the
# admin site's context. They don't need to be defined again here in views.py.