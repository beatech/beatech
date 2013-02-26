class ChangeScoreTypeDecimalToMasterScore < ActiveRecord::Migration
  def up
    change_column :master_scores, :score, :decimal
  end

  def down
    change_column :master_scores, :score, :float
  end
end
