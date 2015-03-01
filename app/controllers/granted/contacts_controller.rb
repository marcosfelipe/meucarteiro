class Granted::ContactsController < GrantedController

  def index

    @contacts = Contact.joins(:groups).where({'groups.id' => params[:group_id]})
  end

  def new

  end

  def create

  end


  private

  def contact_params
    params.require(:contact).permit(:file)
  end


end
