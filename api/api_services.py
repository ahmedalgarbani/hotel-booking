import json
import requests
from django.conf import settings

def call_gemini_api(prompt, text=None):
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={settings.GEMINI_API_KEY}"
    
    headers = {
        "Content-Type": "application/json",
    }
    
    if text:
        # Hotel matching prompt
        best_hotels_prompt = f"""
You are an assistant that selects hotels based on user preferences.

- Hotel list: {text}
- User description: {prompt} (may be in Arabic or English)

Instructions:
- Analyze the hotel list.
- Match hotels based on the user description.
- Return ONLY raw JSON, no markdown or code blocks.
- DO NOT wrap the JSON in ```json``` or any markdown.
- DO NOT add any explanations, comments, or extra text.
- Start your response immediately with {{ and end immediately with }}.
- No text, newlines, or characters before or after the JSON.

The JSON format must be exactly:
{{
  "matching_hotels": [
    {{
      "id": Hotel ID
    }},
    ...
  ]
}}
"""
        data = {
            "contents": [
                {
                    "parts": [
                        {
                            "text": best_hotels_prompt
                        }
                    ]
                }
            ]
        }
    else:
        # Normal chat prompt
        chat_prompt = f"""
أنت مساعد افتراضي ذكي يعمل كموظف خدمة عملاء رسمي لفندق [طرزان]. مهمتك الأساسية هي الرد على استفسارات الضيوف والمستخدمين المتعلقة فقط بالفندق وخدماته.

رسالة المستخدم:
{prompt}
"""
        data = {
            "contents": [
                {
                    "parts": [
                        {
                            "text": chat_prompt
                        }
                    ]
                }
            ]
        }

    try:
        response = requests.post(url, headers=headers, json=data)
        if response.status_code == 200:
            json_data = response.json()
            print(json_data)
            
            if 'candidates' in json_data and json_data['candidates']:
                message = json_data['candidates'][0].get('content', {}).get('parts', [{}])[0].get('text', '')
                message = message.strip()

                if text:
                    # Hotel Matching Mode
                    # Clean if it starts with ```json or ```
                    if message.startswith('```json'):
                        message = message[7:].strip()
                    if message.startswith('```'):
                        message = message[3:].strip()
                    if message.endswith('```'):
                        message = message[:-3].strip()

                    try:
                        result_json = json.loads(message)
                        matching_hotels = result_json.get('matching_hotels', [])
                        print(matching_hotels)
                        return matching_hotels
                    except json.JSONDecodeError as e:
                        print(f"Error decoding JSON: {e}\nMessage content: {message}")
                        return None
                else:
                    # Normal Chat Mode
                    return message
            else:
                print("Error: No candidates found in the response.")
                return None
        else:
            print(f"Error: {response.status_code} - {response.text}")
            return None

    except requests.RequestException as e:
        print(f"Error: Request failed - {e}")
        return None
