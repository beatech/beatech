require 'spec_helper'

describe TeamGame::Music do
  describe 'Associations' do
    it { should belong_to(:team) }
    it { should belong_to(:match) }
    it { should have_many(:music_scores) }
    it { should have_many(:user_scores).through(:music_scores) }
  end
end
