$(document).ready(function () {

    $('.duplicate-group').on('click', function () {
        var name = $(this).closest('tr').find('.group-name').text();
        var id = $(this).attr('data-id');
        var modal = $('#modal-duplicate-group');
        modal.find('span#duplicate-group-name').text(name);
        modal.find('input#id').val(id);
        modal.modal('show');
    });

    $('.delete-group').on('click', function () {
        var name = $(this).closest('tr').find('.group-name').text();
        var id = $(this).attr('data-id');
        var path = $(this).attr('data-path');
        var modal = $('#modal-delete-group');
        modal.find('span#group-name').text(name);
        modal.find('input#id').val(id);
        modal.find('form').attr('action',path);
        modal.modal('show');
    });

    $('#delete-contacts:checkbox').on('change', function(){

        if($(this).is(':checked')){
            $('#delete-contacts-alert').show();
        }else{
            $('#delete-contacts-alert').hide();
        }

    });

});