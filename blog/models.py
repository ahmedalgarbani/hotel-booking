from django.db import models
from django.utils import timezone
from django.utils.text import slugify
from users.models import CustomUser

# Create your models here.

class Category(models.Model):
    name = models.CharField(max_length=100, verbose_name="اسم التصنيف")
    description = models.TextField(blank=True, verbose_name="وصف التصنيف")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="تاريخ الإنشاء")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "تصنيف"
        verbose_name_plural = "التصنيفات"
        ordering = ['-created_at']

class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True, verbose_name="اسم الوسم")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="تاريخ الإنشاء")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "وسم"
        verbose_name_plural = "الوسوم"
        ordering = ['name']

class Post(models.Model):
    title = models.CharField(max_length=200, verbose_name="عنوان المقال")
    slug = models.SlugField(max_length=255, unique=True, null=True, blank=True, allow_unicode=True, verbose_name="الرابط")
    content = models.TextField(verbose_name="محتوى المقال")
    author = models.ForeignKey(CustomUser, on_delete=models.CASCADE, verbose_name="الكاتب")
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, verbose_name="التصنيف")
    tags = models.ManyToManyField(Tag, blank=True, related_name='posts', verbose_name="الوسوم")
    image = models.ImageField(upload_to='blog/images/', blank=True, null=True, verbose_name="صورة المقال")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="تاريخ الإنشاء")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="تاريخ التحديث")
    published_at = models.DateTimeField(default=timezone.now, verbose_name="تاريخ النشر")
    is_published = models.BooleanField(default=True, verbose_name="منشور")
    views = models.PositiveIntegerField(default=0, verbose_name="عدد المشاهدات")

    def save(self, *args, **kwargs):
        if not self.slug:
            base_slug = slugify(self.title, allow_unicode=True)
            unique_slug = base_slug
            num = 1
            while Post.objects.filter(slug=unique_slug).exists():
                unique_slug = f"{base_slug}-{num}"
                num += 1
            self.slug = unique_slug
        super().save(*args, **kwargs)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "مقال"
        verbose_name_plural = "المقالات"
        ordering = ['-published_at']

class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='comments', verbose_name="المقال")
    author = models.ForeignKey(CustomUser, on_delete=models.CASCADE, verbose_name="الكاتب")
    content = models.TextField(verbose_name="محتوى التعليق")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="تاريخ الإنشاء")
    is_approved = models.BooleanField(default=True, verbose_name="معتمد")

    def __str__(self):
        return f'تعليق من {self.author.username} على {self.post.title}'

    class Meta:
        verbose_name = "تعليق"
        verbose_name_plural = "التعليقات"
        ordering = ['-created_at']
