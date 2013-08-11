class CreateScoreTypes < ActiveRecord::Migration
  def change
    create_table :score_types do |t|
      t.string :name
      t.integer :type
      t.references :music_game, index: true

      t.timestamps
    end
  end
end
