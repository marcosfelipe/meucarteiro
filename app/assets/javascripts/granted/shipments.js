$('#messages-tab .menu .item')
    .tab({
        context: $('#messages-tab')
    })
;

if($(document).find('#pending-list').size() > 0){

    var path = $('#pending-list').attr('data-path');

    setInterval(function(){

        $.ajax({
            url: path + ".json",
            dataType: 'json'
        }).success(function(response){
            $.each(response.shipments, function(i,obj){
                var progress = obj.progress+'%';
                var shipment = $('#pending-list').find('[shipment-id='+obj.id+']');
                shipment.find('.bar').css('width', progress);
                shipment.find('.bar').find('.progress').text(progress);
                shipment.find('.progress.ui').find('.label').text(obj.status);

                if(obj.progress == 100){
                    shipment.find('.progress.ui').removeClass('teal');
                    shipment.find('.progress.ui').addClass('green');
                }

            });
        })

    }, 5000)

}

