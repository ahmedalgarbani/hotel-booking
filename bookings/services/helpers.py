
from datetime import datetime, timedelta
from django.db import transaction



def to_date(value):
    """تحويل string إلى date إذا لزم الأمر"""
    if isinstance(value, str):
        try:
            return datetime.fromisoformat(value).date()
        except ValueError:
            return datetime.strptime(value, "%Y-%m-%d").date()
    elif isinstance(value, datetime):
        return value.date()
    elif hasattr(value, 'date'):
        return value.date()
    return value  # نفترض أنه بالفعل date