class AddStandardScoreToMasterScore < ActiveRecord::Migration
  def change
    add_column :master_scores, :standard_score, :float
  end
end
