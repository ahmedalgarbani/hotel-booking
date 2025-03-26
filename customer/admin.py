from django.contrib import admin

# Register your models here.
from api.admin import admin_site
from customer.models import Favourites

admin_site.register(Favourites)