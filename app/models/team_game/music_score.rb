class TeamGame::MusicScore < ActiveRecord::Base
  belongs_to :music
  belongs_to :user_score  
  belongs_to :score_type

  validates :score, presence: true
  validates :music_id, presence: true
  validates :user_score_id, presence: true
  validates :score_type_id, presence: true
end
