require 'spec_helper'

describe MasterGame::MusicScore do
  describe 'Associations' do
    it { should belong_to(:music) }
    it { should belong_to(:user_score) }
    it { should have_one(:master_game).through(:music) }
  end
end
