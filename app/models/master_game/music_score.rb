class MasterGame::MusicScore < ActiveRecord::Base
  belongs_to :user_score
  belongs_to :music
  has_one :master_game, through: :music
end
