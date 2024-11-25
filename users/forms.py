from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.forms import UserCreationForm
from .models import CustomUser

class CustomUser_CreationForm(UserCreationForm):
    user_type = forms.ChoiceField(choices=CustomUser.USER_TYPE_CHOICES)
    phone = forms.CharField(max_length=20, required=False)

    class Meta:
        model = CustomUser

        fields = ('username', 'email', 'password1', 'password2', 'user_type', 'phone')





class LoginForm(AuthenticationForm):
    pass