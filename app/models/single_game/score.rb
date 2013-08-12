class SingleGame::Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :music
  has_one :single_game, through: :music
end
