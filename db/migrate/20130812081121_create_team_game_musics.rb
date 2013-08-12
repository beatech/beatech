class CreateTeamGameMusics < ActiveRecord::Migration
  def change
    create_table :team_game_musics do |t|
      t.string :title
      t.string :difficulty
      t.integer :notes
      t.references :team, index: true
      t.references :match, index: true

      t.timestamps
    end
  end
end
