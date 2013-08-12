class TeamGame::UserScore < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
  belongs_to :user
  has_one :team_game, through: :team
  has_many :music_scores

  validates :score, presence: true
  validates :team_id, presence: true
  validates :match_id, presence: true
  validates :user_id, presence: true
  validates :rank, presence: true
  validates :end_date, presence: true
  validates :url, presence: true
end
