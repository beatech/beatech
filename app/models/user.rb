class User < ActiveRecord::Base
  ADMIN_USERNAMES = %w|ikstrm popkirby norimiso|
  GRADE_NEWCOMER = 0
  GRADE_OB = 5

  has_secure_password

  has_many :achievements
  has_many :twitter_accounts
  has_many :blogs

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :year, presence: true
  validates :repeated_year, presence: true

  before_save :set_grade

  delegate :to_param, to: :username

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
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end

    ActiveRecord::Base.record_timestamps = false
    User.all.each do |user|
      twitter_account = user.twitter_accounts.first
      if twitter_account.present?
        print "#{user.name}: "
        begin
          profile_image_url = client.user(twitter_account.uid).profile_image_url
          user.profile_image = profile_image_url.to_s if profile_image_url.present?
          user.save
          puts 'success'
        rescue => e
          puts 'Error!'
          puts e
        end
        sleep(3)
      end
    end
    ActiveRecord::Base.record_timestamps = true
  end

  def is_admin?
    ADMIN_USERNAMES.any? { |admin_username| self.username == admin_username }
  end

  def set_grade
    self.grade =
      if (1..3).include?(Date.today.month)
        Date.today.year - self.year
      else
        Date.today.year - self.year + 1
      end
  end
end
