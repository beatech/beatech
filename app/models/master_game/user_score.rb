class MasterGame::UserScore < ActiveRecord::Base
  belongs_to :user
  has_many :music_scores

  validates :score, presence: true
  validates :user_id, presence: true
  validates :end_date, presence: true
  validates :rank, presence: true
end
