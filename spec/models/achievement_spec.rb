require 'spec_helper'

describe Achievement do
  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validation" do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:text) }
    it { should validate_presence_of(:user_id) }
  end
end
