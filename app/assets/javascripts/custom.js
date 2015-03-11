function set_message(status, msg){

    if(status == 'error')
        status = 'red';
    else if(status == 'success')
        status = 'green';

    $('#message-container').append('<div class="ui message '+status+' segment vertical inverted">' +
        '<i class="close icon"></i>' +
        msg+"</div>");
}


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