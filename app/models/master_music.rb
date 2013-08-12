class MasterMusic < ActiveRecord::Base
  belongs_to :music_game
  belongs_to :master_game
  has_many :master_scores
  has_many :users, through: :master_scores
end
