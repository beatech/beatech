class CreateSingleGames < ActiveRecord::Migration
  def change
    create_table :single_games do |t|
      t.string :title
      t.string :tag
      t.date :start_date
      t.date :end_date
      t.string :url

      t.timestamps
    end
  end
end
