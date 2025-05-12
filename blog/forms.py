from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Post, Comment, Category, Tag

class PostAdminForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = '__all__'
        
    def clean(self):
        cleaned_data = super().clean()
        image = cleaned_data.get('image')
        
        # Verificar si es una creación nueva (no hay instancia) o si la instancia no tiene imagen
        if not self.instance.pk or (self.instance.pk and not self.instance.image):
            if not image:
                raise forms.ValidationError({
                    'image': _('الصورة مطلوبة. يرجى تحميل صورة للمقال.')
                })
                
        return cleaned_data
