class CreateShipmentContacts < ActiveRecord::Migration
  def change
    create_table :shipment_contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :facebook
      t.references :shipment, index: true

      t.timestamps null: false
    end
    add_foreign_key :shipment_contacts, :shipments
  end
end
