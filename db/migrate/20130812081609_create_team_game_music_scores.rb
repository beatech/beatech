class CreateTeamGameMusicScores < ActiveRecord::Migration
  def change
    create_table :team_game_music_scores do |t|
      t.string :score
      t.references :music, index: true
      t.references :user_score, index: true
      t.references :score_type, index: true

      t.timestamps
    end
  end
end
