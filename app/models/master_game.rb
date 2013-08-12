class MasterGame < ActiveRecord::Base
  has_many :master_musics
  has_many :users, through: :master_musics
end
