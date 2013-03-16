class AddColumnUserIdFromTwitterAccounts < ActiveRecord::Migration
  def change
    add_column :twitter_accounts, :user_id, :integer
  end
end
