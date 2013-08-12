class MasterGame < ActiveRecord::Base
  has_many :musics, class_name: "MasterGame::Music"
  has_many :music_scores, through: :musics
  has_many :user_scores, through: :music_scores

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :url, presence: true
end
