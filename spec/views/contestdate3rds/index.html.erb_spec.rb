require 'spec_helper'

describe "contestdate3rds/index" do
  before(:each) do
    assign(:contestdate3rds, [
      stub_model(Contestdate3rd,
        :order => 1,
        :place => "Place"
      ),
      stub_model(Contestdate3rd,
        :order => 1,
        :place => "Place"
      )
    ])
  end

  it "renders a list of contestdate3rds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Place".to_s, :count => 2
  end
end
