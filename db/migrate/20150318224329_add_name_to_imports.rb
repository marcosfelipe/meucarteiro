class AddNameToImports < ActiveRecord::Migration
  def change
    add_column :imports, :name, :string
    add_column :imports, :file, :string
  end
end
