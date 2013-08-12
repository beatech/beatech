require 'spec_helper'

describe MasterMusic do
  describe "Associations" do    
    it { should belong_to(:music_game) }
    it { should belong_to(:master_game) }
    it { should belong_to(:score_type) }
    it { should have_many(:master_scores) }
    it { should have_many(:users).through(:master_scores) }
  end
end
