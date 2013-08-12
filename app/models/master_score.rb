class MasterScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_music
  has_one :master_game, through: :master_music
end
