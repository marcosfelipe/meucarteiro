class AddStatusToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :status, :integer, default: 0
  end
end
