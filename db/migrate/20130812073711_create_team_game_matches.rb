class CreateTeamGameMatches < ActiveRecord::Migration
  def change
    create_table :team_game_matches do |t|
      t.integer :order
      t.string :place
      t.references :team_game, index: true

      t.timestamps
    end
  end
end
