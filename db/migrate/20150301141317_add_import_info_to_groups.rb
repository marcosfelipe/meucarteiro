class AddImportInfoToGroups < ActiveRecord::Migration
  def change

    add_column :groups, "import_number_lines", :string
    add_column :groups, "import_status", :integer, default: 0


  end
end
