require 'spec_helper'

describe SingleGame::Score do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:music) }
    it { should have_one(:single_game) }
  end
end
