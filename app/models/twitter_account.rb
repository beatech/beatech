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

  def account
    @user = User.find(user_id)
    @user.account if @user
  end

  def self.find_all_by_account(account)
    @user = User.find_by_account(account)
    @master_scores = self.find(:all, :conditions => {:user_id => @user.id})
  end

end
