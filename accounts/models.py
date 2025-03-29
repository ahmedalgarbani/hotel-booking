from django.db import models

# Create your models here.

class ChartOfAccounts(models.Model):
    account_number = models.CharField(max_length=100)
    account_name = models.CharField(max_length=100)
    account_type = models.CharField(max_length=100)
    account_balance = models.DecimalField(max_digits=10, decimal_places=2)
    account_parent = models.ForeignKey('self', on_delete=models.CASCADE, null=True, blank=True)
    account_description = models.TextField()
    account_status = models.BooleanField(max_length=100,default=True)
    account_amount = models.DecimalField(max_digits=10, decimal_places=2)
    account_created_at = models.DateTimeField(auto_now_add=True)
    account_updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.account_name




class JournalEntry(models.Model):
    journal_entry_number = models.CharField(max_length=100)
    journal_entry_date = models.DateField()
    journal_entry_description = models.TextField()
    journal_entry_account = models.ForeignKey(ChartOfAccounts, on_delete=models.CASCADE)
    journal_entry_in_amount = models.DecimalField(max_digits=10, decimal_places=2)
    journal_entry_out_amount = models.DecimalField(max_digits=10, decimal_places=2)
    journal_entry_created_at = models.DateTimeField(auto_now_add=True)
    journal_entry_updated_at = models.DateTimeField(auto_now=True)
    journal_entry_notes = models.TextField()
    journal_entry_currency = models.CharField(max_length=100)
    journal_entry_exchange_rate = models.DecimalField(max_digits=10, decimal_places=2)
    journal_entry_tax = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return self.journal_entry_number







