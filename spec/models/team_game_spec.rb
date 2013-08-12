require 'spec_helper'

describe TeamGame do
  describe "Associations" do
    it { should have_many(:teams) }
    it { should have_many(:matches) }
  end

  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end
end
