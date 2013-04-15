class MasterUser < ActiveRecord::Base
  attr_accessible :name, :user_id

  def total_standard_score
    total = 0
    @master_scores = MasterScore.find_all_by_account(self.account)
    @master_scores.each do |master_score|
      total += master_score.standard_score
    end

    return total
  end

  def account
    @user = User.find(user_id)
    @user.account if @user
  end

  def self.find_by_account(account)
    @user = User.find_by_account(account)
    self.find_by_user_id(@user.id)
  end
end
