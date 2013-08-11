class CreateTeamScores < ActiveRecord::Migration
  def change
    create_table :team_scores do |t|
      t.references :team_class, index: true
      t.references :team_music, index: true
      t.string :score
      t.references :score_type, index: true

      t.timestamps
    end
  end
end
