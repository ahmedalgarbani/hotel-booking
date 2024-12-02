from django.shortcuts import render
from .models import RoomType,RoomPrice,RoomStatus,Category,Availability,RoomImage

#----------------------صفحه الانواع----------------------#
def rooms_types(request):
     data_types=RoomType.objects.all()
     print(data_types)
     return render(request, 'admin/dashboard/room/rooms_types.html',{'roomType':data_types})





#----------------------صفحه التوافر----------------------#
def rooms_availability(request):
     
     return render(request, 'admin/dashboard/room/rooms_availability.html')





#----------------------صفحه الفئات----------------------#
def rooms_categories(request):
     
     return render(request, 'admin/dashboard/room/rooms_categories.html')





#----------------------صفحه الاسعار----------------------#
def rooms_prices(request):
     
     return render(request, 'admin/dashboard/room/rooms_prices.html')




#----------------------صفحه الحاله----------------------#
def rooms_status(request):
     
     return render(request, 'admin/dashboard/room/rooms_status.html')




#----------------------صفحه الصور----------------------#
def rooms_images(request):
     
     return render(request, 'admin/dashboard/room/rooms_images.html')