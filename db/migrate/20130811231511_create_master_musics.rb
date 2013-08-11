class CreateMasterMusics < ActiveRecord::Migration
  def change
    create_table :master_musics do |t|
      t.string :title
      t.string :tag
      t.integer :notes
      t.references :music_game, index: true
      t.references :master_game, index: true

      t.timestamps
    end
  end
end
