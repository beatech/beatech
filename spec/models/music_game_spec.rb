require 'spec_helper'

describe MusicGame do
  describe "Associations" do
    it { should have_many(:score_types) }
  end

  describe "Validation" do
    it { should validate_presence_of(:short_title) }
    it { should validate_presence_of(:long_title) }
  end
end
