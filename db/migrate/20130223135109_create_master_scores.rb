class CreateMasterScores < ActiveRecord::Migration
  def change
    create_table :master_scores do |t|
      t.string :account
      t.integer :game
      t.integer :score

      t.timestamps
    end
  end
end
