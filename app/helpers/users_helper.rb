module UsersHelper
  def label_for_grade(grade)
    case grade
    when 5 then "OB"
    when 0 then "新入生"
    else "#{grade}年生"
    end
  end
end
