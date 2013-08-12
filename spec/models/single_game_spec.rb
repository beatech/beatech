require 'spec_helper'

describe SingleGame do
  describe "Associations" do
    it { should have_many(:musics) }
  end

  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:url) }
  end
end
