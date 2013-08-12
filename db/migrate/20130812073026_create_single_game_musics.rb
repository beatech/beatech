class CreateSingleGameMusics < ActiveRecord::Migration
  def change
    create_table :single_game_musics do |t|
      t.string :title
      t.string :difficulty
      t.string :tag
      t.references :single_game, index: true
      t.references :score_type, index: true

      t.timestamps
    end
  end
end
