class MasterGame::MusicScore < ActiveRecord::Base
  belongs_to :user_score
  belongs_to :music
end
