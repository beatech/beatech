class CreateMasterScores < ActiveRecord::Migration
  def change
    create_table :master_scores do |t|
      t.references :user, index: true
      t.references :master_music, index: true
      t.string :score

      t.timestamps
    end
  end
end
