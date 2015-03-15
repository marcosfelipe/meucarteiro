class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer :contacts_count, default: 0
      t.integer :progress, default: 0
      t.integer :status, default: 0
      t.references :user, index: true

      t.timestamps null: false
    end

  end
end
