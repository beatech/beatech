class CreateMasterGameMusics < ActiveRecord::Migration
  def change
    create_table :master_game_musics do |t|
      t.string :title
      t.references :score_type, index: true
      t.references :master_game, index: true

      t.timestamps
    end
  end
end
