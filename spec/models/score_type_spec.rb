require 'spec_helper'

describe ScoreType do
  describe 'Associations' do
    it { should belong_to(:music_game) }
  end
end
