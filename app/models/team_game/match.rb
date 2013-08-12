class TeamGame::Match < ActiveRecord::Base
  belongs_to :team_game
  has_many :musics
  has_many :user_scores
end
