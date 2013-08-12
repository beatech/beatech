require 'spec_helper'

describe TeamGame::MusicScore do
  describe 'Associations' do
    it { should belong_to(:music) }
    it { should belong_to(:user_score) }
    it { should belong_to(:score_type) }
  end
end
