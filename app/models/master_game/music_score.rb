class MasterGame::MusicScore < ActiveRecord::Base
  belongs_to :user_score
  belongs_to :music
  has_one :master_game, through: :music

  validates :score, presence: true
  validates :deviation_value, presence: true
  validates :user_score_id, presence: true
  validates :music_id, presence: true
end
