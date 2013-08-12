require 'spec_helper'

describe TeamScore do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:score_type) }
    it { should belong_to(:team_music) }
  end
end
