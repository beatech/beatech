# coding: utf-8
module UsersHelper
  DEFAULT_ICON = "https://si0.twimg.com/sticky/default_profile_images/default_profile_0_bigger.png"

  def grade_with(year, repeated_year)
    this_year = Time.now.year
    this_year -= 1 if Time.now.month < 4
    (this_year + 1) - (year.to_i + repeated_year.to_i)
  end

  def grade_label(grade)
    case grade
    when 0 then "新入生"
    when 5 then "OB"
    else "#{grade}年生"
    end
  end

  def big_profile_image(user)
    if user.profile_image
      if user.profile_image =~ /.*normal.*/
        user.profile_image.gsub(/normal/, "bigger")
      else
        user.profile_image
      end
    else
      DEFAULT_ICON
    end
  end

  def screen_name_link(screen_name)
    link_to "@#{screen_name}", "https://twitter.com/#{screen_name}"
  end

  def welcome_term?
    [2, 3].include?(Time.now.month)
  end
end
