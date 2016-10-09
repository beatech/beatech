class ChangeTwitterAccountsUidTypeToString < ActiveRecord::Migration
  def change
    change_column :twitter_accounts, :uid, :string
  end
end
