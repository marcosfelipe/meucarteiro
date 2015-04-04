class AddSmsToShipmentTextsAndRemoveEmail < ActiveRecord::Migration
  def change

    remove_column :shipment_texts, :email, :string

    add_column :shipment_texts, :sms, :string

  end
end
