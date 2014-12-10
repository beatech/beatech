class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :updated_at
  end
end
