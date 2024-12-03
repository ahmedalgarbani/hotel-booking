from django.shortcuts import render, get_object_or_404, redirect
from .models import Hotel, Location, Phone, Image, City
from .forms import HotelForm, LocationForm, PhoneForm, ImageForm, CityForm
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.http import HttpResponseForbidden


# -------------------- Hotel ----------------------------
def index(request):
    hotels = Hotel.objects.all()
    locations = Location.objects.all()
    context = {
        'hotels': hotels,
        'locations':locations
    }
    return render(request, 'admin/hotel-management/index.html', context)

def hotel_detail(request, hotel_slug):
    hotel = get_object_or_404(Hotel, slug=hotel_slug)
    return render(request, 'hotel_detail.html', {'hotel': hotel})




def hotel_create(request):
    if request.method == 'POST':
        form = HotelForm(request.POST)
        if form.is_valid():
            hotel = form.save(commit=False) 
            if request.user.is_authenticated:
                hotel.created_by = request.user 
            else:
                default_user = User.objects.get(id=1)
                hotel.created_by = default_user
            hotel.save()  
            messages.success(request, "تمت الاضافه بنجاح")
        else:
            messages.error(request, "حصلت مشكله الرجاء المحاوله لاحقاء")
    else:
        form = HotelForm()

    hotels = Hotel.objects.all()
    locations = Location.objects.all()

    context = {
        'hotels': hotels,
        'locations': locations,
    }
    return render(request, 'admin/hotel-management/index.html', context)



def hotel_update(request):
    if request.method == "POST":
        hotel_id = request.POST.get('hotel_id')
        hotel = get_object_or_404(Hotel, id=hotel_id)
        form = HotelForm(request.POST, instance=hotel)
        if form.is_valid():
            form.save()
            messages.success(request, "Post updated successfully.")  
            return redirect('/dashboard/hotel-management') 
        else:
            messages.error(request, "Failed to update the post. Check the form.")  
            print(form.errors)
    else:
        form = HotelForm()

    return render(request, 'admin/hotel-management/index.html', {'form': form})



def hotel_delete(request):
    if request.method == "POST":
        hotel_id = request.POST.get('hotel_id')
        if not hotel_id:
            messages.error(request, "Hotel ID is missing.")
            return redirect('/dashboard/hotel-management')
        try:
            hotel = get_object_or_404(Hotel, id=hotel_id)
            hotel.delete()
            messages.success(request, "Hotel deleted successfully.")
        except Exception as e:
            messages.error(request, f"Error deleting hotel: {e}")
    return redirect('/dashboard/hotel-management')



# -------------------- Location ----------------------------
def location_list(request):
    locations = Location.objects.all()
    return render(request, 'location_list.html', {'locations': locations})

def location_detail(request, location_slug):
    location = get_object_or_404(Location, slug=location_slug)
    return render(request, 'location_detail.html', {'location': location})

def location_create(request):
    if request.method == 'POST':
        form = LocationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('location_list')
    else:
        form = LocationForm()
    return render(request, 'location_form.html', {'form': form})

def location_update(request, location_slug):
    location = get_object_or_404(Location, slug=location_slug)
    if request.method == 'POST':
        form = LocationForm(request.POST, instance=location)
        if form.is_valid():
            form.save()
            return redirect('location_list')
    else:
        form = LocationForm(instance=location)
    return render(request, 'location_form.html', {'form': form})

def location_delete(request, location_slug):
    location = get_object_or_404(Location, slug=location_slug)
    if request.method == 'POST':
        location.delete()
        return redirect('location_list')
    return render(request, 'location_confirm_delete.html', {'location': location})


# -------------------- Phone ----------------------------
def phone_list(request):
    phones = Phone.objects.all()
    return render(request, 'phone_list.html', {'phones': phones})

def phone_detail(request, phone_slug):
    phone = get_object_or_404(Phone, slug=phone_slug)
    return render(request, 'phone_detail.html', {'phone': phone})

def phone_create(request):
    if request.method == 'POST':
        form = PhoneForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('phone_list')
    else:
        form = PhoneForm()
    return render(request, 'phone_form.html', {'form': form})

def phone_update(request, phone_slug):
    phone = get_object_or_404(Phone, slug=phone_slug)
    if request.method == 'POST':
        form = PhoneForm(request.POST, instance=phone)
        if form.is_valid():
            form.save()
            return redirect('phone_list')
    else:
        form = PhoneForm(instance=phone)
    return render(request, 'phone_form.html', {'form': form})

def phone_delete(request, phone_slug):
    phone = get_object_or_404(Phone, slug=phone_slug)
    if request.method == 'POST':
        phone.delete()
        return redirect('phone_list')
    return render(request, 'phone_confirm_delete.html', {'phone': phone})

# -------------------- image ----------------------------

def image_list(request, hotel_id):
    images = Image.objects.filter(hotel_id=hotel_id)
    return render(request, 'image_list.html', {'images': images, 'hotel_id': hotel_id})

def image_detail(request, hotel_id, image_slug):
    image = get_object_or_404(Image, slug=image_slug, hotel_id=hotel_id)
    return render(request, 'image_detail.html', {'image': image, 'hotel_id': hotel_id})

def image_create(request, hotel_id):
    if request.method == 'POST':
        form = ImageForm(request.POST, request.FILES) 
        if form.is_valid():
            image = form.save(commit=False)
            image.hotel_id_id = hotel_id
            image.save()
            return redirect('image_list', hotel_id=hotel_id)
    else:
        form = ImageForm()
    return render(request, 'image_form.html', {'form': form, 'hotel_id': hotel_id})

def image_update(request, hotel_id, image_slug):
    image = get_object_or_404(Image, slug=image_slug, hotel_id=hotel_id)
    if request.method == 'POST':
        form = ImageForm(request.POST, request.FILES, instance=image)  
        if form.is_valid():
            form.save()
            return redirect('image_list', hotel_id=hotel_id)
    else:
        form = ImageForm(instance=image)
    return render(request, 'image_form.html', {'form': form, 'hotel_id': hotel_id})

def image_delete(request, hotel_id, image_slug):
    image = get_object_or_404(Image, slug=image_slug, hotel_id=hotel_id)
    if request.method == 'POST':
        image.delete()
        return redirect('image_list', hotel_id=hotel_id)
    return render(request, 'image_confirm_delete.html', {'image': image, 'hotel_id': hotel_id})
# -------------------- City ----------------------------
def city_list(request):
    cities = City.objects.all()
    return render(request, 'city_list.html', {'cities': cities})

def city_detail(request, city_slug):
    city = get_object_or_404(City, slug=city_slug)
    return render(request, 'city_detail.html', {'city': city})

def city_create(request):
    if request.method == 'POST':
        form = CityForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('city_list')
    else:
        form = CityForm()
    return render(request, 'city_form.html', {'form': form})

def city_update(request, city_slug):
    city = get_object_or_404(City, slug=city_slug)
    if request.method == 'POST':
        form = CityForm(request.POST, instance=city)
        if form.is_valid():
            form.save()
            return redirect('city_list')
    else:
        form = CityForm(instance=city)
    return render(request, 'city_form.html', {'form': form})

def city_delete(request, city_slug):
    city = get_object_or_404(City, slug=city_slug)
    if request.method == 'POST':
        city.delete()
        return redirect('city_list')
    return render(request, 'city_confirm_delete.html', {'city': city})
