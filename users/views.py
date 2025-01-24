from django.shortcuts import render
from django.shortcuts import render, redirect
from django.urls import reverse
from .forms import CustomUser_CreationForm, HotelAccountRequestForm
from .models import CustomUser
from django.contrib.auth import authenticate, login,logout
from django.contrib import messages

from .models import ActivityLog

from django.shortcuts import get_object_or_404, redirect, render
from users.models import ActivityLog, HotelAccountRequest,CustomUser
from django.contrib import messages
from users.forms import CustomUser_CreationForm, HotelAccountRequestForm
from django.forms import inlineformset_factory
from .forms import HotelAccountRequestForm,HotelAccountRequestFormSet
from django.contrib.auth.models import Group
