from django import forms
from django.utils.translation import gettext_lazy as _
from users.models import CustomUser

class AdminNotificationForm(forms.Form):
    message = forms.CharField(widget=forms.Textarea, label=_("Message"))
    RECIPIENT_CHOICES = (
        ('all', _("All Users")),
        ('customers', _("All Customers")),
        ('hotel_managers', _("All Hotel Managers")),
        ('single', _("Single User")),
    )
    recipient_type = forms.ChoiceField(choices=RECIPIENT_CHOICES, label=_("Recipient Type"))
    recipient = forms.ModelChoiceField(
        queryset=CustomUser.objects.all(),
        required=False,
        label=_("Recipient (if single user)")
    )
