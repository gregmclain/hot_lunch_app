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
    $.getJSON('/menu_info',
              { day: getOrderDay(), month: getOrderMonth(), year: getOrderYear(), student_id: 1},
            function (result) {
            $('.menu-info').html(result.content)
        }
    )
}