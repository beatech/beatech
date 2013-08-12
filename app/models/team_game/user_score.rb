class TeamGame::UserScore < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  belongs_to :user
  has_one :team_game, through: :team
  has_many :music_scores
end
