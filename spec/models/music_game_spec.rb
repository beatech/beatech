require 'spec_helper'

describe MusicGame do
  describe "Associations" do
    it { should have_many(:score_types) }
  end
end
