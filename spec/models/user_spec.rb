require 'spec_helper'

describe User do
  describe "Associations" do
    it { should have_many(:achievements) }
    it { should have_many(:twitter_accounts) }
    it { should have_many(:master_scores) }
    it { should have_many(:master_musics).through(:master_scores) }
    it { should have_many(:master_games).through(:master_musics) }
  end
end
