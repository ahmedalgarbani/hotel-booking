from django.apps import AppConfig

class HotelManagementConfig(AppConfig):
    name = 'HotelManagement'

    def ready(self):
        import HotelManagement.signals
