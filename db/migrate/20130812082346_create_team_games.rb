class CreateTeamGames < ActiveRecord::Migration
  def change
    create_table :team_games do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.string :url

      t.timestamps
    end
  end
end
