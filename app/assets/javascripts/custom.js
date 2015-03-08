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


    $('.ui.toggle.button').state();

    $('body').on('click','.message .close', function() {
        $(this).closest('.message').fadeOut();
    });


});