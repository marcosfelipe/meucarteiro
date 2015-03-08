class GroupDuplicate

  include ActiveModel::Model

  attr_accessor :id, :name, :current_user

  validate :group_exists, :group_belongs_to_user

  def group_exists
    errors.add(:id, "Group does not exists!") unless Group.exists?(id)
  end

  def group_belongs_to_user
    if Group.exists?(id)
      group = Group.find(id)
      errors.add(:id, "Group not belongs to this user!") unless group.user_id == current_user.id
    end
  end

end