class CreateTeamMusics < ActiveRecord::Migration
  def change
    create_table :team_musics do |t|
      t.references :team_class, index: true
      t.integer :team
      t.string :title
      t.string :difficulty
      t.integer :notes

      t.timestamps
    end
  end
end
