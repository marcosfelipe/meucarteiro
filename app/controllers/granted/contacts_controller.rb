class Granted::ContactsController < GrantedController

  def index
    if params[:group_id]
      @group = Group.find params[:group_id]
      @contacts = current_user.groups.find(@group).contacts.all
        .search(params[:search]).order('contacts.created_at desc')
        .activated
        .page(params[:page]).per(15)
    else
      @contacts = current_user.contacts.includes(:groups)
        .search(params[:search]).order('contacts.created_at desc')
        .activated
        .page(params[:page]).per(15)
    end
  end

  def update

    @contact = Contact.find params[:id]

    respond_to do |format|
      if @contact.update(contact_edit_params)
        flash[:notice] = "Atualizado!"
      end
      format.html { render :edit, layout: false }
    end
  end

  def edit
    @contact = current_user.contacts.find params[:id]

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def create

  end

  def destroy
    @contact = current_user.contacts.find params[:id]
    @contact.disabled!
    redirect_to :back, notice: 'Contato deletado!'
  end


  private

  def contact_params
    params.require(:contact).permit(:file)
  end

  def contact_edit_params
    params.require(:contact).permit(:name, :phone, :email, :birth, {:group_ids => []}, :city)
  end


end
