require 'spec_helper'

describe TeamGame::Match do
  describe 'Associations' do
    it { should belong_to(:team_game) }
    it { should have_many(:musics) }
    it { should have_many(:user_scores) }
  end
end
