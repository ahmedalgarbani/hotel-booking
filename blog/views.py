from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import Post, Category, Comment, Tag
from django.core.paginator import Paginator
from django.db.models import Count, Q
from django.db.models.functions import TruncMonth, ExtractYear

# Create your views here.

def post_list(request):
    posts = Post.objects.filter(is_published=True)
    categories = Category.objects.all()
    tags = Tag.objects.annotate(post_count=Count('posts')).order_by('-post_count')
    
    # Filter by category
    category_id = request.GET.get('category')
    if category_id:
        posts = posts.filter(category_id=category_id)
    
    # Filter by tag
    tag_id = request.GET.get('tag')
    if tag_id:
        posts = posts.filter(tags__id=tag_id)
        
    # Filter by archive (year and month)
    year = request.GET.get('year')
    month = request.GET.get('month')
    if year and month:
        posts = posts.filter(published_at__year=year, published_at__month=month)
    
    # Get tab type from request, default to 'popular'
    tab_type = request.GET.get('tab', 'popular')
    
    # Filter posts based on tab type
    if tab_type == 'recent':
        filtered_posts = Post.objects.filter(is_published=True).order_by('-updated_at')[:4]
    elif tab_type == 'new':
        filtered_posts = Post.objects.filter(is_published=True).order_by('-created_at')[:4]
    else:  # popular is default
        filtered_posts = Post.objects.filter(is_published=True).order_by('-views')[:4]
    
    # Get archive data
    archive_data = Post.objects.filter(is_published=True) \
        .annotate(year=ExtractYear('published_at')) \
        .annotate(month=TruncMonth('published_at')) \
        .values('year', 'month') \
        .annotate(count=Count('id')) \
        .order_by('-year', '-month')
    
    # Pagination
    paginator = Paginator(posts, 8)  # Show 8 posts per page
    page = request.GET.get('page')
    posts = paginator.get_page(page)
    
    return render(request, 'frontend/home/pages/blog-sidebar.html', {
        'posts': posts,
        'categories': categories,
        'archive_data': archive_data,
        'filtered_posts': filtered_posts,
        'current_tab': tab_type,
        'tags': tags,
        'selected_year': year,
        'selected_month': month
    })

def post_detail(request, slug):
    post = get_object_or_404(Post, slug=slug, is_published=True)
    all_comments = post.comments.filter(is_approved=True).order_by('-created_at')
    
    # Paginate comments - 3 per page
    paginator = Paginator(all_comments, 3)
    comment_page = request.GET.get('comment_page')
    comments = paginator.get_page(comment_page)
    
    # Get related posts based on category and tags, excluding the current post
    related_posts = Post.objects.filter(
        Q(category=post.category) | Q(tags__in=post.tags.all())
    ).exclude(id=post.id).distinct().order_by('-published_at')[:2]
    
    # Get tab type from request, default to 'popular'
    tab_type = request.GET.get('tab', 'popular')
    
    # Filter posts based on tab type
    if tab_type == 'recent':
        filtered_posts = Post.objects.filter(is_published=True).order_by('-updated_at')[:4]
    elif tab_type == 'new':
        filtered_posts = Post.objects.filter(is_published=True).order_by('-created_at')[:4]
    else:  # popular is default
        filtered_posts = Post.objects.filter(is_published=True).order_by('-views')[:4]
    
    # Get archive data
    archive_data = Post.objects.filter(is_published=True) \
        .annotate(year=ExtractYear('published_at')) \
        .annotate(month=TruncMonth('published_at')) \
        .values('year', 'month') \
        .annotate(count=Count('id')) \
        .order_by('-year', '-month')
    
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
    
    # Get year and month from request for archive filtering
    year = request.GET.get('year')
    month = request.GET.get('month')
    
    categories = Category.objects.all()
    tags = Tag.objects.annotate(post_count=Count('posts')).order_by('-post_count')
    
    return render(request, 'frontend/home/pages/blog-single.html', {
        'post': post,
        'comments': comments,
        'categories': categories,
        'archive_data': archive_data,
        'filtered_posts': filtered_posts,
        'related_posts': related_posts,
        'current_tab': tab_type,
        'tags': tags,
        'selected_year': year,
        'selected_month': month
    })

@login_required(login_url='/users/login')
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
