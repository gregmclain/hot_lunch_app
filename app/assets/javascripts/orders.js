function getOrderYear(){
    var year = $('#order_order_date_1i').val();

    return year;
}

function getOrderMonth(){
    var month = $('#order_order_date_2i').val();

    return month;
}

function getOrderDay(){
    var day = $('#order_order_date_3i').val();

    return day;
}

function loadMenu() {
    $.getJSON('/menu_info?student_id=1&&year=' + getOrderYear() + '&&month=' + getOrderMonth() + '&&day='+ getOrderDay(), function (result) {
            $('.menu-info').html(result.content)
        }
    )
}