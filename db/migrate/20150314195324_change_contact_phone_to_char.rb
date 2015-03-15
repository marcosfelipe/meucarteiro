class ChangeContactPhoneToChar < ActiveRecord::Migration
  def change

    change_column :contacts, :phone, :string, limit: 15

  end
end
