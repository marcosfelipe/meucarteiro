$(document).ready(function () {

    $('.ui.checkbox')
        .checkbox()
    ;

    $('select.dropdown')
        .dropdown()
    ;

    $('.ui.radio.checkbox')
        .checkbox()
    ;


    $('.message .close').on('click', function() {
        $(this).closest('.message').fadeOut();
    });


});