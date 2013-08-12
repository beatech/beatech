require 'spec_helper'

describe SingleGame::Music do
  describe "Association" do
    it { should belong_to(:single_game) }
    it { should belong_to(:score_type) }
    it { should have_many(:scores) }
    it { should have_many(:users).through(:scores) }
  end

  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:difficulty) }
    it { should validate_presence_of(:single_game_id) }
    it { should validate_presence_of(:score_type_id) }
  end
end
