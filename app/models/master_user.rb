class MasterUser < ActiveRecord::Base
  attr_accessible :account, :name
  
  def total_standard_score
    total = 0
    @master_games = MasterGame.all
    @master_games.each do |master_game|
      total += master_game.standard_score_by_account(self.account)
    end

    return total
  end

end
