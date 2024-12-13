from rest_framework.routers import DefaultRouter
from .views import HotelsViewSet

router = DefaultRouter()
router.register(r'hotels', HotelsViewSet, basename='hotel')

urlpatterns = router.urls
