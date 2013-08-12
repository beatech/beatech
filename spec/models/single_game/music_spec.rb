require 'spec_helper'

describe SingleGame::Music do
  describe 'Association' do
    it { should belong_to(:single_game) }
    it { should belong_to(:score_type) }
    it { should have_many(:scores) }
    it { should have_many(:users).through(:scores) }
  end
end
