class RemoveImportInfoFromGroups < ActiveRecord::Migration
  def change

    remove_columns :groups, :import_number_lines, :import_status

  end
end
