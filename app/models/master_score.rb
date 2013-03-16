class MasterScore < ActiveRecord::Base
  attr_accessible :game, :score, :url, :user_id
  validates :score, :presence => true

  def music_title
    @master_game = MasterGame.find(self.game)
    return @master_game.music_title
  end

  def game_title
    @master_game = MasterGame.find(self.game)
    return @master_game.title
  end

  def account
    @user = User.find(user_id)
    @user.account if @user
  end

  def self.find_by_account(account)
    @user = User.find_by_account(account)
    self.find_by_user_id(@user.id)
  end

  def self.find_all_by_account(account)
    @user = User.find_by_account(account)
    @master_scores = self.find(:all, :conditions => {:user_id => @user.id})
  end

  def self.find_by_account_and_game(account, game)
    @user = User.find_by_account(account)
    MasterScore.where(:user_id => @user.id, :game => game).first
  end
end
