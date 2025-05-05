# users/utils.py
import requests
from django.conf import settings
import logging

logger = logging.getLogger(__name__)

def send_sms_via_sadeem(phone_number: str, message: str) -> bool:
    api_url = "https://app.sadeemsolution.com/api/send/sms"
    secret = settings.SADEEM_API_SECRET
    device = settings.SADEEM_DEVICE_ID
    sim = settings.SADEEM_SIM

    if not all([secret, device, sim]):
        logger.error("Sadeem SMS API credentials missing.")
        return False

    payload = {
        'secret': secret, 'mode': 'devices', 'phone': phone_number,
        'message': message, 'sim': sim, 'device': device, 'priority': '1'
    }

    try:
        response = requests.post(api_url, data=payload)
        response.raise_for_status()
        response_data = response.json()
        logger.info(f"Sadeem API Response: {response_data}")

        # --- هام: عدّل هذا الشرط حسب استجابة Sadeem الفعلية ---
        if response_data.get('status') == 'success' or response.status_code == 200:
             logger.info(f"Successfully sent SMS to {phone_number}")
             return True
        else:
             logger.error(f"Failed to send SMS to {phone_number}. API Response: {response_data}")
             return False
        # --- نهاية التعديل ---

    except requests.exceptions.RequestException as e:
        logger.error(f"Error sending SMS via Sadeem to {phone_number}: {e}")
        return False
    except Exception as e:
        logger.error(f"Unexpected error during SMS sending: {e}")
        return False