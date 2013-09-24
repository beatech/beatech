class User < ActiveRecord::Base
  # has_secure_password
  
  has_many :achievements
  has_many :twitter_accounts

  validates :username, presence: true
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :year, presence: true
  validates :repeated_year, presence: true

  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_digest.present? &&
        BCrypt::Password.new(user.password_digest) == password      
      user
    else
      nil
    end
  end
end
