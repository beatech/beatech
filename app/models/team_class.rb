class TeamClass < ActiveRecord::Base
  belongs_to :team_game
  has_many :team_musics
  has_many :users, through: :team_musics
end
