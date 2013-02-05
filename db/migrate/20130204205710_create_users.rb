class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :name
      t.string :password_digest
      t.integer :uid
      t.integer :year
      t.integer :state
      t.string :profile

      t.timestamps
    end
  end
end
