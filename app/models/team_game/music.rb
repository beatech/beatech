class TeamGame::Music < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  has_many :music_scores
  has_many :user_scores, through: :music_scores

  validates :title, presence: true
  validates :team_id, presence: true
  validates :match_id, presence: true
end
