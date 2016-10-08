class Achievement < ActiveRecord::Base
  paginates_per 20

  belongs_to :user

  validates :date, presence: true
  validates :text, presence: true
  validates :user_id, presence: true

  def self.latest_twitter_status_id
    self.where.not(:twitter_status_id => nil).order(:twitter_status_id => 'desc').first.twitter_status_id
  end
end
