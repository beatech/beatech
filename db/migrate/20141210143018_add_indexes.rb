class AddIndexes < ActiveRecord::Migration
  def change
    add_index :menus, :section
    add_index :entries, :url
  end
end
