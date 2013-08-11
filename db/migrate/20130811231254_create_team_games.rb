class CreateTeamGames < ActiveRecord::Migration
  def change
    create_table :team_games do |t|
      t.string :title
      t.string :tag
      t.integer :team_num
      t.date :start_date
      t.date :end_date
      t.integer :type

      t.timestamps
    end
  end
end
