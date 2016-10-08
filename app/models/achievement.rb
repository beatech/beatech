class Achievement < ActiveRecord::Base
  paginates_per 20

  belongs_to :user

  validates :date, presence: true
  validates :text, presence: true
  validates :user_id, presence: true

  def self.latest_twitter_status_id
    Achievement.maximum(:twitter_status_id)
  end
end
