class MasterGame < ActiveRecord::Base
  attr_accessible :title, :voter, :top
  validates :title, :presence => true
end
