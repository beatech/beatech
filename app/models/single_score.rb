class SingleScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :single_music
end
