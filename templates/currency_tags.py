from django import template

register = template.Library()

DEFAULT_CURRENCY_SYMBOL = "$"  

@register.filter
def to_default_currency(value):
    try:
        value = float(value)
        return f"{value:.2f} {DEFAULT_CURRENCY_SYMBOL}"
    except (ValueError, TypeError):
        return f"0.00 {DEFAULT_CURRENCY_SYMBOL}"
