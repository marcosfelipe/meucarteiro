class Granted::GroupsController < GrantedController

  def index
    @groups = Group.all
  end

  def new
    @group_contacts = GroupImportContacts.new
  end

  def create

    @group_contacts = GroupImportContacts.new(group_import_contacts_params)

    if @group_contacts.valid?

      group = Group.create!(name: group_import_contacts_params[:name], user_id: current_user.id)

      GroupContact.import(group, group_import_contacts_params[:file])

      redirect_to groups_path, notice: 'Seu grupo de contatos estará disponível em instantes!'
    else
      render action: :new
    end


  end


  private

  def group_import_contacts_params
    params.require(:group_import_contacts).permit(:name, :file)
  end


end
