require 'spec_helper'

describe MasterGame do
  describe "Associations" do
    it { should have_many(:master_musics) }
    it { should have_many(:users).through(:master_musics) }
  end
end
