class CreateMusicGames < ActiveRecord::Migration
  def change
    create_table :music_games do |t|
      t.string :short_title
      t.string :long_title

      t.timestamps
    end
  end
end
