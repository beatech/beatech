require 'spec_helper'

describe MasterGame::UserScore do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:music_scores) }
  end
end
