class AddSeparatorToImports < ActiveRecord::Migration
  def change

    add_column :imports, :separator, "char(1)"

  end
end
