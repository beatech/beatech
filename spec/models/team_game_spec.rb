require 'spec_helper'

describe TeamGame do
  describe 'Associations' do
    it { should have_many(:teams) }
    it { should have_many(:matches) }
  end
end
