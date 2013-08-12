class SingleGame < ActiveRecord::Base
  has_many :musics, class_name: "SingleGame::Music"
end
