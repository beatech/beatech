class CreateTeamClasses < ActiveRecord::Migration
  def change
    create_table :team_classes do |t|
      t.integer :order
      t.references :team_game, index: true

      t.timestamps
    end
  end
end
