class User < ActiveRecord::Base
  has_many :achievements
  has_many :twitter_accounts

  validates :username, presence: true
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :year, presence: true
  validates :repeated_year, presence: true
end
