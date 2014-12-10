class Menu < ActiveRecord::Base
  has_many :entries

  scope :for_side, -> { where(section: 'side') }
  scope :for_header, -> { where(section: 'header') }

  default_scope { order(position: :asc) }
end
