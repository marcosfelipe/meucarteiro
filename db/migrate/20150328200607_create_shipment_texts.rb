class CreateShipmentTexts < ActiveRecord::Migration
  def change
    create_table :shipment_texts do |t|
      t.string :sms
      t.string :whatsapp
      t.string :facebook
      t.string :email
      t.references :shipment, index: true

      t.timestamps null: false
    end
    add_foreign_key :shipment_texts, :shipments
  end
end
