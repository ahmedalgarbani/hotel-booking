# توثيق واجهة برمجة التطبيقات للضيوف (Guest API)

## نظرة عامة
توفر هذه الواجهة البرمجية إمكانية إدارة بيانات الضيوف في نظام حجز الفنادق. يمكن استخدامها لإضافة ضيوف جدد، وعرض بيانات الضيوف الحاليين، وتحديث بيانات الضيوف، وحذف بيانات الضيوف.

## المصادقة والصلاحيات
تتطلب جميع نقاط النهاية في هذه الواجهة البرمجية مصادقة المستخدم. يجب إرسال توكن المستخدم في رأس الطلب (Authorization header) بالصيغة التالية:

```
Authorization: Bearer {access_token}
```

يمكن الحصول على توكن المستخدم عن طريق تسجيل الدخول باستخدام نقطة النهاية `/api/login/`.

### صلاحيات المستخدمين

1. **المستخدم العادي (customer)**:
   - يمكنه فقط إضافة ضيوف للحجوزات التي قام بها
   - يمكنه فقط عرض الضيوف المرتبطين بحجوزاته

2. **مدير الفندق (hotel_manager) والمشرف (staff)**:
   - يمكنه إضافة ضيوف لأي حجز
   - يمكنه عرض جميع الضيوف

## النقاط النهائية (Endpoints)

### 1. إنشاء ضيف جديد
- **URL**: `/api/create-guest/` أو `/api/guests/`
- **Method**: `POST`
- **الوصف**: إنشاء سجل ضيف جديد في النظام
- **البيانات المطلوبة**:

```json
{
  "name": "اسم الضيف",
  "phone_number": "+1234567890",
  "gender": "male",
  "birthday_date": "1990-01-01",
  "check_in_date": "2025-06-01T14:00:00",
  "check_out_date": "2025-06-05T12:00:00",
  "hotel": 1,
  "booking": 1
}
```

### 2. إنشاء مجموعة من الضيوف دفعة واحدة
- **URL**: `/api/create-multiple-guests/`
- **Method**: `POST`
- **الوصف**: إنشاء مجموعة من سجلات الضيوف دفعة واحدة
- **البيانات المطلوبة**: مصفوفة من بيانات الضيوف

```json
[
  {
    "name": "الضيف الأول",
    "phone_number": "+1234567890",
    "gender": "male",
    "birthday_date": "1990-01-01",
    "check_in_date": "2025-06-01T14:00:00",
    "check_out_date": "2025-06-05T12:00:00",
    "hotel": 1,
    "booking": 1
  },
  {
    "name": "الضيف الثاني",
    "phone_number": "+9876543210",
    "gender": "female",
    "birthday_date": "1992-05-15",
    "check_in_date": "2025-06-01T14:00:00",
    "check_out_date": "2025-06-05T12:00:00",
    "hotel": 1,
    "booking": 1
  }
]
```

- **الاستجابة الناجحة**: مصفوفة تحتوي على بيانات الضيوف المنشأة

```json
[
  {
    "id": 1,
    "name": "الضيف الأول",
    "phone_number": "+1234567890",
    "id_card_image": null,
    "gender": "male",
    "birthday_date": "1990-01-01",
    "check_in_date": "2025-06-01T14:00:00",
    "check_out_date": "2025-06-05T12:00:00",
    "hotel": 1,
    "booking": 1
  },
  {
    "id": 2,
    "name": "الضيف الثاني",
    "phone_number": "+9876543210",
    "id_card_image": null,
    "gender": "female",
    "birthday_date": "1992-05-15",
    "check_in_date": "2025-06-01T14:00:00",
    "check_out_date": "2025-06-05T12:00:00",
    "hotel": 1,
    "booking": 1
  }
]
```

- **الحقول الاختيارية**:
  - `id_card_image`: صورة الهوية (يتم إرسالها كملف في طلب multipart/form-data)

- **الاستجابة الناجحة**:
```json
{
  "id": 1,
  "name": "اسم الضيف",
  "phone_number": "+1234567890",
  "id_card_image": null,
  "gender": "male",
  "birthday_date": "1990-01-01",
  "check_in_date": "2025-06-01T14:00:00",
  "check_out_date": "2025-06-05T12:00:00",
  "hotel": 1,
  "booking": 1
}
```

### 2. الحصول على قائمة الضيوف
- **URL**: `/api/guests/`
- **Method**: `GET`
- **الوصف**: الحصول على قائمة جميع الضيوف
- **الاستجابة الناجحة**:
```json
{
  "count": 1,
  "next": null,
  "previous": null,
  "results": [
    {
      "id": 1,
      "name": "اسم الضيف",
      "phone_number": "+1234567890",
      "id_card_image": null,
      "gender": "male",
      "birthday_date": "1990-01-01",
      "check_in_date": "2025-06-01T14:00:00",
      "check_out_date": "2025-06-05T12:00:00",
      "hotel": 1,
      "booking": 1
    }
  ]
}
```

### 3. الحصول على تفاصيل ضيف محدد
- **URL**: `/api/guests/{id}/`
- **Method**: `GET`
- **الوصف**: الحصول على تفاصيل ضيف محدد بواسطة المعرف
- **الاستجابة الناجحة**:
```json
{
  "id": 1,
  "name": "اسم الضيف",
  "phone_number": "+1234567890",
  "id_card_image": null,
  "gender": "male",
  "birthday_date": "1990-01-01",
  "check_in_date": "2025-06-01T14:00:00",
  "check_out_date": "2025-06-05T12:00:00",
  "hotel": 1,
  "booking": 1
}
```

### 4. تحديث بيانات ضيف
- **URL**: `/api/guests/{id}/`
- **Method**: `PUT`
- **الوصف**: تحديث جميع بيانات ضيف محدد
- **البيانات المطلوبة**: نفس بيانات إنشاء ضيف جديد

### 5. تحديث جزئي لبيانات ضيف
- **URL**: `/api/guests/{id}/`
- **Method**: `PATCH`
- **الوصف**: تحديث بعض بيانات ضيف محدد
- **البيانات المطلوبة**: فقط الحقول المراد تحديثها

### 6. حذف ضيف
- **URL**: `/api/guests/{id}/`
- **Method**: `DELETE`
- **الوصف**: حذف ضيف محدد من النظام

## أمثلة على الاستخدام

### إنشاء ضيف جديد باستخدام cURL
```bash
curl -X POST \
  http://localhost:8000/api/create-guest/ \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_ACCESS_TOKEN' \
  -d '{
    "name": "محمد أحمد",
    "phone_number": "+966501234567",
    "gender": "male",
    "birthday_date": "1985-05-15",
    "check_in_date": "2025-06-10T14:00:00",
    "check_out_date": "2025-06-15T12:00:00",
    "hotel": 1,
    "booking": 1
  }'
```

### إنشاء ضيف جديد مع صورة هوية باستخدام cURL
```bash
curl -X POST \
  http://localhost:8000/api/create-guest/ \
  -H 'Authorization: Bearer YOUR_ACCESS_TOKEN' \
  -H 'Content-Type: multipart/form-data' \
  -F 'name=محمد أحمد' \
  -F 'phone_number=+966501234567' \
  -F 'gender=male' \
  -F 'birthday_date=1985-05-15' \
  -F 'check_in_date=2025-06-10T14:00:00' \
  -F 'check_out_date=2025-06-15T12:00:00' \
  -F 'hotel=1' \
  -F 'booking=1' \
  -F 'id_card_image=@/path/to/id_card.jpg'
```

### إنشاء مجموعة من الضيوف دفعة واحدة باستخدام cURL
```bash
curl -X POST \
  http://localhost:8000/api/create-multiple-guests/ \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer YOUR_ACCESS_TOKEN' \
  -d '[
    {
      "name": "محمد أحمد",
      "phone_number": "+966501234567",
      "gender": "male",
      "birthday_date": "1985-05-15",
      "check_in_date": "2025-06-10T14:00:00",
      "check_out_date": "2025-06-15T12:00:00",
      "hotel": 1,
      "booking": 1
    },
    {
      "name": "فاطمة علي",
      "phone_number": "+966509876543",
      "gender": "female",
      "birthday_date": "1990-08-20",
      "check_in_date": "2025-06-10T14:00:00",
      "check_out_date": "2025-06-15T12:00:00",
      "hotel": 1,
      "booking": 1
    },
    {
      "name": "خالد محمد",
      "phone_number": "+966505555555",
      "gender": "male",
      "birthday_date": "1988-03-10",
      "check_in_date": "2025-06-10T14:00:00",
      "check_out_date": "2025-06-15T12:00:00",
      "hotel": 1,
      "booking": 1
    }
  ]'
```

## ملاحظات هامة
- يجب أن يكون تنسيق التاريخ ISO 8601 (مثال: `YYYY-MM-DDThh:mm:ss`)
- يجب أن يكون حقل `gender` إما `male` أو `female`
- إذا لم يتم تحديد `check_in_date` أو `check_out_date`، سيتم استخدام تواريخ الحجز تلقائيًا
- يجب أن يكون المستخدم هو صاحب الحجز لإضافة ضيوف إليه، أو أن يكون مدير فندق أو مشرف
- عند إرسال مجموعة من الضيوف دفعة واحدة، يتم التحقق من ملكية جميع الحجوزات المرتبطة
- يجب أن تكون قيم `hotel` و `booking` معرفات صالحة لفندق وحجز موجودين في النظام
