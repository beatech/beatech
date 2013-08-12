class MasterGame::Music < ActiveRecord::Base
  belongs_to :music_game
  belongs_to :score_type
  belongs_to :master_game
end
