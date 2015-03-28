class AddLanguageToUser < ActiveRecord::Migration
  def change
    add_reference :users, :language, index: true, default: 1
    add_foreign_key :users, :languages


  end
end
