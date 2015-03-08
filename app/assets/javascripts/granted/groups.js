$(document).ready(function () {

    $('.duplicate-group').on('click', function () {

        var name = $(this).closest('tr').find('.group-name').text();
        var id = $(this).attr('data-id');

        $('#modal-duplicate-group').find('span#duplicate-group-name').text(name);
        $('#modal-duplicate-group').find('input#id').val(id);

        $('#modal-duplicate-group').modal('show');


    });

});