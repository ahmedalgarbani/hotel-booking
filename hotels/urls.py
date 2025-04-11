"""
URL configuration for hotels project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from api.admin import admin_site

urlpatterns = [
    path('i18n/', include('django.conf.urls.i18n')),
    path('admin/', admin_site.urls),
    path('users/', include('users.urls', namespace='users')),
    path('HotelManagement/', include('HotelManagement.urls', namespace='HotelManagement')),
    path('', include('home.urls'), name='home'),
    path('rooms/', include('rooms.urls')),
    path('bookings/', include('bookings.urls', namespace='bookings')),
    path('payments/', include('payments.urls')),
    path('reviews/', include('reviews.urls')),
    path('services/', include('services.urls', namespace='services')),
    path('blog/', include('blog.urls')),
    path('api/', include('api.urls', namespace='api')),
    path('accounts/', include('accounts.urls', namespace='accounts')),
    path('customer/', include('customer.urls')),

    path('notifications/', include('notifications.urls',namespace='notifications')),

    path('o/', include('oauth2_provider.urls', namespace='oauth2_provider')),
    path('auth/', include('social_django.urls', namespace='social')),

]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
