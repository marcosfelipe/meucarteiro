function set_message(status, msg) {

    if (status == 'error')
        status = 'red';
    else if (status == 'success')
        status = 'green';

    $('#message-container').append('<div class="ui message ' + status + ' segment vertical inverted">' +
        '<i class="close icon"></i>' +
        msg + "</div>");
}

function init_chosen() {
    $('.chosen-select').chosen({
        allow_single_deselect: true,
        no_results_text: 'No results matched',
        width: '400px'
    });
}

function init_datepicker() {
    $(".datepicker").each(function (i, o) {
        var params = $(this).attr('data-options');
        params = jQuery.parseJSON(params);
        $(this).datepicker(params);
    });
}


$(document).ready(function () {

    $('.ui.checkbox').checkbox();

    $('select.dropdown, .ui.dropdown').dropdown();

    $('.ui.radio.checkbox').checkbox();


    $('.ui.toggle.button').state();

    $('body').on('click', '.message .close', function () {
        $(this).closest('.message').fadeOut();
    });


    init_datepicker();
    init_chosen();

});