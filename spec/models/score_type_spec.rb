require 'spec_helper'

describe ScoreType do
  describe "Associations" do
    it { should belong_to(:music_game) }
  end

  describe "Validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:music_game_id) }
  end
end
