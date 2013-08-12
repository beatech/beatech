require 'spec_helper'

describe TeamGame::UserScore do
  it { should belong_to(:team) }
  it { should belong_to(:match) }
  it { should belong_to(:user) }
  it { should have_one(:team_game).through(:team) }
  it { should have_many(:music_scores) }
end
