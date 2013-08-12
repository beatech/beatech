class MasterGame::UserScore < ActiveRecord::Base
  belongs_to :user
  has_many :music_scores
end
