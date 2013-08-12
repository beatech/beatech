require 'spec_helper'

describe MasterGame::MusicScore do
  describe "Associations" do
    it { should belong_to(:music) }
    it { should belong_to(:user_score) }
    it { should have_one(:master_game).through(:music) }
  end

  describe "Validation" do
    it { should validate_presence_of(:score) }
    it { should validate_presence_of(:deviation_value) }
    it { should validate_presence_of(:user_score_id) }
    it { should validate_presence_of(:music_id) }
  end
end
