class CreateMasterMusics < ActiveRecord::Migration
  def change
    create_table :master_musics do |t|
      t.string :title
      t.integer :game
      t.string :voter
      t.integer :number

      t.timestamps
    end
  end
end
