class AddColumnUserIdToContest2nds < ActiveRecord::Migration
  def change
    add_column :contest2nds, :user_id, :integer
  end
end
