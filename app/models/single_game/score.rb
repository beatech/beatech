class SingleGame::Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :music
  has_one :single_game, through: :music

  validates :score, presence: true
  validates :rank, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :music_id, presence: true
end
