from datetime import datetime
from django.utils.timezone import now

from accounts.models import ChartOfAccounts, JournalEntry

def create_journal_entry(**kwargs):
    """
    Dynamically creates a JournalEntry record with provided parameters.
    
    :param kwargs: Dictionary containing JournalEntry field values.
    :return: Created JournalEntry instance.
    """
    required_fields = {
        "journal_entry_number",
        "journal_entry_account",
        "journal_entry_in_amount",
        "journal_entry_out_amount",
    }

    missing_fields = required_fields - kwargs.keys()
    if missing_fields:
        raise ValueError(f"Missing required fields: {', '.join(missing_fields)}")

    journal_entry = JournalEntry.objects.create(
        journal_entry_number=kwargs["journal_entry_number"],
        journal_entry_date=datetime.now,
        journal_entry_description=kwargs.get("journal_entry_description",""),
        journal_entry_account=kwargs["journal_entry_account"],
        journal_entry_in_amount=kwargs["journal_entry_in_amount"],
        journal_entry_out_amount=kwargs["journal_entry_out_amount"],
        journal_entry_currency=kwargs.get("journal_entry_currency","RY"),
        journal_entry_exchange_rate=kwargs.get("journal_entry_exchange_rate",1),
        journal_entry_tax=kwargs.get("journal_entry_tax",0),
        journal_entry_notes=kwargs.get("journal_entry_notes", ""),
    )

    return journal_entry
"""
from myapp.models import JournalEntry, ChartOfAccounts
from datetime import date
from decimal import Decimal

account = ChartOfAccounts.objects.get(id=1)  # Get a valid account

journal_entry = create_journal_entry(
    journal_entry_number="JE-1001",
    journal_entry_date=date.today(),
    journal_entry_description="Sales Transaction",
    journal_entry_account=account,
    journal_entry_in_amount=Decimal("1000.00"),
    journal_entry_out_amount=Decimal("0.00"),
    journal_entry_currency="USD",
    journal_entry_exchange_rate=Decimal("1.00"),
    journal_entry_tax=Decimal("50.00"),
    journal_entry_notes="First entry",
)

print(f"Journal Entry Created: {journal_entry}")
"""
    # usage 




def create_chart_of_account(**kwargs):
    """
    Dynamically creates a ChartOfAccounts record with provided parameters.
    
    :param kwargs: Dictionary containing ChartOfAccounts field values.
    :return: Created ChartOfAccounts instance.
    """
    required_fields = {
        "account_number",
        "account_name",
        "account_type",
    }

    missing_fields = required_fields - kwargs.keys()
    if missing_fields:
        raise ValueError(f"Missing required fields: {', '.join(missing_fields)}")

    chart_account = ChartOfAccounts.objects.create(
        account_number=kwargs["account_number"],
        account_name=kwargs["account_name"],
        account_type=kwargs["account_type"],
        account_balance=kwargs["account_balance"],
        account_parent=kwargs.get("account_parent", None),
        account_description=kwargs.get("account_description", ""),
        account_status=kwargs.get("account_status", True),
        account_amount=kwargs.get("account_amount", None),
    )

    return chart_account
    """
    from myapp.models import ChartOfAccounts
from decimal import Decimal

chart_account = create_chart_of_account(
    account_number="ACC-2001",
    account_name="Cash",
    account_type="Asset",
    account_balance=Decimal("5000.00"),
    account_description="Main cash account",
    account_status=True,
    account_amount=Decimal("1000.00"),
)

print(f"Chart of Account Created: {chart_account}")

    """
    # usage 
