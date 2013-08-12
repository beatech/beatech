class TeamGame < ActiveRecord::Base
  has_many :teams, class_name: "TeamGame::Team"
  has_many :matches, class_name: "TeamGame::Match"

  validates :title, presence: true
  validates :url, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
