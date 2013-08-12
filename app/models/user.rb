class User < ActiveRecord::Base
  has_many :achievements
  has_many :twitter_accounts
  has_many :master_scores
  has_many :master_musics, through: :master_scores
  has_many :master_games, through: :master_musics
end
