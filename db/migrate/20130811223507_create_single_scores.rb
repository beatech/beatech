class CreateSingleScores < ActiveRecord::Migration
  def change
    create_table :single_scores do |t|
      t.string :score
      t.references :user, index: true
      t.references :single_music, index: true

      t.timestamps
    end
  end
end
