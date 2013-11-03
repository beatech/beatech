class Contest3rd < ActiveRecord::Base
  validates :a_score, presence: true
  validates :b_score, presence: true
  validates :c_score, presence: true

  def total=(total)
    @total = total
  end

  def total
    @total
  end
end
