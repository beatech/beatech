class AddColumnUserIdToMasterScores < ActiveRecord::Migration
  def change
    add_column :master_scores, :user_id, :integer
  end
end
