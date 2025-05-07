/**
 * إضافة شارات عدد الإشعارات إلى القائمة الجانبية والقائمة العلوية
 */
document.addEventListener('DOMContentLoaded', function() {
    console.log('Notification badges script loaded');
    
    // البحث عن عدد الإشعارات غير المقروءة
    function findUnreadCount() {
        // محاولة العثور على العدد في شارة الإشعارات الموجودة
        const navbarBadge = document.querySelector('.navbar-badge');
        if (navbarBadge && navbarBadge.textContent.trim() !== '') {
            return navbarBadge.textContent.trim();
        }
        
        // محاولة العثور على العدد في عنصر مخفي
        const hiddenCount = document.getElementById('unread-notifications-count');
        if (hiddenCount && hiddenCount.textContent.trim() !== '') {
            return hiddenCount.textContent.trim();
        }
        
        return '0';
    }
    
    // إضافة شارات الإشعارات
    function addBadges() {
        const unreadCount = findUnreadCount();
        if (unreadCount === '0') return;
        
        console.log('Adding badges with count:', unreadCount);
        
        // إضافة شارة إلى جميع الروابط التي تحتوي على كلمة "إشعارات" أو "notifications"
        document.querySelectorAll('a').forEach(function(link) {
            const href = link.getAttribute('href') || '';
            const text = link.textContent.trim();
            
            if (href.includes('notifications') || text.includes('إشعارات') || text.includes('الإشعارات')) {
                if (!link.querySelector('.badge')) {
                    const badge = document.createElement('span');
                    badge.className = 'badge badge-warning';
                    badge.textContent = unreadCount;
                    badge.style.marginRight = '5px';
                    badge.style.marginLeft = '5px';
                    badge.style.backgroundColor = '#ffc107';
                    badge.style.color = '#212529';
                    badge.style.borderRadius = '10px';
                    badge.style.padding = '2px 6px';
                    badge.style.fontSize = '0.75rem';
                    
                    link.appendChild(badge);
                    console.log('Added badge to link:', text);
                }
            }
        });
        
        // إضافة شارة إلى أيقونات الجرس
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
                console.log('Added badge to bell icon');
            }
        });
    }
    
    // تنفيذ الدالة عدة مرات للتأكد من تحميل جميع العناصر
    addBadges();
    setTimeout(addBadges, 1000);
    setTimeout(addBadges, 3000);
});
