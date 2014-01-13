class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :year, presence: true
  validates :repeated_year, presence: true
  before_save :set_grade

  DEFAULT_PROFILE_IMAGE_COUNT = 7

  def self.year_by_grade(grade, repeated_year = 0)
    if (1..3).include?(Date.today.month)
      Date.today.year - grade - repeated_year
    else
      Date.today.year - grade - repeated_year - 1
    end
  end

  def self.grade_by_year(year, repeated_year = 0)
    Date.today.year - self.year_by_grade(0)
  end

  def self.authenticate(username, password)
    user = User.where(username: username).first
    if user.present? && correct_password?(user, password)
      user
    else
      nil
    end
  end

  def big_icon_url
    normal_icon_url.gsub(/normal(.*)$/, 'bigger\1')
  end

  def normal_icon_url
    if self.icon_url.present?
      self.icon_url
    else
      normal_default_icon_url
    end
  end

  def to_param
    username
  end

  private

  def self.correct_password?(user, password)
    BCrypt::Password.new(user.password_digest) == password
  end

  def normal_default_icon_url
    random_number = self.id % DEFAULT_PROFILE_IMAGE_COUNT
    "https://si0.twimg.com/sticky/default_profile_images/"\
      "default_profile_#{random_number}_normal.png"
  end

  def set_grade
    self.repeated_year = 0
    self.grade =
      if (1..3).include?(Date.today.month)
        Date.today.year - self.year
      else
        Date.today.year - self.year + 1
      end
  end
end
