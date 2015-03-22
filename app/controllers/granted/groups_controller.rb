class Granted::GroupsController < GrantedController

  before_filter :groups_count

  def index
    @groups = current_user.groups.search(params[:search]).order(:created_at).page(params[:page])
  end

  def new
    @group_contacts = GroupImportContacts.new
  end

  def create

    @group_contacts = GroupImportContacts.new(group_import_contacts_params)

    if @group_contacts.valid?

      group = current_user.groups.create! name: group_import_contacts_params[:name]

      #coloca na queue a importação de contatos
      CsvImportJob.perform_later(group, group_import_contacts_params[:file].path)

      redirect_to groups_path, notice: 'Seu grupo de contatos estará disponível em instantes!'
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

  def group_import_contacts_params
    params.require(:group_import_contacts).permit(:name, :file)
  end


end
