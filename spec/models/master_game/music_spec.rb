require 'spec_helper'

describe MasterGame::Music do
  describe "Associations" do
    it { should belong_to(:master_game) }
    it { should belong_to(:score_type) }
    it { should have_one(:music_game).through(:score_type) }
    it { should have_many(:music_scores) }
    it { should have_many(:user_scores).through(:music_scores) }
  end

  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:score_type_id) }
    it { should validate_presence_of(:master_game_id) }
  end
end
