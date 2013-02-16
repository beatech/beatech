class MasterMusic < ActiveRecord::Base
  attr_accessible :title, :game, :voter, :number
  validates :title, :presence => true
end
