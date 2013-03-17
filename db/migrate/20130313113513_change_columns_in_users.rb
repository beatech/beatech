class ChangeColumnsInUsers < ActiveRecord::Migration
  def up
    change_column :users, :uid, :string
    add_column :users, :repeat_year, :integer
    remove_column :users, :state
    remove_column :users, :profile
    add_column :users, :short_profile, :text
    add_column :users, :long_profile, :text
    add_column :users, :profile_image, :text
  end

  def down
    change_column :users, :uid, :integer
    remove_column :users, :repeat_year
    add_column :users, :state, :integer
    add_column :users, :profile, :string
    remove_column :users, :short_profile
    remove_column :users, :long_profile
    remove_column :users, :profile_image
  end
end
