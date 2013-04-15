class Contest2nd < ActiveRecord::Base
  attr_accessible :a_bp, :a_score, :b_bp, :b_score, :c_bp, :c_score,
  :music, :name, :notes, :order, :team, :url
end
