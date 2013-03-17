class Achievement < ActiveRecord::Base
  attr_accessible :date, :text, :user_id
end
