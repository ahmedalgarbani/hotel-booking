document.addEventListener('DOMContentLoaded', function () {
    const button = document.getElementById('calcPriceBtn');
    if (!button) return;

    button.addEventListener('click', function () {
        const roomSelect = document.getElementById('id_room');
        const checkInDate = document.getElementById('id_check_in_date_0');
        const checkOutDate = document.getElementById('id_check_out_date_0');
        const amountInput = document.getElementById('id_amount');

        if (!roomSelect.value || !checkInDate.value || !checkOutDate.value) {
            alert("يرجى اختيار الغرفة وتواريخ الوصول والمغادرة.");
            return;
        }

        const roomId = roomSelect.value;
        const checkIn = checkInDate.value;
        const checkOut = checkOutDate.value;
        const roomNumber = 1; 

        fetch(`/bookings/get-room-price/?room_id=${roomId}&check_in=${checkIn}&check_out=${checkOut}&room_number=${roomNumber}`)
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    alert(data.error);
                } else {
                    amountInput.value = data.total;
                }
            })
            .catch(err => {
                alert(err)
                console.error(err);
                alert("حدث خطأ أثناء حساب السعر.");
            });
    });
});
