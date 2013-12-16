class TwitterAccount < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: true
  validates :screen_name, presence: true
  validates :user_id, presence: true

  def self.exist?(screen_name)
    TwitterAccount.where(screen_name: screen_name).present?
  end
end
