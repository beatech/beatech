class TeamScore < ActiveRecord::Base
  belongs_to :team_class
  belongs_to :team_music
  belongs_to :score_type
end
