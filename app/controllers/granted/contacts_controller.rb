class Granted::ContactsController < GrantedController

  before_filter :contacts_count
  before_action :set_contact, only: [:edit, :update, :destroy]


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
    respond_to do |format|
      if @contact.update(contact_params)
        flash[:notice] = "Atualizado!"
      end
      format.html { render :edit, layout: false }
    end
  end

  def edit
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def new
    @contact = current_user.contacts.new
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def create
    @contact = current_user.contacts.new contact_params
    respond_to do |format|
      if @contact.save
        format.html{ redirect_to new_contact_path, notice: 'Novo contato criado! Continue criando!' }
      else
        format.html{ render :new, layout: false }
      end
    end
  end

  def destroy
    @contact.disabled!
    redirect_to :back, notice: 'Contato deletado!'
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :birth, {:group_ids => []}, :city)
  end

  def contacts_count
    @contacts_count = current_user.contacts.count
  end

  def set_contact
    @contact = current_user.contacts.find params[:id]
  end


end
