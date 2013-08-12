class MusicGame < ActiveRecord::Base
  has_many :score_types

  validates :short_title, presence: true
  validates :long_title, presence: true
end
