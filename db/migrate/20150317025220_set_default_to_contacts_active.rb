class SetDefaultToContactsActive < ActiveRecord::Migration
  def change

    change_column :contacts, :active, :boolean, default: 1

  end
end
