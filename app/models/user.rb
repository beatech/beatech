class User < ActiveRecord::Base
  has_many :achievements
  has_many :twitter_accounts
end
