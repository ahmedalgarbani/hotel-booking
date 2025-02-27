from django.shortcuts import render, get_object_or_404, redirect

from HotelManagement.models import Hotel
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

@login_required
def hotel_review_create(request):
    if request.method == 'POST':
        hotel = get_object_or_404(Hotel, id=request.POST.get('hotel_id'))
        HotelReview.objects.create(
            hotel=hotel,
            user=request.user,
            rating_cleanliness=request.POST.get('rating_cleanliness'),
            rating_value_for_money=request.POST.get('rating_value_for_money'),
            rating_location=request.POST.get('rating_location'),
            rating_service=request.POST.get('rating_service'),
            review=request.POST.get('review'),
        )
        
        return redirect('home:hotel_detail', slug=hotel.slug)
    
    else:
        return redirect('home:index')

@login_required
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

@login_required
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

@login_required
def room_review_create(request):
    if request.method == 'POST':
        form = RoomReviewForm(request.POST)
        if form.is_valid():
            review = form.save(commit=False)
            review.user = request.user
            review.save()
            return redirect('room_review_list')
    else:
        form = RoomReviewForm()
    return render(request, 'reviews/room_review_form.html', {'form': form})

@login_required
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

@login_required
def room_review_delete(request, review_id):
    review = get_object_or_404(RoomReview, id=review_id)
    if request.method == 'POST':
        review.delete()
        return redirect('room_review_list')
    return render(request, 'reviews/room_review_confirm_delete.html', {'review': review})
