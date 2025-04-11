
from django.urls import path
from .views import *

app_name = 'accounts'

urlpatterns = [
    # path('', views.chart_of_accounts_view, name='chart_of_accounts_view'),
      path('accounts/', ChartOfAccountsView.as_view(), name='chart_of_accounts'),
    # path('api/accounts/', AccountAPIView.as_view(), name='account-api'),
    # path('api/accounts/<int:pk>/', AccountAPIView.as_view(), name='account-detail-api'),
]
