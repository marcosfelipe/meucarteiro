class Granted::GroupsController < GrantedController

  before_filter :groups_count

  def index
    @groups = current_user.groups.search(params[:search]).order(:created_at).page(params[:page])
  end

  def new
    @group = current_user.groups.new
    @groups = current_user.groups.all
  end

  # def create
  #
  #   @group_contacts = GroupImportContacts.new(group_import_contacts_params)
  #
  #   if @group_contacts.valid?
  #
  #     group = current_user.groups.create! name: group_import_contacts_params[:name]
  #
  #     #coloca na queue a importação de contatos
  #     CsvImportJob.perform_later(group, group_import_contacts_params[:file].path)
  #
  #     redirect_to groups_path, notice: 'Seu grupo de contatos estará disponível em instantes!'
  #   else
  #     render action: :new
  #   end
  #
  #
  # end

  def destroy

    @group = current_user.groups.find params[:id]

    if group_delete_params[:delete_contacts] == '1'
      @group.delete_contacts
    end

    @group.destroy

    redirect_to groups_path, notice: 'Grupo deletado!'

  end

  def create

    @group = current_user.groups.new group_params.except(:groups)
    @groups = current_user.groups.all

    if @group.save
      MergeGroupsJob.perform_later @group, group_params[:groups]
      redirect_to groups_path, notice: 'Grupo criado! Os contatos estarão disponiveis em breve!'
    else
      render action: :new
    end

  end


  def duplicate
    group = current_user.groups.find group_duplicate_params[:id]
    new_group = group.duplicate group_duplicate_params
    DuplicateGroupContactsJob.perform_later new_group, group
    redirect_to groups_path, notice: 'Seu grupo de contatos estará disponível em instantes!'
  end


  private

  def groups_count
    @groups_count = current_user.groups.count
  end

  def group_duplicate_params
    params.require(:group).permit(:id, :name)
  end

  def group_params
    params.require(:group).permit(:name, {:groups => []})
  end

  def group_delete_params
    params.require(:options).permit(:delete_contacts)
  end


end
