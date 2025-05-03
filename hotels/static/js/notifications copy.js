/**
 * إدارة الإشعارات في واجهة المستخدم
 */
document.addEventListener('DOMContentLoaded', function() {
    // الحصول على رمز CSRF
    function getCsrfToken() {
        const cookieValue = document.cookie
            .split('; ')
            .find(row => row.startsWith('csrftoken='))
            ?.split('=')[1];
        return cookieValue || '';
    }

    // تحديد عناصر الإشعارات في القائمة المنسدلة
    const navbarNotificationItems = document.querySelectorAll('.dropdown-item[data-notification-id]');
    const notificationCount = document.querySelector('.badge.navbar-badge');

    // إضافة مستمع أحداث لكل إشعار في القائمة المنسدلة
    navbarNotificationItems.forEach(item => {
        item.addEventListener('click', function(e) {
            markNotificationAsRead(this.getAttribute('data-notification-id'));
        });
    });

    // تحديد عناصر الإشعارات في لوحة التحكم
    const dashboardNotificationItems = document.querySelectorAll('.notification-item.unread a');

    // إضافة مستمع أحداث لكل إشعار في لوحة التحكم
    dashboardNotificationItems.forEach(item => {
        const notificationItem = item.closest('.notification-item');
        if (notificationItem) {
            const notificationId = notificationItem.getAttribute('data-notification-id');
            if (notificationId) {
                item.addEventListener('click', function(e) {
                    // لا نمنع السلوك الافتراضي هنا لأننا نريد أن يتم توجيه المستخدم
                    markNotificationAsRead(notificationId);
                });
            }
        }
    });

    // وظيفة لتحديث إشعار واحد كمقروء
    function markNotificationAsRead(notificationId) {
        fetch('/notifications/mark_read/' + notificationId + '/', {
            method: 'POST',
            headers: {
                'X-CSRFToken': getCsrfToken(),
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // تحديث عداد الإشعارات
                updateNotificationCount();

                // إزالة فئة "غير مقروء" من الإشعار في القائمة المنسدلة
                const navbarItem = document.querySelector(`.dropdown-item[data-notification-id="${notificationId}"]`);
                if (navbarItem) {
                    navbarItem.classList.remove('unread');
                }

                // إزالة فئة "غير مقروء" من الإشعار في لوحة التحكم
                const dashboardItem = document.querySelector(`.notification-item[data-notification-id="${notificationId}"]`);
                if (dashboardItem) {
                    dashboardItem.classList.remove('unread');
                }
            }
        })
        .catch(error => console.error('Error marking notification as read:', error));
    }

    // وظيفة لتحديث عداد الإشعارات
    function updateNotificationCount() {
        if (notificationCount) {
            const currentCount = parseInt(notificationCount.textContent);
            if (currentCount > 1) {
                const newCount = currentCount - 1;
                notificationCount.textContent = newCount;

                // تحديث جميع شارات الإشعارات في الصفحة
                const allBadges = document.querySelectorAll('.notification-badge');
                allBadges.forEach(badge => {
                    badge.textContent = newCount;
                });
            } else {
                notificationCount.style.display = 'none';

                // إخفاء جميع شارات الإشعارات في الصفحة
                const allBadges = document.querySelectorAll('.notification-badge');
                allBadges.forEach(badge => {
                    badge.style.display = 'none';
                });
            }
        }
    }

    // تحديث جميع الإشعارات كمقروءة
    const markAllReadButtons = document.querySelectorAll('.mark-all-read');
    markAllReadButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();

            fetch('/notifications/read/', {
                method: 'POST',
                headers: {
                    'X-CSRFToken': getCsrfToken(),
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // إخفاء عداد الإشعارات
                    if (notificationCount) {
                        notificationCount.style.display = 'none';
                    }

                    // إخفاء جميع شارات الإشعارات في الصفحة
                    const allBadges = document.querySelectorAll('.notification-badge');
                    allBadges.forEach(badge => {
                        badge.style.display = 'none';
                    });

                    // إزالة فئة "غير مقروء" من جميع الإشعارات في القائمة المنسدلة
                    navbarNotificationItems.forEach(item => {
                        item.classList.remove('unread');
                    });

                    // إزالة فئة "غير مقروء" من جميع الإشعارات في لوحة التحكم
                    document.querySelectorAll('.notification-item.unread').forEach(item => {
                        item.classList.remove('unread');
                    });

                    // إضافة رسالة تأكيد في القائمة المنسدلة
                    const dropdownMenu = document.querySelector('.dropdown-menu');
                    if (dropdownMenu) {
                        const confirmationMessage = document.createElement('div');
                        confirmationMessage.className = 'dropdown-item text-center text-success';
                        confirmationMessage.textContent = 'تم تحديث جميع الإشعارات كمقروءة';
                        dropdownMenu.prepend(confirmationMessage);

                        // إزالة الرسالة بعد 3 ثوانٍ
                        setTimeout(() => {
                            confirmationMessage.remove();
                        }, 3000);
                    }

                    // إضافة رسالة تأكيد في لوحة التحكم
                    const notificationsWidget = document.querySelector('.dashboard-notifications');
                    if (notificationsWidget) {
                        // إخفاء جميع الإشعارات
                        notificationsWidget.innerHTML = `
                            <div class="empty-notifications">
                                <i class="la la-bell-slash"></i>
                                <p>لا توجد إشعارات جديدة</p>
                            </div>
                        `;
                    }
                }
            })
            .catch(error => console.error('Error marking all notifications as read:', error));
        });
    });
});
