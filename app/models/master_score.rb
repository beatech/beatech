class MasterScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_music
end
