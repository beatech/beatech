class RemoveTeamClassIdFromTeamScores < ActiveRecord::Migration
  def change
    remove_reference :team_scores, :team_class, index: true
  end
end
