from django.shortcuts import render, redirect
from .forms import HotelRequestForm
from django.urls import reverse
from django.conf import settings
import os

def add_hotel(request):
    if request.method == 'POST':
        form = HotelRequestForm(request.POST, request.FILES)
        if form.is_valid():
            hotel_request = form.save(commit=False)

            # Handle multiple images
            images = request.FILES.getlist('image')
            if images:
                hotel_name = hotel_request.official_name.replace(' ', '_')
                folder_path = os.path.join(settings.MEDIA_ROOT, 'hotel_requests', hotel_name)
                if not os.path.exists(folder_path):
                    os.makedirs(folder_path)

                image_paths = []
                for image in images:
                    file_path = os.path.join(folder_path, image.name)
                    with open(file_path, 'wb+') as destination:
                        for chunk in image.chunks():
                            destination.write(chunk)
                    image_paths.append(f'hotel_requests/{hotel_name}/{image.name}')

                hotel_request.image = image_paths[0] if image_paths else None  # Save path of the first image
            hotel_request.save()
            return redirect(reverse('HotelManagement:add_hotel'))
    else:
        form = HotelRequestForm()
    return render(request, 'frontend/home/pages/add-hotel.html', {'form': form})
