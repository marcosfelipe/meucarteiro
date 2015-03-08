class Group < ActiveRecord::Base

  has_many :group_contacts
  has_many :contacts, through: :group_contacts

  enum import_status: { importing: 0, ok:1 }


  def duplicate(params)

    group = self.dup
    group.name = params[:name] || group.name
    group.save

  end

end
