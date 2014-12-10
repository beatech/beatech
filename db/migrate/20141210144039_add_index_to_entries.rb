class AddIndexToEntries < ActiveRecord::Migration
  def change
    add_index :entries, :menu_id
  end
end
