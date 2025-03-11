from django.contrib import messages
from django.shortcuts import render, get_object_or_404, redirect

from HotelManagement.models import Hotel
from rooms.forms import ReviewForm
from rooms.models import RoomType
from .models import HotelReview, RoomReview
from .forms import HotelReviewForm, RoomReviewForm
from django.contrib.auth.decorators import login_required

from django.shortcuts import get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from .models import Hotel, HotelReview
from .forms import HotelReviewForm

# Hotel Reviews

def hotel_review_list(request):
    reviews = HotelReview.objects.all()
    return render(request, 'reviews/hotel_review_list.html', {'reviews': reviews})

def hotel_review_detail(request, review_id):
    review = get_object_or_404(HotelReview, id=review_id)
    return render(request, 'reviews/hotel_review_detail.html', {'review': review})

@login_required(login_url='/users/login')
def hotel_review_create(request):
    if request.method == 'POST':
        hotel = get_object_or_404(Hotel, id=request.POST.get('hotel_id'))
        if HotelReview.objects.filter(hotel=hotel, user=request.user).exists():
            messages.error(request, "You have already reviewed this hotel.")
            return redirect('home:hotel_detail', slug=hotel.slug)
        
        HotelReview.objects.create(
            hotel=hotel,
            user=request.user,
            rating_cleanliness=request.POST.get('rating_cleanliness'),
            rating_value_for_money=request.POST.get('rating_value_for_money'),
            rating_location=request.POST.get('rating_location'),
            rating_service=request.POST.get('rating_service'),
            review=request.POST.get('review'),
        )
        
        messages.success(request, "Your review has been submitted successfully.")
        return redirect('home:hotel_detail', slug=hotel.slug)
    
    else:
        return redirect('home:index')

@login_required(login_url='/users/login')
def hotel_review_update(request, review_id):
    review = get_object_or_404(HotelReview, id=review_id)
    if request.method == 'POST':
        form = HotelReviewForm(request.POST, instance=review)
        if form.is_valid():
            form.save()
            return redirect('hotel_review_list')
    else:
        form = HotelReviewForm(instance=review)
    return render(request, 'reviews/hotel_review_form.html', {'form': form})

@login_required(login_url='/users/login')
def hotel_review_delete(request, review_id):
    review = get_object_or_404(HotelReview, id=review_id)
    if request.method == 'POST':
        review.delete()
        return redirect('hotel_review_list')
    return render(request, 'reviews/hotel_review_confirm_delete.html', {'review': review})


# Room Reviews

def room_review_list(request):
    reviews = RoomReview.objects.all()
    return render(request, 'reviews/room_review_list.html', {'reviews': reviews})

def room_review_detail(request, review_id):
    review = get_object_or_404(RoomReview, id=review_id)
    return render(request, 'reviews/room_review_detail.html', {'review': review})

@login_required(login_url='/users/login')
def room_review_create(request,room_id):
    room = get_object_or_404(RoomType,id = room_id)
    if request.method == 'POST':
        room = get_object_or_404(RoomType,id = request.POST.get('room_type'))
        form = ReviewForm(request.POST)
        if form.is_valid():
            existing_review = RoomReview.objects.filter(
                user=request.user,
                room_type=room,
                hotel=room.hotel
            ).first()
            if existing_review:
                messages.error(request, "لقد قمت بالفعل بتقييم هذه الغرفة من قبل.") 
            else:
                review = form.save(commit=False)
                review.room_type = room
                review.hotel = room.hotel
                review.status = True
                review.user = request.user
                review.save()
                messages.success(request, "تمت إضافة مراجعتك بنجاح.") 
                return redirect('rooms:room_detail', room_id=room.id)
        else:
            messages.error(request, "يرجى تصحيح الأخطاء في النموذج.") 
    else:
        form = ReviewForm()
    
    return redirect('rooms:room_detail',room_id=room.id)

@login_required(login_url='/users/login')
def room_review_update(request, review_id):
    review = get_object_or_404(RoomReview, id=review_id)
    if request.method == 'POST':
        form = RoomReviewForm(request.POST, instance=review)
        if form.is_valid():
            form.save()
            return redirect('room_review_list')
    else:
        form = RoomReviewForm(instance=review)
    return render(request, 'reviews/room_review_form.html', {'form': form})

@login_required(login_url='/users/login')
def room_review_delete(request, review_id):
    review = get_object_or_404(RoomReview, id=review_id)
    if request.method == 'POST':
        review.delete()
        return redirect('room_review_list')
    return render(request, 'reviews/room_review_confirm_delete.html', {'review': review})
