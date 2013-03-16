class TwitterAccount < ActiveRecord::Base
  attr_accessible :screen_name, :uid, :user_id, :account

  def self.exist?(screen_name)
    @twitter_account = self.find_by_screen_name(screen_name)
    if @twitter_account
      true
    else
      false
    end
  end
=begin
  def account
    @user = User.find(user_id)
    @user.account if @user
  end
=end
end
