class MasterUser < ActiveRecord::Base
  attr_accessible :account, :name, :user_id
  
  def total_standard_score
    total = 0
=begin    
    @master_games = MasterGame.all
    @master_games.each do |master_game|
      total += master_game.standard_score_by_account(self.account)
    end
=end
    @master_scores = MasterScore.find(:all, :conditions => {:account => self.account})
    @master_scores.each do |master_score|
      total += master_score.standard_score
    end
    
    return total
  end

end
