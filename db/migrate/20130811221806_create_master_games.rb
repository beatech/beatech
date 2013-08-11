class CreateMasterGames < ActiveRecord::Migration
  def change
    create_table :master_games do |t|
      t.string :title
      t.string :tag
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
