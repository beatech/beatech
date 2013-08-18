class Achievement < ActiveRecord::Base
  paginates_per 20
  
  belongs_to :user
  
  validates :date, presence: true
  validates :text, presence: true
  validates :user_id, presence: true
end
