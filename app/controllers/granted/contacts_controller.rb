class Granted::ContactsController < GrantedController

  def index
    if params[:group_id]
      @group = Group.find params[:group_id]
      @contacts = current_user.groups.find(@group).contacts.all.order('contacts.created_at desc').page(params[:page]).per(15)
    else
      @contacts = current_user.contacts.joins(:groups).search(params[:search]).order('contacts.created_at desc').page(params[:page]).per(15)
    end
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
