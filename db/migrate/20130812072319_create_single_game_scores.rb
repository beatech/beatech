class CreateSingleGameScores < ActiveRecord::Migration
  def change
    create_table :single_game_scores do |t|
      t.string :score
      t.integer :rank
      t.date :end_date
      t.references :user, index: true
      t.references :music, index: true

      t.timestamps
    end
  end
end
