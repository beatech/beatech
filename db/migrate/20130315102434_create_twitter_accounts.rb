class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :account
      t.integer :uid
      t.string :screen_name

      t.timestamps
    end
  end
end
