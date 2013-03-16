class MasterMusic < ActiveRecord::Base
  attr_accessible :title, :game, :voter, :number, :author, :url, :user_id
  validates :title, :presence => true
  
  def account
    @user = User.find(user_id)
    @user.account if @user
  end
end
