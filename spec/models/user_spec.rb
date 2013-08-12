require 'spec_helper'

describe User do
  describe "Associations" do
    it { should have_many(:achievements) }
    it { should have_many(:twitter_accounts) }
  end
end
