class SingleGame < ActiveRecord::Base
  has_many :musics, class_name: "SingleGame::Music"

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :url, presence: true
end
