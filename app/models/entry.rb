class Entry < ActiveRecord::Base
  belongs_to :menu

  validates :title, presence: true
  validates :entry_type, presence: true
  validates :url, presence: true

  def updated_date
    @updated_date ||= self.updated_at.to_date
  end
end
