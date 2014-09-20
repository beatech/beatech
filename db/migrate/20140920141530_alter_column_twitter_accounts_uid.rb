class AlterColumnTwitterAccountsUid < ActiveRecord::Migration
  def up
    change_column :twitter_accounts, :uid, :decimal
  end

  def down
    change_column :twitter_accounts, :uid, :integer
  end
end
