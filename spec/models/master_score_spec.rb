require 'spec_helper'

describe MasterScore do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:master_music) }
    it { should have_one(:master_game).through(:master_music) }
  end
end
