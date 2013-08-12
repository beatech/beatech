class SingleGame::Music < ActiveRecord::Base
  belongs_to :single_game
  belongs_to :score_type
end
