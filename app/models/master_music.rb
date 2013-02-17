class MasterMusic < ActiveRecord::Base
  attr_accessible :title, :game, :voter, :number, :author
  validates :title, :presence => true
end
