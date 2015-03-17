class Contact < ActiveRecord::Base

  enum active: { disabled:0, enabled:1 }

  belongs_to :user
  has_many :group_contacts
  has_many :groups, through: :group_contacts


  validates :user_id, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true }
  validates :phone, allow_nil: true, numericality: true, length: {minimum: 10, maximum: 15}
  validate :at_least_a_means

  def at_least_a_means
    if email.blank? and phone.blank?
      errors.add :contact, "At least one means should be given!"
    end
  end

  def self.search(search)
    if search
      where ['contacts.name LIKE ? OR contacts.phone LIKE ? OR contacts.email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"]
    else
      all
    end
  end

  scope :activated, -> { where active: 1 }

end
