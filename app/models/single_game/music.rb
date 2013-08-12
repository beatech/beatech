class SingleGame::Music < ActiveRecord::Base
  belongs_to :single_game
  belongs_to :score_type
  has_many :scores
  has_many :users, through: :scores

  validates :title, presence: true
  validates :difficulty, presence: true
  validates :single_game_id, presence: true
  validates :score_type_id, presence: true
end
