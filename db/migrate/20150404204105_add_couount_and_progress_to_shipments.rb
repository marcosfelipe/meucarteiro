class AddCouountAndProgressToShipments < ActiveRecord::Migration
  def change
    
    add_column :shipments, :count, :integer, default: 0
    add_column :shipments, :progress, :integer, default: 0
    
  end
end
