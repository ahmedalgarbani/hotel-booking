from django.contrib import admin
from .models import Category, Post, Comment, Tag

# Register your models here.
class AutoUserTrackMixin:
    
    def save_model(self, request, obj, form, change):
        if not obj.pk: 
            obj.created_by = request.user
        obj.updated_by = request.user
        super().save_model(request, obj, form, change)
class CategoryAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ('name', 'created_at')
    search_fields = ('name',)
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields
   

class PostAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ('title', 'author', 'category', 'published_at', 'is_published', 'views')
    list_filter = ('is_published', 'category', 'created_at')
    search_fields = ('title', 'content')
    date_hierarchy = 'published_at'
    raw_id_fields = ('author',)
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields

class CommentAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ('author', 'post', 'created_at', 'is_approved')
    list_filter = ('is_approved', 'created_at')
    search_fields = ('content', 'author__username', 'post__title')
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields

class TagAdmin(AutoUserTrackMixin,admin.ModelAdmin):
    list_display = ('name', 'created_at', 'post_count')
    search_fields = ('name',)
    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:  
            return ('created_at', 'updated_at', 'created_by', 'updated_by','deleted_at')
        return self.readonly_fields
    
    def post_count(self, obj):
        return obj.posts.count()
    post_count.short_description = 'عدد المقالات'


from api.admin import admin_site

# blog-------
admin_site.register(Post,PostAdmin)
admin_site.register(Category,CategoryAdmin)
admin_site.register(Tag,TagAdmin)
admin_site.register(Comment,CommentAdmin)