class CreateGroupContacts < ActiveRecord::Migration
  def change
    create_table :group_contacts do |t|
      t.references :contact
      t.references :group

      t.timestamps null: false
    end
  end
end
