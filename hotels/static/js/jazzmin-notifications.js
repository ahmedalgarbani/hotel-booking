$(document).ready(function() {
    // تحديث عدد الإشعارات كل 60 ثانية
    setInterval(function() {
        $.ajax({
            url: '/api/notifications/count/',
            type: 'GET',
            success: function(data) {
                if (data.count > 0) {
                    $('.navbar-badge').text(data.count).show();
                } else {
                    $('.navbar-badge').hide();
                }
            }
        });
    }, 60000);

    // تحديث حالة الإشعار عند النقر عليه
    $(document).on('click', '.notification-item', function(e) {
        var notificationId = $(this).data('id');
        if (notificationId) {
            $.ajax({
                url: '/api/notifications/' + notificationId + '/mark-read/',
                type: 'POST',
                headers: {
                    'X-CSRFToken': getCookie('csrftoken')
                },
                success: function() {
                    // تحديث عدد الإشعارات بعد تحديث حالة الإشعار
                    $.ajax({
                        url: '/api/notifications/count/',
                        type: 'GET',
                        success: function(data) {
                            if (data.count > 0) {
                                $('.navbar-badge').text(data.count).show();
                            } else {
                                $('.navbar-badge').hide();
                            }
                        }
                    });
                }
            });
        }
    });

    // وظيفة للحصول على قيمة CSRF token
    function getCookie(name) {
        var cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
});
