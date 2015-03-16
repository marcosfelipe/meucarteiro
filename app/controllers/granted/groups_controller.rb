class Granted::GroupsController < GrantedController

  def index
    @groups = Group.where(user_id: current_user).search(params[:search]).order(:created_at).page(params[:page])
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

  def duplicate
    params = group_duplicate_params

    group = GroupDuplicate.new(params)

    if group.valid?
      group = Group.find(params[:id])
      new_group = group.duplicate params

      DuplicateGroupContactsJob.perform_later new_group, group

      notice = 'Seu grupo de contatos estará disponível em instantes!'
    else
      notice = 'Grupo invalido!'
      group.errors.full_messages.each do |error|
        notice += error.to_s
      end
    end
    redirect_to groups_path, notice: notice

  end


  private

  def group_duplicate_params
    params.require(:group).permit(:id, :name).merge({current_user: current_user})
  end

  def group_import_contacts_params
    params.require(:group_import_contacts).permit(:name, :file)
  end


end
