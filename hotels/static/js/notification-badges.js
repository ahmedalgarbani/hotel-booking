/**
 * إضافة شارات عدد الإشعارات إلى القائمة الجانبية والقائمة العلوية
 */
document.addEventListener('DOMContentLoaded', function() {
    // الحصول على عدد الإشعارات غير المقروءة من شارة الإشعارات في شريط التنقل
    const navbarBadge = document.querySelector('.navbar-badge');
    if (!navbarBadge) return;

    const unreadCount = navbarBadge.textContent.trim();
    if (!unreadCount || unreadCount === '0') return;

    // إضافة شارة إلى رابط الإشعارات في القائمة العلوية
    const topMenuNotificationLink = document.querySelector('.nav-item a[href*="notifications_notifications_changelist"]');
    if (topMenuNotificationLink) {
        // التحقق من عدم وجود شارة بالفعل
        if (!topMenuNotificationLink.querySelector('.badge')) {
            const badge = document.createElement('span');
            badge.className = 'badge badge-warning notification-badge';
            badge.textContent = unreadCount;
            topMenuNotificationLink.appendChild(badge);
        }
    }

    // إضافة شارة إلى قسم الإشعارات في القائمة الجانبية
    const sidebarNotificationLink = document.querySelector('.nav-sidebar a[href*="notifications_notifications_changelist"]');
    if (sidebarNotificationLink) {
        // التحقق من عدم وجود شارة بالفعل
        if (!sidebarNotificationLink.querySelector('.badge')) {
            const badge = document.createElement('span');
            badge.className = 'badge badge-warning right notification-badge';
            badge.textContent = unreadCount;
            sidebarNotificationLink.appendChild(badge);
        }
    }

    // إضافة شارة إلى قسم الإشعارات في القائمة الجانبية (النموذج المجمع)
    const sidebarNotificationGroup = document.querySelector('.nav-sidebar .nav-item .nav-treeview a[href*="notifications_notifications_changelist"]');
    if (sidebarNotificationGroup) {
        // التحقق من عدم وجود شارة بالفعل
        if (!sidebarNotificationGroup.querySelector('.badge')) {
            const badge = document.createElement('span');
            badge.className = 'badge badge-warning right notification-badge';
            badge.textContent = unreadCount;
            sidebarNotificationGroup.appendChild(badge);
        }
    }

    // إضافة شارة إلى عنوان قسم الإشعارات في القائمة الجانبية
    const sidebarHeaders = document.querySelectorAll('.nav-sidebar .nav-item .nav-link[data-toggle="treeview"]');
    sidebarHeaders.forEach(header => {
        const headerText = header.textContent.trim();
        if (headerText.includes('الإشعارات')) {
            // التحقق من عدم وجود شارة بالفعل
            if (!header.querySelector('.badge')) {
                const badge = document.createElement('span');
                badge.className = 'badge badge-warning right notification-badge';
                badge.textContent = unreadCount;
                header.appendChild(badge);
            }
        }
    });
});
