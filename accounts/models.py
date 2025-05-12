from django.db import models
from HotelManagement.models import BaseModel

class ChartOfAccounts(BaseModel):
    account_number = models.CharField(
        max_length=100,
        verbose_name="رقم الحساب"
    )
    account_name = models.CharField(
        max_length=100,
        verbose_name="اسم الحساب"
    )
    account_type = models.CharField(
        max_length=100,
        verbose_name="نوع الحساب"
    )
    account_balance = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name="رصيد الحساب"
    )
    account_parent = models.ForeignKey(
        'self',
        on_delete=models.CASCADE,
        null=True,
        blank=True,
        verbose_name="الحساب الأب"
    )
    account_description = models.TextField(
        verbose_name="وصف الحساب"
    )
    account_status = models.BooleanField(
        default=True,
        verbose_name="حالة الحساب"
    )
    account_amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        null=True,
        verbose_name="مبلغ الحساب"
    )

    def __str__(self):
        return self.account_name

    class Meta:
        verbose_name = "دليل الحسابات"
        verbose_name_plural = "دلائل الحسابات"

class JournalEntry(BaseModel):
    journal_entry_number = models.CharField(
        max_length=100,
        verbose_name="رقم القيد"
    )
    journal_entry_date = models.DateField(
        verbose_name="تاريخ القيد"
    )
    journal_entry_description = models.TextField(
        verbose_name="وصف القيد"
    )
    journal_entry_account = models.ForeignKey(
        ChartOfAccounts,
        on_delete=models.CASCADE,
        verbose_name="الحساب"
    )
    journal_entry_in_amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name="المبلغ الداخل"
    )
    journal_entry_out_amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name="المبلغ الخارج"
    )
    journal_entry_notes = models.TextField(
        verbose_name="ملاحظات القيد"
    )
    journal_entry_currency = models.CharField(
        max_length=100,
        verbose_name="العملة"
    )
    journal_entry_exchange_rate = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name="سعر الصرف"
    )
    journal_entry_tax = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name="الضريبة"
    )

    def __str__(self):
        return self.journal_entry_number

    class Meta:
        verbose_name = "قيد يومية"
        verbose_name_plural = "قيود اليومية"