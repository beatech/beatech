class CreateMasterGameUserScores < ActiveRecord::Migration
  def change
    create_table :master_game_user_scores do |t|
      t.string :score
      t.references :user, index: true
      t.date :end_date
      t.integer :rank

      t.timestamps
    end
  end
end
