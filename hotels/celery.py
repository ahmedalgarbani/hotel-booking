from __future__ import absolute_import, unicode_literals

import os
from celery import Celery


os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'hotels.settings')

app = Celery('hotels')


app.config_from_object('django.conf:settings', namespace='CELERY')


@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')



# celery -A hotels worker --pool=solo -l info
