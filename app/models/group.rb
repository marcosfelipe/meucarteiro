class Group < ActiveRecord::Base

  has_many :group_contacts
  has_many :contacts, through: :group_contacts

  enum import_status: { importing: 0, ok:1 }

end
