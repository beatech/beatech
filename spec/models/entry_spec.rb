require 'spec_helper'

describe Entry do
  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:menu) }
    it { should validate_presence_of(:entry_type) }
  end
end
