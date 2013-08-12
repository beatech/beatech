class CreateTeamGameTeams < ActiveRecord::Migration
  def change
    create_table :team_game_teams do |t|
      t.string :name
      t.references :team_game, index: true
      t.integer :rank
      t.integer :score

      t.timestamps
    end
  end
end
