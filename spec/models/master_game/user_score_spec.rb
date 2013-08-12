require 'spec_helper'

describe MasterGame::UserScore do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:music_scores) }
  end

  describe "Validation" do
    it { should validate_presence_of(:score) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:rank) }
  end
end
