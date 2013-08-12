require 'spec_helper'

describe TeamGame::Team do
  describe "Associations" do
    it { should belong_to(:team_game) }
    it { should have_many(:musics) }
    it { should have_many(:user_scores) }
  end

  describe "Validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:team_game_id) }
    it { should validate_presence_of(:rank) }
    it { should validate_presence_of(:score) }
  end
end
