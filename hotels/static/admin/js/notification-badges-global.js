/**
 * Script global para agregar badges de notificaciones en todas las páginas de Django Admin
 */
(function() {
    console.log('Global notification badges script loaded');

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

    // Función para agregar badges a los elementos
    function addBadges() {
        const unreadCount = getUnreadCount();
        if (unreadCount === '0') return;

        console.log('Adding global badges with count:', unreadCount);

        // Agregar badges a los enlaces que contienen "notifications" o "إشعارات"
        document.querySelectorAll('a').forEach(function(link) {
            const href = link.getAttribute('href') || '';
            const text = link.textContent.trim();

            // تجاهل الروابط التي تحتوي على "all_notifications" لأنها تشير إلى جدول الإشعارات
            if ((href.includes('notifications') && !href.includes('all_notifications')) ||
                (text.includes('إشعارات') || text.includes('الإشعارات')) && !href.includes('all_notifications')) {
                if (!link.querySelector('.badge')) {
                    const badge = document.createElement('span');
                    badge.className = 'badge badge-warning';
                    badge.textContent = unreadCount;
                    badge.style.marginLeft = '5px';
                    badge.style.backgroundColor = '#ffc107';
                    badge.style.color = '#212529';
                    badge.style.borderRadius = '10px';
                    badge.style.padding = '2px 6px';
                    badge.style.fontSize = '0.75rem';

                    link.appendChild(badge);
                }
            }
        });

        // Agregar badges a los iconos de campana
        document.querySelectorAll('.fa-bell, .fas.fa-bell').forEach(function(icon) {
            const parent = icon.parentElement;
            if (parent && !parent.querySelector('.badge:not(.navbar-badge)')) {
                const badge = document.createElement('span');
                badge.className = 'badge badge-warning';
                badge.textContent = unreadCount;
                badge.style.position = 'absolute';
                badge.style.top = '0';
                badge.style.right = '0';
                badge.style.transform = 'translate(50%, -50%)';
                badge.style.backgroundColor = '#ffc107';
                badge.style.color = '#212529';
                badge.style.borderRadius = '10px';
                badge.style.padding = '2px 6px';
                badge.style.fontSize = '0.75rem';

                if (window.getComputedStyle(parent).position === 'static') {
                    parent.style.position = 'relative';
                }

                parent.appendChild(badge);
            }
        });
    }

    // Ejecutar cuando el DOM esté cargado
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            addBadges();
            // Ejecutar varias veces para asegurar que se carguen todos los elementos
            setTimeout(addBadges, 1000);
            setTimeout(addBadges, 3000);
        });
    } else {
        // El DOM ya está cargado
        addBadges();
        setTimeout(addBadges, 1000);
        setTimeout(addBadges, 3000);
    }
})();
