require 'spec_helper'

describe TwitterAccount do
  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
