class Granted::ShipmentsController < GrantedController

  def index
  end


  def new
    @shipment = current_user.shipments.new
  end

  def create
    @shipment = current_user.shipments.new shipment_params.except(:group)

    if @shipment.save

      #cria os contatos na remessa
      FattenShippingJob.perform_later @shipment, shipment_params[:group][:ids]

      redirect_to shipments_path, notice: 'Envio criado'
    else
      render :new
    end

  end


  private

  def shipment_params
    params.require(:shipment).permit(:name, :schedule, {:shipment_text_attributes => [:whatsapp, :email, :sms]}, {:group => {:ids => []}})
  end

end
