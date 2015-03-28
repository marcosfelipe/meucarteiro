class AlterFileAndRemoveNameFromImports < ActiveRecord::Migration
  def change

    remove_column :imports, :name


  end
end
