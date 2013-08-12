class MasterGame::UserScore < ActiveRecord::Base
  belongs_to :user
end
