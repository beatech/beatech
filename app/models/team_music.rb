class TeamMusic < ActiveRecord::Base
  belongs_to :team_class
  has_many :team_scores
  has_many :users, through: :team_scores
end
