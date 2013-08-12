require 'spec_helper'

describe TeamMusic do
  describe 'Associations' do
    it { should belong_to(:team_class) }
    it { should have_many(:team_scores) }
    it { should have_many(:users).through(:team_scores) }    
  end
end
