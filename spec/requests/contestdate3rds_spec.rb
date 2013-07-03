require 'spec_helper'

describe "Contestdate3rds" do
  describe "GET /contestdate3rds" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get contestdate3rds_path
      response.status.should be(200)
    end
  end
end
