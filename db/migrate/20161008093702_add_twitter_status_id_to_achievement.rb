class AddTwitterStatusIdToAchievement < ActiveRecord::Migration
  def change
    add_column :achievements, :twitter_status_id, :string
  end
end
