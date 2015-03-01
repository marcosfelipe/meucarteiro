class Contact < ActiveRecord::Base

  belongs_to :user

  has_many :group_contacts
  has_many :groups, through: :group_contacts



end
