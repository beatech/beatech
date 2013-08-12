require 'spec_helper'

describe TeamClass do
  describe 'Associations' do
    it { should belong_to(:team_game) }
    it { should have_many(:team_musics) }
    it { should have_many(:users).through(:team_musics) }
  end
end
