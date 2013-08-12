class CreateTeamGameUserScores < ActiveRecord::Migration
  def change
    create_table :team_game_user_scores do |t|
      t.integer :score
      t.references :team, index: true
      t.references :match, index: true
      t.integer :rank
      t.date :end_date
      t.string :url
      t.references :user, index: true

      t.timestamps
    end
  end
end
