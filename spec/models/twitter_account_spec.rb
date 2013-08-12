require 'spec_helper'

describe TwitterAccount do
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validation" do
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:screen_name) }
    it { should validate_presence_of(:user_id) }
  end
end
