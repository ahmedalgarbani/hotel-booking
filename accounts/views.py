from django.shortcuts import render

from accounts.models import ChartOfAccounts

# Create your views here.

def tree(request):    
    accounts = ChartOfAccounts.objects.all()
    print(accounts)
    return render(request,"admin/HotelManagement/hotel/test.html" ,{'accounts': accounts})

