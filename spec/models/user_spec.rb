require 'spec_helper'

describe User do
  describe 'Associations' do
    it { should have_many(:achievements) }
    it { should have_many(:twitter_accounts) }
  end

  describe 'Validation' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:repeated_year) }
  end
end
