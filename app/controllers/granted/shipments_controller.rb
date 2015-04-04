class Granted::ShipmentsController < GrantedController

  def index
  end

  def pending
    @shipments = current_user.shipments.pending.all.order "created_at desc"
  end

  def done

  end


  def new
    @shipment = current_user.shipments.new
  end

  def create
    @shipment = current_user.shipments.new shipment_params.except(:group)

    if @shipment.save

      #cria os contatos na remessa
      #todo: setar prioridade de acordo com a conta do usuario
      FattenShippingJob.set(queue: :low
      ).perform_later @shipment, shipment_params[:group][:ids]

      redirect_to shipments_path, notice: 'Envio criado'
    else
      render :new
    end

  end


  private

  def shipment_params
    params.require(:shipment).permit(:name, :schedule,
                                     {:shipment_text_attributes => [:whatsapp, :sms]},
                                     {:shipment_email_attributes => [:from, :subject, :body]},
                                     {:group => {:ids => []}})
  end

end
