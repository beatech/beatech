class Achievement < ActiveRecord::Base
  attr_accessible :date, :text, :user_id

  def name
    @user = User.find_by_id(self.user_id)
    @user.name if @user
  end
end
