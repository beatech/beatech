class AddIndexToContest3rds < ActiveRecord::Migration
  def change
    add_index :contest3rds, :team
  end
end
