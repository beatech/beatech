class AddUserIdToTeamScores < ActiveRecord::Migration
  def change
    add_reference :team_scores, :user, index: true
  end
end
