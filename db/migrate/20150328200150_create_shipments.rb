class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :name
      t.datetime :schedule
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :shipments, :users
  end
end
