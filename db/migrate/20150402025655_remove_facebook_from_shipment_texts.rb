class RemoveFacebookFromShipmentTexts < ActiveRecord::Migration
  def change

    remove_column :shipment_texts, :facebook


  end
end
