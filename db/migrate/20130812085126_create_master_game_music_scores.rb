class CreateMasterGameMusicScores < ActiveRecord::Migration
  def change
    create_table :master_game_music_scores do |t|
      t.string :score
      t.string :deviation_value
      t.references :user_score, index: true
      t.references :music, index: true

      t.timestamps
    end
  end
end
