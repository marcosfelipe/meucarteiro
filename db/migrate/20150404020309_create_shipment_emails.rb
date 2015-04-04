class CreateShipmentEmails < ActiveRecord::Migration
  def change
    create_table :shipment_emails do |t|
      t.string :subject
      t.string :body
      t.string :from
      t.references :shipment, index: true

      t.timestamps null: false
    end
    add_foreign_key :shipment_emails, :shipments
  end
end
