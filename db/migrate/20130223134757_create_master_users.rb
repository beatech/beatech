class CreateMasterUsers < ActiveRecord::Migration
  def change
    create_table :master_users do |t|
      t.string :name
      t.string :account

      t.timestamps
    end
  end
end
