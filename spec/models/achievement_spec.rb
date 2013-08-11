require 'spec_helper'

describe Achievement do
  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
