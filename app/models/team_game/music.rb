class TeamGame::Music < ActiveRecord::Base
  belongs_to :team
  belongs_to :match
end
