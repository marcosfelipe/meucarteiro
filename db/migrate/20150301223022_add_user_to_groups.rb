class AddUserToGroups < ActiveRecord::Migration
  def change

    change_table :groups do |t|
      t.references :user
    end

  end
end
