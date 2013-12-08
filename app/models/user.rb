class User < ActiveRecord::Base
  has_secure_password

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

  def self.update_profile_images
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Beatech::CONSUMER_KEY
      config.consumer_secret = Beatech::CONSUMER_SECRET
      config.access_token = Beatech::ACCESS_TOKEN
      config.access_token_secret = Beatech::ACCESS_TOKEN_SECRET
    end

    User.all.each do |user|
      twitter_account = user.twitter_accounts.first
      if twitter_account.present?
        print "#{user.name}: "
        begin
          profile_image_url = client.user(twitter_account.uid).profile_image_url
          user.profile_image = profile_image_url.to_s if profile_image_url.present?
          user.save
          puts 'success'
        rescue
          puts 'something wrong happend.'
        end
        sleep(3)
      end
    end
  end

  def to_param
    username
  end
end
