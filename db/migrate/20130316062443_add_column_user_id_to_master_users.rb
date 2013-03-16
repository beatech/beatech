class AddColumnUserIdToMasterUsers < ActiveRecord::Migration
  def change
    add_column :master_users, :user_id, :integer
  end
end
