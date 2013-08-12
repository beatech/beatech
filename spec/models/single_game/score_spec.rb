require 'spec_helper'

describe SingleGame::Score do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:music) }
    it { should have_one(:single_game) }
  end

  describe "Validation" do
    it { should validate_presence_of(:score) }
    it { should validate_presence_of(:rank) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:music_id) }
  end
end
