class CreateImportInfos < ActiveRecord::Migration
  def change
    create_table :import_infos do |t|
      t.references :import, index: true
      t.string :message

      t.timestamps null: false
    end
  end
end
