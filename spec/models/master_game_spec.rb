require 'spec_helper'

describe MasterGame do
  describe 'Associations' do
    it { should have_many(:musics) }
    it { should have_many(:music_scores).through(:musics) }
    it { should have_many(:user_scores).through(:music_scores) }
  end
end
