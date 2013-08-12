require 'spec_helper'

describe TeamGame::UserScore do
  describe "Associations" do
    it { should belong_to(:team) }
    it { should belong_to(:match) }
    it { should belong_to(:user) }
    it { should have_one(:team_game).through(:team) }
    it { should have_many(:music_scores) }
  end
  
  describe "Validation" do
    it { should validate_presence_of(:score) }
    it { should validate_presence_of(:team_id) }
    it { should validate_presence_of(:match_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:rank) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:url) }
  end
end
