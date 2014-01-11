class User < ActiveRecord::Base
  has_secure_password
  before_save :set_grade

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

  private

  def normal_default_icon_url
    random_number = self.id % 7
    "https://si0.twimg.com/sticky/default_profile_images/"\
      "default_profile_#{random_number}_normal.png"
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
