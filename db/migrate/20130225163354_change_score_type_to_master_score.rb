class ChangeScoreTypeToMasterScore < ActiveRecord::Migration
  def up
    change_column :master_scores, :score, :float
  end

  def down
    change_column :master_scores, :score, :integer
  end
end
