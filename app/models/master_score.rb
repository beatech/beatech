class MasterScore < ActiveRecord::Base
  attr_accessible :account, :game, :score, :url, :user_id
  validates :score, :presence => true

  def music_title
    @master_game = MasterGame.find(self.game)
    return @master_game.music_title
  end

  def game_title
    @master_game = MasterGame.find(self.game)
    return @master_game.title
  end
end
