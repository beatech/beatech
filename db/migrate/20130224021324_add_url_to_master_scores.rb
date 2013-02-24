class AddUrlToMasterScores < ActiveRecord::Migration
  def change
    add_column :master_scores, :url, :string
  end
end
