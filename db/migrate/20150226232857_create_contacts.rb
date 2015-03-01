class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :city
      t.string :email
      t.integer :phone
      t.date :birth
      t.boolean :active
      t.references :user

      t.timestamps
    end
  end
end
