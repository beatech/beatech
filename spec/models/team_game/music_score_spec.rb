require 'spec_helper'

describe TeamGame::MusicScore do
  describe "Associations" do
    it { should belong_to(:music) }
    it { should belong_to(:user_score) }
    it { should belong_to(:score_type) }
  end

  describe "Validation" do
    it { should validate_presence_of(:score) }
    it { should validate_presence_of(:music_id) }
    it { should validate_presence_of(:user_score_id) }
    it { should validate_presence_of(:score_type_id) }
  end
end
