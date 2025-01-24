from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Post, Category, Comment
from django.core.paginator import Paginator

# Create your views here.

def post_list(request):
    posts = Post.objects.filter(is_published=True)
    categories = Category.objects.all()
    
    # Filter by category
    category_id = request.GET.get('category')
    if category_id:
        posts = posts.filter(category_id=category_id)
    
    # Pagination
    paginator = Paginator(posts, 6)  # Show 6 posts per page
    page = request.GET.get('page')
    posts = paginator.get_page(page)
    
    return render(request, 'frontend/home/pages/blog-sidebar.html', {
        'posts': posts,
        'categories': categories
    })

def post_detail(request, slug):
    post = get_object_or_404(Post, slug=slug, is_published=True)
    comments = post.comments.filter(is_approved=True)
    categories = Category.objects.all()
    
    # Increment view count
    post.views += 1
    post.save()
    
    if request.method == 'POST' and request.user.is_authenticated:
        content = request.POST.get('content')
        if content:
            Comment.objects.create(
                post=post,
                author=request.user,
                content=content
            )
            messages.success(request, 'تم إضافة تعليقك بنجاح')
            return redirect('blog:post_detail', slug=post.slug)
    
    return render(request, 'frontend/home/pages/blog-single.html', {
        'post': post,
        'comments': comments,
        'categories': categories
    })

@login_required
def create_post(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        content = request.POST.get('content')
        category_id = request.POST.get('category')
        image = request.FILES.get('image')
        
        if title and content and category_id:
            post = Post.objects.create(
                title=title,
                content=content,
                author=request.user,
                category_id=category_id,
                image=image
            )
            messages.success(request, 'تم إنشاء المقال بنجاح')
            return redirect('blog:post_detail', slug=post.slug)
        else:
            messages.error(request, 'الرجاء ملء جميع الحقول المطلوبة')
    
    categories = Category.objects.all()
    return render(request, 'blog/create_post.html', {
        'categories': categories
    })
