class Group < ActiveRecord::Base

  belongs_to :user

  has_many :group_contacts
  has_many :contacts, through: :group_contacts

  validates :name, presence: true



  def duplicate(params)
    group = self.dup
    group.name = params[:name] || group.name
    group.save
    group
  end

  def self.search(search)
    if search
      where ['name LIKE ?', "%#{search}%"]
    else
      all
    end
  end

  def delete_contacts
    contacts.where("group_id = ?", id).destroy_all
  end


end
