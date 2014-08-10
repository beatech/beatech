class Entry < ActiveRecord::Base
  belongs_to :menu

  validates :title, presence: true
  validates :entry_type, presence: true
  validates :url, presence: true
end
