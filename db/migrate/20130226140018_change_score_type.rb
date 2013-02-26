class ChangeScoreType < ActiveRecord::Migration
  def up
    change_column :master_scores, :score, :decimal, :precision => 8, :scale => 2
  end

  def down
    change_column :master_scores, :score, :decimal
  end
end
