FROM python:3.10-slim


WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install -r requ.txt


RUN RUN pip install --upgrade pip


COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
