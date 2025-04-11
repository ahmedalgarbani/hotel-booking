from django.shortcuts import render

from accounts.models import ChartOfAccounts

from django.views import View
from django.http import JsonResponse

def account_to_dict(account):
    return {
        'id': account.id,
        'account_number': account.account_number,
        'account_name': account.account_name,
        'account_type': account.account_type,
        'children': [],
        'isExpanded': False
    }

class ChartOfAccountsView(View):
    def get(self, request):
        accounts = ChartOfAccounts.objects.all()
        
        account_dict = {}
        root_accounts = []
        
        for account in accounts:
            account_dict[account.id] = account_to_dict(account)
            if not account.account_parent:
                root_accounts.append(account_dict[account.id])
            else:
                parent = account_dict.get(account.account_parent.id)
                if parent:
                    parent['children'].append(account_dict[account.id])
        
        return render(request, "admin/HotelManagement/hotel/test.html", {
            'accounts_json': JsonResponse(root_accounts, safe=False)
        })
