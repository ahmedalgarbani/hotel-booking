# accounts/urls.py
from django.urls import path
from .views import *
from .views import ChartOfAccountsView # Keep existing views if any
from .services.reports import ( # Import the new report views
    journal_entries_report_view,
    export_journal_entries_pdf,
    chart_of_accounts_report_view,
    export_chart_of_accounts_pdf,
)
from django.contrib.admin.views.decorators import staff_member_required # Import decorator

app_name = 'accounts'

urlpatterns = [
    # path('', views.chart_of_accounts_view, name='chart_of_accounts_view'),
      path('accounts/', ChartOfAccountsView.as_view(), name='chart_of_accounts'),

    # path('api/accounts/', AccountAPIView.as_view(), name='account-api'),
    # path('api/accounts/<int:pk>/', AccountAPIView.as_view(), name='account-detail-api'),

    # Journal Entry Report URLs
    path('reports/journal-entries/', staff_member_required(journal_entries_report_view), name='journal-entries-report'),
    path('reports/journal-entries/export-pdf/', staff_member_required(export_journal_entries_pdf), name='journal-entries-report-export-pdf'),

    # Chart of Accounts Report URLs
    path('reports/chart-of-accounts/', staff_member_required(chart_of_accounts_report_view), name='chart-of-accounts-report'),
    path('reports/chart-of-accounts/export-pdf/', staff_member_required(export_chart_of_accounts_pdf), name='chart-of-accounts-report-export-pdf'),
]