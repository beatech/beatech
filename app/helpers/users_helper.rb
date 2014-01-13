module UsersHelper
  def label_for_grade(grade)
    case grade
    when 5 then "OB"
    when 0 then "新入生"
    else "#{grade}年生"
    end
  end

  def grade_choices
    acceptable_grades.map do |grade|
      entrance_year = User.year_by_grade(grade)
      ["#{label_for_grade(grade)} (#{entrance_year}年入学)", entrance_year]
    end
  end

  def acceptable_grades
    if (1..3).include?(Date.today.month)
      (0..4)
    else
      (1..4)
    end
  end
end
