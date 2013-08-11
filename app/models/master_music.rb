class MasterMusic < ActiveRecord::Base
  belongs_to :music_game
  belongs_to :master_game
end
