class TwitterAccount < ActiveRecord::Base
  attr_accessible :account, :screen_name, :uid

  def self.exist?(screen_name)
    @twitter_account = self.find_by_screen_name(screen_name)
    if @twitter_account
      true
    else
      false
    end
  end
end
