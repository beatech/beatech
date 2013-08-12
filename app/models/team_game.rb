class TeamGame < ActiveRecord::Base
  has_many :teams, class_name: "TeamGame::Team"
  has_many :matches, class_name: "TeamGame::Match"
end
