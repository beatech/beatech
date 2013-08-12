require 'spec_helper'

describe MasterGame do
  describe "Associations" do
    it { should have_many(:musics) }
    it { should have_many(:music_scores).through(:musics) }
    it { should have_many(:user_scores).through(:music_scores) }
  end
  
  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:url) }
  end
end
