from django.shortcuts import render

# Create your views here.
def rooms_types(request):
     
     return render(request, 'room/rooms_types.html')


def rooms_availability(request):
     
     return render(request, 'room/rooms_availability.html')


def rooms_categories(request):
     
     return render(request, 'room/rooms_categories.html')


def rooms_prices(request):
     
     return render(request, 'room/rooms_prices.html')