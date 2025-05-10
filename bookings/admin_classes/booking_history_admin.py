from django.contrib import admin
from django.utils.translation import gettext_lazy as _

# Import models
from bookings.models import BookingHistory

class BookingHistoryAdmin(admin.ModelAdmin):
    list_display = (
        'booking', 'history_date', 'changed_by', 'previous_status', 'new_status'
    )
    list_filter = ('new_status', 'history_date', 'booking__hotel') # Filter by hotel via booking
    search_fields = (
        'booking__id', 'booking__hotel__name', 'changed_by__username'
    )
    ordering = ('-history_date',)
    readonly_fields = [f.name for f in BookingHistory._meta.fields]

    def has_add_permission(self, request):
        return False

    def has_change_permission(self, request, obj=None):
        return False

    def has_delete_permission(self, request, obj=None):
        # Permitir a los superusuarios eliminar cualquier registro de historial
        if request.user.is_superuser:
            return True

        # Permitir a los gerentes de hotel eliminar registros de historial de su propio hotel
        if request.user.user_type == 'hotel_manager' and hasattr(request.user, 'hotel') and request.user.hotel:
            if obj is None:  # Al mostrar la lista
                return True
            # Verificar si el registro pertenece al hotel del gerente
            return obj.hotel == request.user.hotel

        return False
