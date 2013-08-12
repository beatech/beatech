class TeamGame::Match < ActiveRecord::Base
  belongs_to :team_game
  has_many :musics
  has_many :user_scores

  validates :order, presence: true
  validates :place, presence: true
  validates :team_game_id, presence: true
end
