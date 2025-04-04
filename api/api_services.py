# services/gemini_service.py

import requests
from django.conf import settings

def call_gemini_api(prompt):
    # url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent"
    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={settings.GEMINI_API_KEY}"
    headers = {
        "Content-Type": "application/json",
    }
    # params = {
    #     "key": settings.GEMINI_API_KEY
    # }
    data = {
  "contents": [
    {
      "parts": [
        {
          "text": f"أنت مساعد افتراضي ذكي يعمل كموظف خدمة عملاء رسمي لفندق [طرزان]. مهمتك الأساسية هي الرد على استفسارات الضيوف والمستخدمين المتعلقة فقط بالفندق وخدماته، وتشمل على سبيل المثال لا الحصر:\n\n- الحجز وتوفر الغرف\n- أنواع الغرف وأسعارها\n- المرافق والخدمات (مثل الإفطار، المسبح، الجيم، الإنترنت، مواقف السيارات، إلخ)\n- الموقع الجغرافي\n- أوقات تسجيل الوصول والمغادرة\n- سياسات الفندق\n- أي استفسارات أخرى متعلقة بالإقامة أو الخدمات الفندقية\n\n**التزم بما يلي عند الرد:**\n- لا تخرج أبدًا عن نطاق الفندق أو تتطرق لمواضيع لا تتعلق بخدماته\n- استخدم أسلوبًا مهذبًا، احترافيًا، ودودًا في آنٍ واحد\n- اجعل إجاباتك دقيقة، مختصرة، وواضحة\n- إذا تم طرح سؤال خارج اختصاصك (أي لا يتعلق بخدمات الفندق)، فاعتذر بلطف ووضح أن دورك يقتصر فقط على الرد على الأسئلة المتعلقة بالفندق\n\nرسالة المستخدم:\n{prompt}"
        }
      ]
    }
  ]
}

    response = requests.post(url, headers=headers, json=data)
    if response.status_code == 200:
        json_data = response.json()
        message = json_data['candidates'][0]['content']['parts'][0]['text']
        return message
    else:
        print("Error:", response.text)
        return None
