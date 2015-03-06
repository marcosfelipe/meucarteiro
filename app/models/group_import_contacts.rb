class GroupImportContacts

  include ActiveModel::Model

  attr_accessor :name, :file

  validates :name, :file, presence: true

end