class TeamGame::MusicScore < ActiveRecord::Base
  belongs_to :music
  belongs_to :user_score  
  belongs_to :score_type
end
