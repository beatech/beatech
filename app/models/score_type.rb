class ScoreType < ActiveRecord::Base
  belongs_to :music_game

  validates :name, presence: true
  validates :type, presence: true
  validates :music_game_id, presence: true
end
