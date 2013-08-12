require 'spec_helper'

describe SingleGame do
  describe 'Associations' do
    it { should have_many(:musics) }
  end
end
