module AchievementsHelper
  def pop_latest_date_achievements(achievements)
    latest_date = achievements.first.date
    latest_date_achievements = Array.new
    rest_achievements = Array.new
    achievements.each do |achievement|
      if achievement.date == latest_date
        latest_date_achievements << achievement
      else
        rest_achievements << achievement
      end
    end
    [latest_date, latest_date_achievements, rest_achievements]
  end
  
  def achievement_text(achievement)
    achievement.text
  end
end
