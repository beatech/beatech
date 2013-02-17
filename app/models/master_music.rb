class MasterMusic < ActiveRecord::Base
  attr_accessible :title, :game, :voter, :number, :author, :url
  validates :title, :presence => true
end
