require 'spec_helper'

describe TeamGame do
  describe "Associations" do
    it { should have_many(:team_classes) }
  end
end
