class Contest3rd < ActiveRecord::Base
  # attr_accessible :a_clear, :a_score, :b_clear, :b_score, :c_clear, :c_score, :movie_url, :music, :name, :order, :team, :difficulty
  validates :a_score, :presence => true
  validates :b_score, :presence => true
  validates :c_score, :presence => true
end
