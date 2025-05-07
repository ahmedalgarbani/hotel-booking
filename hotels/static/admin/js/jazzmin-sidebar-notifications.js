/**
 * Script para agregar badges de notificaciones a la barra lateral de Jazzmin
 */
document.addEventListener('DOMContentLoaded', function() {
    console.log('Jazzmin sidebar notifications script loaded');
    
    // Función para obtener el número de notificaciones no leídas
    function getUnreadCount() {
        // Intentar obtener el número desde la variable global
        if (window.unreadNotificationsCount !== undefined) {
            return window.unreadNotificationsCount.toString();
        }
        
        // Intentar obtener el número desde el elemento oculto
        const hiddenCount = document.getElementById('unread-notifications-count');
        if (hiddenCount && hiddenCount.textContent.trim() !== '') {
            return hiddenCount.textContent.trim();
        }
        
        // Intentar obtener el número desde la badge del navbar
        const navbarBadge = document.querySelector('.navbar-badge');
        if (navbarBadge && navbarBadge.textContent.trim() !== '') {
            return navbarBadge.textContent.trim();
        }
        
        return '0';
    }
    
    // Función para agregar badges a los elementos de la barra lateral
    function addSidebarBadges() {
        const unreadCount = getUnreadCount();
        if (unreadCount === '0') return;
        
        console.log('Adding sidebar badges with count:', unreadCount);
        
        // Buscar todos los elementos de la barra lateral
        const sidebarItems = document.querySelectorAll('.nav-sidebar .nav-item');
        sidebarItems.forEach(function(item) {
            // Verificar si el elemento contiene texto relacionado con notificaciones
            const itemText = item.textContent.trim();
            if (itemText.includes('إشعارات') || itemText.includes('الإشعارات') || itemText.includes('Notifications')) {
                console.log('Found sidebar notification item:', itemText);
                
                // Buscar el enlace dentro del elemento
                const link = item.querySelector('a');
                if (link && !link.querySelector('.badge')) {
                    // Crear el badge
                    const badge = document.createElement('span');
                    badge.className = 'badge badge-warning right';
                    badge.textContent = unreadCount;
                    badge.style.float = 'right';
                    badge.style.backgroundColor = '#ffc107';
                    badge.style.color = '#212529';
                    badge.style.borderRadius = '10px';
                    badge.style.padding = '2px 6px';
                    badge.style.fontSize = '0.75rem';
                    badge.style.marginRight = '10px';
                    
                    // Agregar el badge al enlace
                    link.appendChild(badge);
                    console.log('Added badge to sidebar item link');
                }
                
                // Buscar el encabezado del grupo si existe
                const header = item.querySelector('.nav-link[data-toggle="treeview"]');
                if (header && !header.querySelector('.badge')) {
                    // Crear el badge para el encabezado
                    const headerBadge = document.createElement('span');
                    headerBadge.className = 'badge badge-warning right';
                    headerBadge.textContent = unreadCount;
                    headerBadge.style.float = 'right';
                    headerBadge.style.backgroundColor = '#ffc107';
                    headerBadge.style.color = '#212529';
                    headerBadge.style.borderRadius = '10px';
                    headerBadge.style.padding = '2px 6px';
                    headerBadge.style.fontSize = '0.75rem';
                    headerBadge.style.marginRight = '10px';
                    
                    // Agregar el badge al encabezado
                    header.appendChild(headerBadge);
                    console.log('Added badge to sidebar item header');
                }
            }
        });
    }
    
    // Ejecutar la función varias veces para asegurar que se carguen todos los elementos
    addSidebarBadges();
    setTimeout(addSidebarBadges, 1000);
    setTimeout(addSidebarBadges, 3000);
});
