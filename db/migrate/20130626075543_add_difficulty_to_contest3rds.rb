class AddDifficultyToContest3rds < ActiveRecord::Migration
  def change
    add_column :contest3rds, :difficulty, :integer
  end
end
