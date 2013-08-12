class TeamGame::Team < ActiveRecord::Base
  belongs_to :team_game
  has_many :musics
  has_many :user_scores

  validates :name, presence: true
  validates :team_game_id, presence: true
  validates :rank, presence: true
  validates :score, presence: true
end
