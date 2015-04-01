class AddFacebookToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :facebook, :string
  end
end
