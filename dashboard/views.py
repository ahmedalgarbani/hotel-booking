from django.shortcuts import render

def dashpord(request):
    user = request.user
    

    return render(request, 'dashboard/index.html',{'user':user})

# Create your views here.
