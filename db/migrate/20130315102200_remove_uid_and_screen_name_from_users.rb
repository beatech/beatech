class RemoveUidAndScreenNameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :screen_name
    remove_column :users, :uid
  end

  def down
    add_column :users, :screen_name, :string
    add_column :users, :uid, :string
  end
end
